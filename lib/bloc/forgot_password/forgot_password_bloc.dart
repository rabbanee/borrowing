import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:borrowing/models/models.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const ForgotPasswordState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is ForgotPasswordSubmitted) {
      yield* _mapForgotPasswordSubmittedToState(event, state);
    }
  }

  ForgotPasswordState _mapEmailChangedToState(
    ForgotPasswordEmailChanged event,
    ForgotPasswordState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmittedToState(
    ForgotPasswordSubmitted event,
    ForgotPasswordState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        String response = await _authenticationRepository.resetPassword(
          email: state.email.value,
        );
        if (response == 'error') {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        } else {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
