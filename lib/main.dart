import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/userproducts_screen.dart';

import 'helpers/custom_route.dart';
import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/home_page.dart';
import 'screens/orders_screen.dart';
import 'screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => AppAuthProvider()),
  ]
, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your One Stop Food Place',
      theme: themeForApp(),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        ProductDetail.routeName: (context) => const ProductDetail(),
        CartScreen.routeName: (context) => const CartScreen(),
        OrdersScreen.routeName: (context) => const OrdersScreen(),
        UserProductsScreen.routeName: (context) =>
            const UserProductsScreen(),
        EditProductScreen.routeName: (context) => EditProductScreen(),
      },
    );
  }

  ThemeData themeForApp() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
          .copyWith(secondary: Colors.red),
      fontFamily: "Lato",
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      }),
    );
  }
}
