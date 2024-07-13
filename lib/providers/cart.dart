// ignore_for_file: collection_methods_unrelated_type

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  String? token, firebaseId;

  void updateData(tokenData, uid) {
    token = tokenData;
    firebaseId = uid;
    notifyListeners();
  }

  String urlMaster = "https://sneakers-e44c4-default-rtdb.firebaseio.com/";

  final Map<String, CartItem> _items = {};
  final Map<String, String> _firebaseIds = {};

  Map<String, CartItem> get items => _items;

  int get jumlah {
    return _items.length;
  }

  String get totalHarga {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.qty * cartItem.price;
    });
    var totalString = formatHarga(total);
    return totalString;
  }

  String formatHarga(double harga) {
    return harga.toStringAsFixed(3).replaceAll(RegExp(r'([]\d)$'), '0');
  }

  Future<void> addCart(
      String id, String name, double price, String imageUrl) async {
    final userId = firebaseId;
    if (_items.containsKey(id)) {
      //keetika sudah tersedia key product id
      _items.update(
        id,
        (value) => CartItem(
          createdAt: value.createdAt,
          name: value.name,
          id: value.id,
          price: value.price,
          qty: value.qty + 1,
          imageUrl: value.imageUrl,
        ),
      );

      //perbarui data di firebase
      final firebaseId = _firebaseIds[id];
      if (firebaseId != null) {
        Uri url = Uri.parse("$urlMaster/cart/$firebaseId.json?auth=$token");

        final response = await http.patch(
          url,
          body: json.encode({
            'qty': _items[id]!.qty,
          }),
        );
      } else {
        print('Error: Firebase ID not found for item ID $id');
      }
    } else {
      //nambah product id baru
      final newCartItem = CartItem(
        createdAt: DateTime.now().toString(),
        name: name,
        id: id,
        price: price,
        qty: 1,
        imageUrl: imageUrl,
      );
      _items.putIfAbsent(id, () => newCartItem);

      //kirim data ke firebase
      Uri url = Uri.parse("$urlMaster/cart.json?auth=$token");

      try {
        final response = await http.post(
          url,
          body: json.encode({
            'name': name,
            'id': id,
            'price': price,
            'qty': 1,
            'createdAt': DateTime.now().toString(),
            'imageUrl': imageUrl,
            'userId': firebaseId,
          }),
        );

        final responseData = json.decode(response.body);
        _firebaseIds[id] = responseData['name'];
      } catch (error) {
        print('Error posting to Firebase: $error');
      }
    }
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    print('Current Firebase IDs: $_firebaseIds');
    // Mendapatkan ID Firebase
    final firebaseId = _firebaseIds[id];
    if (firebaseId == null) {
      print('Error: Item ID not found in Firebase');
      return;
    }
    // Mendapatkan URL Firebase untuk menghapus item
    Uri url = Uri.parse(
      "$urlMaster/cart/$firebaseId.json?auth=$token",
    );

    try {
      // Menghapus data dari Firebase
      final response = await http.delete(url);

      // Menangani respons
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Menghapus data dari Map lokal
        _items.remove(id);
        _firebaseIds.remove(id);

        // Memberitahu UI untuk memperbarui tampilan
        notifyListeners();
      } else {
        // Penanganan kesalahan jika penghapusan data dari Firebase gagal
        print('Error deleting from Firebase: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting from Firebase: $error');
    }
  }

  Future<void> initialDataGet() async {
    if (firebaseId == null) {
      print("Error: firebaseId is null.");
      return;
    }
    if (token == null) {
      print("Error: token is null.");
      return;
    }
    print("Fetching data for user: $firebaseId with token: $token");

    Uri url = Uri.parse(
        '$urlMaster/cart.json?auth=$token&orderBy="userId"&equalTo="$firebaseId"');
    try {
      var hasilGetData = await http.get(url);
      if (hasilGetData.statusCode < 200 || hasilGetData.statusCode >= 300) {
        throw (hasilGetData.statusCode);
      } else {
        if (hasilGetData.body == null || hasilGetData.body.isEmpty) {
          print("Tidak ada data yang ditemukan dalam respons.");
          return;
        }
        var dataResponse = json.decode(hasilGetData.body);

        if (dataResponse == null) {
          print("Data adalah null.");
          return;
        }
        if (dataResponse is! Map<String, dynamic>) {
          print("Data bukan tipe Map<String, dynamic>.");
          return;
        }

        _items
            .clear(); // Clear existing items to ensure only the current user's items are loaded
        _firebaseIds.clear(); // Clear existing Firebase IDs

        var cartData = dataResponse as Map<String, dynamic>;

        cartData.forEach((key, value) {
          DateTime dateTimeParse =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(value["createdAt"]);

          _items.putIfAbsent(
              value['id'],
              () => CartItem(
                    id: value['id'],
                    createdAt: dateTimeParse.toString(),
                    price: value["price"],
                    qty: value["qty"],
                    name: value["name"],
                    imageUrl: value["imageUrl"],
                  ));
          _firebaseIds[value['id']] = key;
        });
        print("BERHASIL MASUKAN DATA LIST");
        notifyListeners();
      }
    } catch (err) {
      print("Terjadi kesalahan: $err");
      throw (err);
    }
  }
}
