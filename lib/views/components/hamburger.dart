part of '../views.dart';

class Hamburger extends StatefulWidget {
  Hamburger({Key key, @required this.route}) : super(key: key);
  final String route;
  @override
  _HamburgerState createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  // String widget.route = 'Home';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Builder(
            builder: (context) {
              final user = context.select(
                (AuthenticationBloc bloc) => bloc.state.user,
              );
              return UserAccountsDrawerHeader(
                accountName: new Text('${user.data.name}'),
                accountEmail: new Text('${user.data.email}'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pinjaman-api.herokuapp.com/api/file/image/${user.data.avatarId}"),
                ),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              print('masuk: ${widget.route}');
              if (widget.route == 'Home') {
                Navigator.pop(context);
              } else {
                // setState(() => widget.route = 'Home');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              print('masuk');
              if (widget.route == 'History') {
                Navigator.pop(context);
              } else {
                // setState(() => widget.route = 'History');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryRequestPage()),
                  (route) => false,
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
