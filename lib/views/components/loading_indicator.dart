part of '../views.dart';

class LoadingIndicator extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator());
}
