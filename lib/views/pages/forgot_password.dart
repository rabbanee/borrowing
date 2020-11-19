part of '../views.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ForgotPasswordPage());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: BlocProvider(
            create: (context) {
              return ForgotPasswordBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: ForgotPasswordForm(),
          ),
        ),
      ),
    );
  }
}
