import 'package:formz/formz.dart';

enum ReasonValidationError { empty }

class Reason extends FormzInput<String, ReasonValidationError> {
  const Reason.pure() : super.pure('');
  const Reason.dirty([String value = '']) : super.dirty(value);

  @override
  ReasonValidationError validator(String value) {
    return value.trim()?.isNotEmpty == true
        ? null
        : ReasonValidationError.empty;
  }
}
