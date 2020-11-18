part of '../views.dart';

class LoadingIndicator extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoadingIndicator());
  }

  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator());
}
