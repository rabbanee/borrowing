import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:borrowing/models/reason.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:borrowing/models/models.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'borrow_event.dart';
part 'borrow_state.dart';

class BorrowBloc extends Bloc<BorrowEvent, BorrowState> {
  BorrowBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const BorrowState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<BorrowState> mapEventToState(
    BorrowEvent event,
  ) async* {
    if (event is BorrowReasonChanged) {
      yield _mapReasonChangedToState(event, state);
    } else if (event is BorrowTeacherInChargeChanged) {
      yield _mapTeacherInChargeChangedToState(event, state);
    } else if (event is BorrowDateChanged) {
      yield _mapDateChangedToState(event, state);
    } else if (event is BorrowSubmitted) {
      yield* _mapBorrowSubmittedToState(event, state);
    }
  }

  BorrowState _mapDateChangedToState(
    BorrowDateChanged event,
    BorrowState state,
  ) {
    final borrowDate = BorrowDate.dirty(event.borrowDate);
    return state.copyWith(
      borrowDate: borrowDate,
      status: Formz.validate([state.teacherInCharge, state.reason]),
    );
  }

  BorrowState _mapTeacherInChargeChangedToState(
    BorrowTeacherInChargeChanged event,
    BorrowState state,
  ) {
    final teacherInCharge = TeacherInCharge.dirty(event.teacherInCharge);
    return state.copyWith(
      teacherInCharge: teacherInCharge,
      status: Formz.validate([teacherInCharge, state.reason]),
    );
  }

  BorrowState _mapReasonChangedToState(
    BorrowReasonChanged event,
    BorrowState state,
  ) {
    final reason = Reason.dirty(event.reason);
    return state.copyWith(
      reason: reason,
      status: Formz.validate([reason]),
    );
  }

  Stream<BorrowState> _mapBorrowSubmittedToState(
    BorrowSubmitted event,
    BorrowState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        print('masuk');
        // String response = await _authenticationRepository.logIn(
        //   email: state.email.value,
        //   password: state.password.value,
        // );
        // if (response == 'error') {
        //   yield state.copyWith(status: FormzStatus.submissionFailure);
        // }

        // if (response == 'success') {
        //   yield state.copyWith(status: FormzStatus.submissionInProgress);
        // }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
