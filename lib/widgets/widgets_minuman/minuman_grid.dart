import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/minuman/daftar_minuman.dart';
import 'package:provider/provider.dart';

import 'minuman_item.dart';

class MinumanGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<DaftarMinumans>(context);

    final allproduct = productData.allMinuman;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: allproduct.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: allproduct[i],
        child: MinumanItem(),
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
