part of 'borrow_bloc.dart';

class BorrowState extends Equatable {
  const BorrowState({
    this.status = FormzStatus.pure,
    this.reason = const Reason.pure(),
    this.necessity = '',
    this.borrowDate = const BorrowDate.pure(),
    this.teacherInCharge = const TeacherInCharge.pure(),
  });

  final FormzStatus status;
  final Reason reason;
  final String necessity;
  final BorrowDate borrowDate;
  final TeacherInCharge teacherInCharge;

  BorrowState copyWith({
    FormzStatus status,
    Reason reason,
    String necessity,
    TeacherInCharge teacherInCharge,
    BorrowDate borrowDate,
  }) {
    return BorrowState(
      status: status ?? this.status,
      reason: reason ?? this.reason,
      necessity: necessity ?? this.necessity,
      teacherInCharge: teacherInCharge ?? this.teacherInCharge,
      borrowDate: borrowDate ?? this.borrowDate,
    );
  }

  @override
  List<Object> get props =>
      [status, reason, necessity, teacherInCharge, borrowDate];
}
