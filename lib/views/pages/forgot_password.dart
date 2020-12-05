part of '../views.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ForgotPasswordPage());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Container(
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
        ],
      ),
    );
  }
}
