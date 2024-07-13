import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/makanan/all_products.dart';
import 'makanan_item.dart';

class MakananGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<DaftarMakanans>(context);

    final allproduct = productData.allMakanan;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: allproduct.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: allproduct[i],
        child: MakananItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 13,
        mainAxisSpacing: 0,
      ),
    );
  }
}
