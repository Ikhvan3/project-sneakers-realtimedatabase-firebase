import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/auth.dart';
import 'package:menu_makanan/providers/brandhome.dart';
import 'package:menu_makanan/providers/favorite.dart';
import 'package:menu_makanan/providers/cart.dart';
import 'package:menu_makanan/screens/auth_page.dart';
import 'package:menu_makanan/screens/cart_screen.dart';
import 'package:menu_makanan/screens/favoritescreen.dart';
import 'package:menu_makanan/screens/home_screen.dart';
import 'package:menu_makanan/screens/search_screen.dart';
import 'package:menu_makanan/screens/sneakers_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Authen(),
        ),
        ChangeNotifierProxyProvider<Authen, Favorite>(
          create: (context) => Favorite(),
          update: (context, auth, previous) =>
              previous!..updateAuthData(auth.token, auth.userId),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoeProvider(),
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
            CartScreen.routeName: (ctx) => CartScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            DetailScreenSneakers.routeName: (ctx) => DetailScreenSneakers(),
            FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
          },
        ),
      ),
    );
  }
}
