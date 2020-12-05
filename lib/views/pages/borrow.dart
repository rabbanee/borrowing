part of '../views.dart';

class BorrowPage extends StatelessWidget {
  final String borrow;

  BorrowPage({Key key, @required this.borrow}) : super(key: key);

  static Route route(borrow) {
    return MaterialPageRoute<void>(
      builder: (_) => BorrowPage(
        borrow: borrow,
      ), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: BlocProvider(
            create: (context) {
              return BorrowBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: BorrowForm(
              borrow: borrow,
            ),
          ),
        ),
      ),
    );
  }
}
