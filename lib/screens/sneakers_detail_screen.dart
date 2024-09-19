import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_makanan/models/brandhome_item.dart';
import 'package:menu_makanan/providers/brandhome.dart';
import 'package:menu_makanan/providers/cart.dart';
import 'package:provider/provider.dart';

import '../../widgets/badge.dart';
import '../providers/favorite.dart';
import 'cart_screen.dart';

class DetailScreenSneakers extends StatelessWidget {
  static const routeName = '/sneakers-detail';

  String selectedBrand = 'Nike';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final product =
        Provider.of<ShoeProvider>(context, listen: false).findById(id);
    final cart = Provider.of<Cart>(context, listen: false);
    final favorite = Provider.of<Favorite>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETAIL SNEAKERS',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
              icon: Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.shopping_cart),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color.fromARGB(255, 0, 212, 177),
          elevation: 3,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\Rp ${cart.formatHarga(product.price)}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Color.fromARGB(255, 229, 229, 229)),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil Ditambahkan"),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                      cart.addCart(
                        product.id.toString(),
                        product.name.toString(),
                        product.price,
                        product.imageAsset,
                      );
                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 212, 177),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
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
                Color.fromARGB(255, 126, 255, 242),
                Color.fromARGB(255, 238, 238, 238),
              ])),
          child: Consumer<ShoeProvider>(
            builder: (context, shoeProvider, child) {
              final List<Shoe> shoesByBrand =
                  shoeProvider.getShoesByBrand(selectedBrand);

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      product.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: const Color.fromARGB(255, 206, 206, 206),
                          )
                        ],
                        color: Color.fromARGB(255, 242, 242, 242),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Consumer<Favorite>(
                                builder: (ctx, fav, _) => IconButton(
                                  icon: Icon(
                                    size: 40,
                                    fav.favorites.containsKey(product.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Color.fromARGB(255, 0, 167, 139),
                                  ),
                                  onPressed: () {
                                    if (favorite.isInitialized) {
                                      favorite.addFavorite(
                                        product.id.toString(),
                                        product.name,
                                        product.price,
                                        product.imageAsset,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please log in to add favorites')),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              product.desc,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 55),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
