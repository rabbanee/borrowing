import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:borrowing/models/models.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterCPasswordChanged) {
      yield _mapCPasswordChangedToState(event, state);
    } else if (event is RegisterParentEmailChanged) {
      yield _mapParentEmailChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  RegisterState _mapNameChangedToState(
      RegisterNameChanged event,
      RegisterState state,
      ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([name, state.password, state.email, state.cPassword, state.parentEmail]),
    );
  }

  RegisterState _mapEmailChangedToState(
    RegisterEmailChanged event,
    RegisterState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.name, state.password, email, state.cPassword, state.parentEmail]),
    );
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([state.name, password, state.email, state.cPassword, state.parentEmail]),
    );
  }

  RegisterState _mapCPasswordChangedToState(
    RegisterCPasswordChanged event,
    RegisterState state,
  ) {
    final cPassword = Password.dirty(event.cPassword);
    return state.copyWith(
      cPassword: cPassword,
      status: Formz.validate([state.name, state.password, state.email, cPassword, state.parentEmail]),
    );
  }

  RegisterState _mapParentEmailChangedToState(
    RegisterParentEmailChanged event,
    RegisterState state,
  ) {
    final parentEmail = Email.dirty(event.parentEmail);
    return state.copyWith(
      parentEmail: parentEmail,
      status: Formz.validate([state.name, state.password, state.email, state.cPassword, parentEmail]),
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.register(
          name: state.name.value,
          email: state.email.value,
          password: state.password.value,
          role: state.role,
          parentEmail: state.parentEmail.value
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
