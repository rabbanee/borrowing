part of '../views.dart';

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  LoaningHistory _recentRequest;
  bool isLoading = false;

  Future getRecentRequest({page = 1}) async {
    var result = await getHistoryLoaning(page: page, perPage: 3);
    print('result: $result');
    setState(() {
      _recentRequest = result;
    });

    setState(() {
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
      // TO DO: get list approval for musyrif or teacher
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
      return Expanded(
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.data.role[0] == 'student' ? 'Recent Request' : ''}',
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  _recentRequest != null
                      ? listRecent(_recentRequest.data.data)
                      : shimmer(isLoading)
                ],
              ),
            ),
          ),
        ),
      );
    });
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
        itemCount: 3,
      ),
    ),
  );
}

Widget listRecent(list) {
  if (list.length > 0) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int i) {
              return Container(
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
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Text(
                          '${list[i].approved == null ? 'Pending' : list[i].approved ? 'Approved' : 'Rejected'}',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      ],
    );
  } else {
    return Text('Empty Guys');
  }
}
