part of 'borrow_bloc.dart';

abstract class BorrowEvent extends Equatable {
  const BorrowEvent();

  @override
  List<Object> get props => [];
}

class BorrowReasonChanged extends BorrowEvent {
  const BorrowReasonChanged(this.reason);

  final String reason;

  @override
  List<Object> get props => [reason];
}

class BorrowDateChanged extends BorrowEvent {
  BorrowDateChanged(this.borrowDate);

  final String borrowDate;

  @override
  List<Object> get props => [borrowDate];
}

class BorrowNecessityChanged extends BorrowEvent {
  BorrowNecessityChanged(this.necessity);

  final String necessity;

  @override
  List<Object> get props => [necessity];
}

class BorrowTeacherInChargeChanged extends BorrowEvent {
  const BorrowTeacherInChargeChanged(this.teacherInCharge);

  final String teacherInCharge;

  @override
  List<Object> get props => [teacherInCharge];
}

class BorrowSubmitted extends BorrowEvent {
  const BorrowSubmitted();
}
