import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/functions/user_location_input_screen_functions.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/validators/location_input_validator.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';

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
          TextFormField(
            decoration: const InputDecoration(
                hintText: "City name, address, coordinates"),
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.search,
            controller: _locationInputTEController,
            onFieldSubmitted: (value) =>
                UserLocationInputScreenFunctions.onSearchButtonClick(
              formKey: _formKey,
              context: context,
            ),
            validator: (value) => LocationInputValidator.validateInput(
              userInput: value,
            ),
          ),
          const SizedBox(height: 15),
          _buildSearchButton(),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () => UserLocationInputScreenFunctions.onSearchButtonClick(
          formKey: _formKey,
          context: context,
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppColor.backgroundGreenColor,
          ),
          foregroundColor: WidgetStatePropertyAll(
            AppColor.backgroundWhiteColor,
          ),
        ),
        child: const Text("Search"),
      ),
    );
  }
}
