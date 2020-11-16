import 'package:formz/formz.dart';
import 'package:email_validator/email_validator.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError validator(String value) {
    if (value.isEmpty == true) {
      return EmailValidationError.empty;
    }

    return EmailValidator.validate(value) ? null : EmailValidationError.invalid;
  }
}
