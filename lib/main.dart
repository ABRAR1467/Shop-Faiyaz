import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'helpers/custom_route.dart';
import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/home_page.dart';
import 'screens/orders_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => AppAuthProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your One Stop Food Place',
      navigatorKey: MyApp.navKey,
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AuthScreen.routeName:
            return CustomRoute(
              page: AuthScreen(),
              settings: settings,
            );

          case SplashScreen.routeName:
            return CustomRoute(
              page: SplashScreen(),
              settings: settings,
            );

          case HomePage.routeName:
            return CustomRoute(
              page: HomePage(),
              settings: settings,
            );

          case ProductDetail.routeName:
            return CustomRoute(
              page: ProductDetail(
                product: settings.arguments as ProductModel,
              ),
              settings: settings,
            );

          case CartScreen.routeName:
            return CustomRoute(
              page: CartScreen(),
              settings: settings,
            );

          case OrdersScreen.routeName:
            return CustomRoute(
              page: OrdersScreen(),
              settings: settings,
            );
          case EditProductScreen.routeName:
            return CustomRoute(
              page: EditProductScreen(
                product: settings.arguments as ProductModel,
              ),
              settings: settings,
            );
        }
      },
      // routes: {
      //   AuthScreen.routeName: (context) => const AuthScreen(),
      //   SplashScreen.routeName: (context) => const SplashScreen(),
      //   HomePage.routeName: (context) => const HomePage(),
      //   ProductDetail.routeName: (context) => ProductDetail(),
      //   CartScreen.routeName: (context) => const CartScreen(),
      //   OrdersScreen.routeName: (context) => const OrdersScreen(),
      //   UserProductsScreen.routeName: (context) =>
      //       const UserProductsScreen(),
      //   EditProductScreen.routeName: (context) => EditProductScreen(),
      // },
    );
  }
}