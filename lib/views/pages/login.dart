part of '../views.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
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
                  return LoginBloc(
                    authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                  );
                },
                child: LoginForm(),
              ),
            ),
          ),
        ],
      )
    );
  }
}
