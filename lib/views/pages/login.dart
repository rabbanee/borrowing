part of '../views.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        print('state status: ${state.status}');
        return state.status == AuthenticationStatus.loading
            ? LoadingIndicator()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: BlocProvider(
                      create: (context) {
                        return LoginBloc(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context),
                        );
                      },
                      child: LoginForm(),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
