import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_makanan/providers/auth.dart';
import 'package:menu_makanan/providers/brandhome.dart';
import 'package:menu_makanan/screens/makanan_screen/makanan_overview_screen.dart';
import 'package:menu_makanan/screens/minuman_screen/minuman_overview_screen.dart';
import 'package:provider/provider.dart';

import '../models/brandhome_item.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Cart>(context).initialDataGet();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  String selectedBrand = 'Nike';

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeProvider>(context);
    final List<Shoe> shoesByBrand = shoeProvider.getShoesByBrand(selectedBrand);

    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.10),
          ),
          color: Color.fromARGB(255, 0, 212, 177),
          elevation: 5,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color.fromARGB(255, 251, 249, 249),
                    size: 30,
                  ),
                ),

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
                    icon: Icon(
                        color: Color.fromARGB(255, 255, 255, 255),
                        Icons.shopping_cart),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30,
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () =>
                      Provider.of<Authen>(context, listen: false).logout(),
                  icon: Icon(color: Colors.white, Icons.logout),
                ),
                // IconButton(
                //   icon: Icon(Icons.account_circle_outlined),
                //   iconSize: 30,
                //   color: const Color.fromARGB(255, 10, 10, 10),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 238, 238, 238),
                Color.fromARGB(255, 126, 255, 242),
              ])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bunch Sneakers",
                        style: TextStyle(
                          fontSize: 20,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 212, 177),
                              blurRadius: 2,
                            )
                          ],
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 212, 177),
                        ),
                      ),
                    ),
                    Consumer<Cart>(
                      builder: (context, value, ch) {
                        return BadgeW(
                          child: ch!,
                          value: value.jumlah.toString(),
                        );
                      },
                      child: IconButton(
                        iconSize: 35,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            CartScreen.routeName,
                          );
                        },
                        icon: Icon(
                            color: Color.fromARGB(255, 0, 212, 177),
                            Icons.shopping_cart),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromARGB(255, 0, 212, 177),
                  elevation: 4,
                  child: Container(
                    child: Image.asset("images/bg_s.png"),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.start,
                      "Categories",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['Nike', 'Converse', 'Vans'].map((brand) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBrand = brand;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 178, 178, 178),
                                  offset: Offset(0, 1),
                                  blurRadius: 0,
                                )
                              ],
                              color: selectedBrand == brand
                                  ? Color.fromARGB(255, 0, 212, 177)
                                  : Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              brand,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 91, 91, 91),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 800,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(25.0),
                    itemCount: shoesByBrand.length,
                    itemBuilder: (ctx, i) => GridTile(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductsOverviewScreen.routeName,
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color.fromARGB(255, 0, 212, 177),
                            elevation: 3,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 252, 251, 251),
                                          blurRadius: 0.0,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Image.asset(
                                    shoesByBrand[i].imageAsset,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      shoesByBrand[i].name,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 14,
                                        fontFamily: 'Staatliches',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Text(
                                        '\Rp ${cart.formatHarga(shoesByBrand[i].price)}',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 251, 250, 250),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Berhasil Ditambahkan"),
                                            duration:
                                                Duration(milliseconds: 1000),
                                          ),
                                        );
                                        cart.addCart(
                                          shoesByBrand[i].id.toString(),
                                          shoesByBrand[i].name.toString(),
                                          shoesByBrand[i].price,
                                          shoesByBrand[i].imageAsset,
                                        );
                                      },
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      //
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 00.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
