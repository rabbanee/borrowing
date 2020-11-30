import 'package:formz/formz.dart';

enum TeacherInChargeValidationError { empty }

class TeacherInCharge
    extends FormzInput<String, TeacherInChargeValidationError> {
  const TeacherInCharge.pure() : super.pure('');
  const TeacherInCharge.dirty([String value = '']) : super.dirty(value);

  @override
  TeacherInChargeValidationError validator(String value) {
    return value.trim()?.isNotEmpty == true
        ? null
        : TeacherInChargeValidationError.empty;
  }
}
