import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/auth.dart';
import 'package:menu_makanan/providers/brandhome.dart';
import 'package:menu_makanan/providers/makanan/all_products.dart';
import 'package:menu_makanan/providers/cart.dart';
import 'package:menu_makanan/providers/minuman/daftar_minuman.dart';
import 'package:menu_makanan/screens/auth_page.dart';
import 'package:menu_makanan/screens/cart_screen.dart';
import 'package:menu_makanan/screens/home_screen.dart';
import 'package:menu_makanan/screens/makanan_screen/makanan_overview_screen.dart';
import 'package:menu_makanan/screens/minuman_screen/minuman_detail_screen.dart';
import 'package:menu_makanan/screens/minuman_screen/minuman_overview_screen.dart';
import 'package:menu_makanan/screens/sneakers_detail_screen.dart';
import 'package:provider/provider.dart';

import 'screens/makanan_screen/makanan_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Authen(),
        ),
        ChangeNotifierProvider(
          create: (context) => DaftarMakanans(),
        ),
        ChangeNotifierProvider(
          create: (context) => DaftarMinumans(),
        ),
        ChangeNotifierProxyProvider<Authen, Cart>(
          create: (context) => Cart(),
          update: (context, auth, cart) =>
              cart!..updateData(auth.token, auth.userId),
        ),
      ],
      builder: (context, child) => Consumer<Authen>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            hintColor: Color.fromARGB(255, 255, 255, 255),
          ),
          home: auth.isAuthe
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return LoginScreen();
                  },
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            MinumanDetailScreen.routeName: (cxt) => MinumanDetailScreen(),
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            MinumanOverviewScreen.routeName: (ctx) => MinumanOverviewScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            DetailScreenSneakers.routeName: (ctx) => DetailScreenSneakers(),
          },
        ),
      ),
    );
  }
}
