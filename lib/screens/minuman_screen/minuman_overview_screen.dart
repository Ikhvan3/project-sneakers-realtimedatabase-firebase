import 'package:menu_makanan/widgets/widgets_minuman/minuman_grid.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../widgets/badge.dart';
import 'package:flutter/material.dart';

import '../cart_screen.dart';

class MinumanOverviewScreen extends StatefulWidget {
  static const routeName = '/makanan-overview';

  @override
  State<MinumanOverviewScreen> createState() => _MinumanOverviewScreenState();
}

class _MinumanOverviewScreenState extends State<MinumanOverviewScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Cart>(context).initialDataGet();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Minuman',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 174, 145),
        actions: [
          Consumer<Cart>(
            builder: (context, value, ch) {
              return BadgeW(
                child: ch!,
                value: value.jumlah.toString(),
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CartScreen.routeName,
                );
              },
              icon: Icon(color: Colors.white, Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 126, 255, 242),
                Color.fromARGB(255, 238, 238, 238),
              ])),
          child: MinumanGrid()),
    );
  }
}
