import 'package:flutter/material.dart';
import 'package:menu_makanan/providers/minuman/product_minuman.dart';

class DaftarMinumans with ChangeNotifier {
  final List<DaftarMinuman> _allMinuman = [
    DaftarMinuman(
      name: 'Teh',
      id: '7',
      description:
          'Teh adalah minuman penyegar yang populer di Indonesia, Minuman teh disukai masyarakat Indonesia karena memiliki banyak manfaat yang baik bagi kesehatan tubuh manusia.Terdapat 2 jenis menu teh yaitu es teh dan teh hangat.',
      price: 5.000,
      imageAsset: 'images/daftar_minuman/kopi/teh.jpg',
    ),
    DaftarMinuman(
      name: 'Kopi',
      id: '8',
      description:
          'Kopi sering kali menjadi pilihan utama bagi sebagian orang untuk menemani harinya, baik saat memulai aktivitas, menghilangkan rasa kantuk, maupun buat bersantai.Terdapat 3 jenis menu kopi yaitu Espresso, Caffé Latte, Cappuccino.',
      price: 10.000,
      imageAsset: 'images/daftar_minuman/kopi/images.jpg',
    ),
    DaftarMinuman(
      name: 'Jeruk',
      id: '9',
      description:
          'Selain menyegarkan, es jeruk juga bisa menghidrasi tubuh, meningkatkan imun tubuh, hingga menurunkan tekanan darah.Terdapat 2 jenis menu jeruk yaitu es jeruk dan jeruk hangat.',
      price: 5.000,
      imageAsset: 'images/daftar_minuman/kopi/jeruk1.jpg',
    ),
    DaftarMinuman(
      name: 'Es Melon',
      id: '10',
      description:
          'Selain menyegarkan, es jeruk juga bisa menghidrasi tubuh, meningkatkan imun tubuh, hingga menurunkan tekanan darah.Terdapat 2 jenis menu jeruk yaitu es jeruk dan jeruk hangat.',
      price: 5.000,
      imageAsset: 'images/daftar_minuman/kopi/jeruk1.jpg',
    ),
    DaftarMinuman(
      name: 'Es Sirsak',
      id: '11',
      description:
          'Selain menyegarkan, es jeruk juga bisa menghidrasi tubuh, meningkatkan imun tubuh, hingga menurunkan tekanan darah.Terdapat 2 jenis menu jeruk yaitu es jeruk dan jeruk hangat.',
      price: 5.000,
      imageAsset: 'images/daftar_minuman/kopi/jeruk1.jpg',
    ),
    DaftarMinuman(
      name: 'Es Semangka',
      id: '11',
      description:
          'Selain menyegarkan, es jeruk juga bisa menghidrasi tubuh, meningkatkan imun tubuh, hingga menurunkan tekanan darah.Terdapat 2 jenis menu jeruk yaitu es jeruk dan jeruk hangat.',
      price: 5.000,
      imageAsset: 'images/daftar_minuman/kopi/jeruk1.jpg',
    ),
  ];

  List<DaftarMinuman> get allMinuman {
    return [..._allMinuman];
  }

  DaftarMinuman findById(String name) {
    return _allMinuman.firstWhere((minuman) => minuman.name == name);
  }

  void addMinuman(DaftarMinuman minuman) {
    _allMinuman.add(minuman);
    notifyListeners();
  }
}
