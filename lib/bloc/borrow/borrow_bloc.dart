import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:borrowing/models/reason.dart';
import 'package:borrowing/view_models/view_models.dart';
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
    } else if (event is BorrowNecessityChanged) {
      yield _mapNecessityChangedToState(event, state);
    } else if (event is BorrowSubmitted) {
      yield* _mapBorrowSubmittedToState(event, state);
    }
  }

  BorrowState _mapNecessityChangedToState(
    BorrowNecessityChanged event,
    BorrowState state,
  ) {
    final necessity = event.necessity;
    final nowDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
    return state.borrowDate.value != nowDate
        ? state.copyWith(
            necessity: necessity,
            status: Formz.validate([
              state.teacherInCharge,
              state.borrowDate,
            ]),
          )
        : state.copyWith(
            necessity: necessity,
            status: Formz.validate(
              [
                state.teacherInCharge,
                state.reason,
                state.borrowDate,
              ],
            ));
  }

  BorrowState _mapDateChangedToState(
    BorrowDateChanged event,
    BorrowState state,
  ) {
    final borrowDate = BorrowDate.dirty(event.borrowDate);
    final nowDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
    return event.borrowDate != nowDate
        ? state.copyWith(
            borrowDate: borrowDate,
            status: Formz.validate([
              state.teacherInCharge,
              borrowDate,
            ]),
          )
        : state.copyWith(
            borrowDate: borrowDate,
            status: Formz.validate(
              [
                state.teacherInCharge,
                state.reason,
                borrowDate,
              ],
            ));
  }

  BorrowState _mapTeacherInChargeChangedToState(
    BorrowTeacherInChargeChanged event,
    BorrowState state,
  ) {
    final teacherInCharge = TeacherInCharge.dirty(event.teacherInCharge);
    final nowDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
    return state.borrowDate.value != nowDate
        ? state.copyWith(
            teacherInCharge: teacherInCharge,
            status: Formz.validate([
              teacherInCharge,
              state.borrowDate,
            ]),
          )
        : state.copyWith(
            teacherInCharge: teacherInCharge,
            status: Formz.validate(
              [
                teacherInCharge,
                state.reason,
                state.borrowDate,
              ],
            ));
  }

  BorrowState _mapReasonChangedToState(
    BorrowReasonChanged event,
    BorrowState state,
  ) {
    final reason = Reason.dirty(event.reason);
    return state.copyWith(
      reason: reason,
      status: Formz.validate([reason, state.teacherInCharge, state.borrowDate]),
    );
  }

  Stream<BorrowState> _mapBorrowSubmittedToState(
    BorrowSubmitted event,
    BorrowState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        print('necessity: ${state.necessity}');
        final isSuccess = await requestBorrow(
          necessity: state.necessity,
          borrowDate: state.borrowDate,
          reason: state.reason,
          teacherInCharge: state.teacherInCharge,
        );
        if (isSuccess) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
