part of '../views.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(172, 13, 206, 1),
      body: Center(
        child: Image.asset(
          'assets/images/logo_transparent_white.png',
          width: 150,
        ),
      ),
    );
  }
}
