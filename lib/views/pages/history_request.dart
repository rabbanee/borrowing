part of '../views.dart';

class HistoryRequestPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HistoryRequestPage());
  }

  @override
  _HistoryRequestPageState createState() => _HistoryRequestPageState();
}

class _HistoryRequestPageState extends State<HistoryRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Request'),
        backgroundColor: Colors.purple[700],
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.chat_outlined,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.notifications_none_rounded,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      drawer: Hamburger(route: 'History'),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.purple[700],
                      Colors.purple[700],
                      Colors.purple[400]
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Recent(
                        isPage: true,
                        page: 1,
                        perPage: 10,
                        title: 'History Request'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
