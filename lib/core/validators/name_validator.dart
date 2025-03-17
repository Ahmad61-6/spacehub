class NameValidator {
  static String? validate(
    String? value, {
    int minLength = 2,
    int maxLength = 50,
    bool allowNumbers = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < minLength) {
      return 'Name must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Name cannot exceed $maxLength characters';
    }

    final validCharacters = RegExp(allowNumbers
            ? r"^[a-zA-ZÀ-ÿ\s'0-9-]+$" // Hyphen at the end
            : r"^[a-zA-ZÀ-ÿ\s'-]+$" // Hyphen escaped with backslash
        );

    if (!validCharacters.hasMatch(value)) {
      return 'Invalid characters in name';
    }

    return null;
  }
}
