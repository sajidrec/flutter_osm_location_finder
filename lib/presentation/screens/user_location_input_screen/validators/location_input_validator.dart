class LocationInputValidator {
  static String? validateInput({
    required String? userInput,
  }) {
    if (userInput == null) {
      return "Enter location like city name, address, coordinates.";
    }
    if (userInput.isEmpty) {
      return "Enter location like city name, address, coordinates.";
    }
    return null;
  }
}
