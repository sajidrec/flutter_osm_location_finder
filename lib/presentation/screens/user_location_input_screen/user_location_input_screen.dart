import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/validators/location_input_validator.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';
import 'package:flutter_osm_location_marker/state_holder/user_location_input_screen_controller.dart';
import 'package:get/get.dart';

class UserLocationInputScreen extends StatefulWidget {
  const UserLocationInputScreen({super.key});

  @override
  State<UserLocationInputScreen> createState() =>
      _UserLocationInputScreenState();
}

class _UserLocationInputScreenState extends State<UserLocationInputScreen> {
  final TextEditingController _locationInputTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _locationInputTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSearchForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          GetBuilder<UserLocationInputScreenController>(
              builder: (userLocationInputScreenController) {
            return TextFormField(
              decoration: const InputDecoration(
                  hintText: "City name, address, coordinates"),
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.search,
              controller: _locationInputTEController,
              onFieldSubmitted: (value) =>
                  userLocationInputScreenController.onSearchButtonClick,
              validator: (value) => LocationInputValidator.validateInput(
                userInput: value?.trim(),
              ),
            );
          }),
          const SizedBox(height: 15),
          _buildSearchButton(),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
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
