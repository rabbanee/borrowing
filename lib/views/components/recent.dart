part of '../views.dart';

class Recent extends StatefulWidget {
  Recent(
      {Key key,
      @required this.isPage,
      @required this.page,
      @required this.perPage,
      @required this.title})
      : super(key: key);
  final bool isPage;
  final String title;
  final int page;
  final int perPage;
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  List<dynamic> _historyRequest = [];
  int _currentPage = 1;
  int _lastPage = 0;
  bool tes = true;
  bool isLoading = false;

  Future getRecentRequest({page: 1}) async {
    if (_currentPage == _lastPage) {
      return;
    }
    var result = await getHistoryLoaning(page: page, perPage: widget.perPage);
    setState(() {
      _historyRequest.addAll(result.data.data);
      _lastPage = result.data.lastPage;
      isLoading = false;
    });
  }

  Future getHistoryTeacher() async {
    var result = await getLoaningHistoryTeacher();
    setState(() {
      _historyRequest.addAll(result.data);
      _lastPage = 1;
      tes = false;
      isLoading = false;
    });
  }

  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    if (user.data.role[0] == 'student') {
      getRecentRequest();
    } else {
      getHistoryTeacher();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Expanded(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                widget.isPage == true) {
              getRecentRequest(page: _currentPage + 1);
              setState(() {
                isLoading = true;
                _currentPage = _currentPage + 1;
              });
            }
          },
          child: SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Container(
                height: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                          color: Colors.purple[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    _lastPage > 0
                        ? listRecent(_historyRequest)
                        : shimmer(isLoading)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget listRecent(list) {
    if (list.length > 0) {
      return Expanded(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          // physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (direction) =>
                      tes ? dismissibleAction(direction, context, list[i])
                      : dismissibleActionTeacher(direction, context, list[i]),
                    background: Container(
                      color: Colors.green,
                      child: Align(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            Text(
                              " Return",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    key: Key(i.toString()),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[200]),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text('${i + 1}',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text('${list[i].necessity}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Column(
                            children: [
                              Text('${list[i].created}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              Text(
                                '${list[i].approved == null ? 'Pending' : list[i].approved ? 'Approved' : 'Rejected'}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: list.length,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text('Empty Guys');
    }
  }

  Widget shimmer(enabled) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: enabled,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 18.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 18.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 18.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: widget.perPage,
        ),
      ),
    );
  }
}

Future<bool> dismissibleAction(direction, context, list) async {
  if (direction == DismissDirection.startToEnd && list.approved != true) {
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "You can't return because borrowing status is not approved!"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    return res;
  } else {
    print('clicked!');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnPage(
          borrowingId: list.id.toString(),
        ),
      ),
    );
  }
  return false;
}

Future<bool> dismissibleActionTeacher(direction, context, list) async {
  if (direction == DismissDirection.startToEnd && list.approved == true) {
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "You can't return because borrowing status is not approved!"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    return res;
  } else {
    print('clicked!');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApprovePage(
          borrowingId: list.id.toString(),
          pass: 'Approve',
        ),
      ),
    );
  }
  return false;
}
