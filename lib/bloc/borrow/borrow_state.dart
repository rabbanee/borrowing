part of 'borrow_bloc.dart';

class BorrowState extends Equatable {
  const BorrowState({
    this.status = FormzStatus.pure,
    this.reason = const Reason.pure(),
    this.borrowDate = const BorrowDate.pure(),
    this.teacherInCharge = const TeacherInCharge.pure(),
  });

  final FormzStatus status;
  final Reason reason;
  final BorrowDate borrowDate;
  final TeacherInCharge teacherInCharge;

  BorrowState copyWith({
    FormzStatus status,
    Reason reason,
    TeacherInCharge teacherInCharge,
    BorrowDate borrowDate,
  }) {
    return BorrowState(
      status: status ?? this.status,
      reason: reason ?? this.reason,
      teacherInCharge: teacherInCharge ?? this.teacherInCharge,
      borrowDate: borrowDate ?? this.borrowDate,
    );
  }

  @override
  List<Object> get props => [status, reason, teacherInCharge, borrowDate];
}
