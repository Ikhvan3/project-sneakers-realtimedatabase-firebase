import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/makanan/all_products.dart';
import 'package:menu_makanan/providers/cart.dart';
import 'package:provider/provider.dart';

import '../../widgets/badge.dart';
import '../cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/makanan-detail';

  @override
  Widget build(BuildContext context) {
    final name =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!

    final product = Provider.of<DaftarMakanans>(context).findById(name);
    final cart = Provider.of<Cart>(context);
    // ...
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Makanan',
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 126, 255, 242),
              Color.fromARGB(255, 238, 238, 238),
            ])),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                "${product.imageAsset}",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${product.name}",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\Rp ${cart.formatHarga(product.price!)}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${product.description}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
