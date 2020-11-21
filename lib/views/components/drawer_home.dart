part of '../views.dart';

class DrawerHome extends StatelessWidget {
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
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
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
