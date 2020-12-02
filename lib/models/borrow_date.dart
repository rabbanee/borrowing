import 'package:formz/formz.dart';

enum BorrowDateValidationError { empty }

class BorrowDate extends FormzInput<String, BorrowDateValidationError> {
  const BorrowDate.pure() : super.pure('');
  const BorrowDate.dirty([String value = '']) : super.dirty(value);

  @override
  BorrowDateValidationError validator(String value) {
    return value.trim()?.isNotEmpty == true
        ? null
        : BorrowDateValidationError.empty;
  }
}
