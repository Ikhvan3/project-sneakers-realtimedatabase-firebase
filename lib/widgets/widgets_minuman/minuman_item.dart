import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/cart.dart';

import 'package:menu_makanan/providers/minuman/product_minuman.dart';
import 'package:menu_makanan/screens/minuman_screen/minuman_detail_screen.dart';
import 'package:provider/provider.dart';

class MinumanItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<DaftarMinuman>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  MinumanDetailScreen.routeName,
                  arguments: product.name,
                );
              },
              child: Image.asset(
                product.imageAsset.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  width: 200,
                  color: Color.fromARGB(255, 0, 174, 145),
                  child: Text(
                    product.name.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
              GridTileBar(
                backgroundColor: Color.fromARGB(255, 0, 200, 167),
                leading: Consumer<DaftarMinuman>(
                  builder: (context, productData, child) => IconButton(
                    icon: (productData.isFavorite)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border_outlined),
                    color: Colors.white,
                    onPressed: () {
                      productData.statusFav();
                    },
                  ),
                ),
                title: Text(
                  "\Rp ${cart.formatHarga(product.price!)}",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
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
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
