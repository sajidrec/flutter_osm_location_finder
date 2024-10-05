import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/validators/location_input_validator.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/widgets/search_box_button.dart';
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
          SearchBoxButton(
            context: context,
            formKey: _formKey,
            locationInputTEController: _locationInputTEController,
          ),
        ],
      ),
    );
  }
}
