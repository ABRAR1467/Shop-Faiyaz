import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/auth_api.dart';
import 'package:shop_app/helpers/utility.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/home_page.dart';
import '../providers/auth.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello !'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          drawerChildPushReplacementNamed(
            context,
            Icons.shop,
            "Shop",
            HomePage.routeName,
          ),
          const Divider(),
          drawerChildPushReplacementNamed(
            context,
            Icons.payment,
            "Your Orders",
            OrdersScreen.routeName,
          ),
          const Divider(),
          drawerChildPushNamed(
            context,
            Icons.shopping_cart,
            "Your Cart",
            CartScreen.routeName,
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              AuthApi.signOut();
              Navigator.of(context).popAndPushNamed(AuthScreen.routeName,);
              
            },
          )
        ],
      ),
    );
  }

// todo //////////////////////////////////////////////////////////////

  ListTile drawerChildPushNamed(BuildContext context, IconData? icon,
      String title, String destinationRoute) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushNamed(destinationRoute);
      },
    );
  }

  ListTile drawerChildPushReplacementNamed(BuildContext context, IconData? icon,
      String title, String destinationRoute) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(destinationRoute);
      },
    );
  }
}
