import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';
import 'package:flutter_osm_location_marker/state_holder/user_location_input_screen_controller.dart';
import 'package:get/get.dart';

class SearchBoxButton extends StatelessWidget {
  const SearchBoxButton({
    super.key,
    required this.context,
    required GlobalKey<FormState> formKey,
    required TextEditingController locationInputTEController,
  })  : _formKey = formKey,
        _locationInputTEController = locationInputTEController;

  final BuildContext context;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _locationInputTEController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: GetBuilder<UserLocationInputScreenController>(
          builder: (userLocationInputScreenController) {
        return ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState!.validate()) {
              userLocationInputScreenController.onSearchButtonClick(
                address: _locationInputTEController.text.trim(),
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColor.backgroundGreenColor,
            ),
            foregroundColor: WidgetStatePropertyAll(
              AppColor.backgroundWhiteColor,
            ),
          ),
          child: userLocationInputScreenController.inProgress
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.backgroundWhiteColor,
                  ),
                )
              : const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
        );
      }),
    );
  }
}
