part of '../views.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        print('state status: ${state.status}');
        return state.status == AuthenticationStatus.authenticated
            ? LoadingIndicator()
            : Scaffold(
                body: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: BlocProvider(
                          create: (context) {
                            return RegisterBloc(
                              authenticationRepository: RepositoryProvider.of<
                                  AuthenticationRepository>(context),
                            );
                          },
                          child: RegisterForm(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
