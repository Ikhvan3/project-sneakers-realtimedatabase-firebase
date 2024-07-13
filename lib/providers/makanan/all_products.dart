import 'package:flutter/material.dart';

import 'product_makanan.dart';

class DaftarMakanans with ChangeNotifier {
  final List<DaftarMakanan> _allMakanan = [
    DaftarMakanan(
      name: 'Ketoprak',
      id: '1',
      description:
          'Makanan yang biasanya terdiri dari irisan lontong, bihun, tauge, tahu, dan kerupuk plus telur ini sering kali jadi “kudapan” yang mengenyangkan. Bumbu halus yang jadi ciri khas dari masakan ini makin pas dengan tambahan kecap di atasnya. Rasa manis, gurih, dan sedikit asin ini menyatu dengan pas untuk menu siang atau malam hari. Beberapa warung ketoprak legendaris di Jakarta di antaranya Ketoprak Ciragil, Ketoprak Cirebon Mas Bana, hingga Ketoprak Mitro.',
      price: 15.000,
      imageAsset: 'images/daftar_makanan/ketoprak.png',
    ),
    DaftarMakanan(
      name: 'Gado-gado',
      id: '2',
      description:
          'Di Jakarta, ada dua jenis “aliran” gado-gado, yakni gado-gado siram dan gado-gado ulek. Keduanya punya penggemar tersendiri. Begitu juga dengan bumbu sausnya. Ada yang memakai kacang tanah, ada pula yang dikenal karena dicampur dengan kacang mede yang lebih gurih. Tambahan perasan jeruk limau membuat sausnya jadi lebih segar. Sering kali, kecap juga jadi tambahan bagi pelanggan yang ingin sausnya lebih manis. Beberapa gado-gado yang jadi acuan pelanggan di antaranya gado-gado Bonbin, gado-gado Boplo, gado-gado Cemara, hingga gado-gado AA.',
      price: 15.000,
      imageAsset: 'images/daftar_makanan/gado_gado1.jpg',
    ),
    DaftarMakanan(
      name: 'Nasi Goreng Kambing',
      id: '3',
      description:
          'Daging kambing yang diolah dengan nasi goreng hangat sering jadi andalan beberapa warung nasi goreng di Jakarta. Kecap menjadi pelengkap yang pas dari olahan nasi goreng yang dicampur dengan aneka bumbu rempah. Beberapa warung nasi goreng kambing yang melegenda di Jakarta di antaranya Nasi Goreng Kambing Kebon Sirih, Nasi Goreng Rempah Mafia, hingga Nasi Goreng Kebuli Apjay.',
      price: 15.000,
      imageAsset: 'images/daftar_makanan/nasi-goreng-kambing.png',
    ),
    DaftarMakanan(
      name: 'Soto Betawi',
      id: '4',
      description:
          'Soto yang satu ini sangat khas dengan kuah yang diolah dengan tambahan susu sapi segar. Beberapa warung memang masih menggunakan santan. Tapi, bagi pelanggan yang suka otentik, susu sebagai olahan kuah akan selalu punya daya tarik tersendiri. Apalagi, jika kuah gurihnya dicampur dengan sedikit manis yang pas dari kecap. Pelanggan setia di Jakarta rata-rata sudah tahu mana Soto Betawi yang jadi incarannya, seperti Soto Ma’ruf, Bang Kumis, hingga Soto Agus atau Iwan di Jalan Barito Jakarta.',
      price: 15.000,
      imageAsset: 'images/daftar_makanan/soto-betawi.png',
    ),
    DaftarMakanan(
      name: 'Sate',
      id: '5',
      description:
          'Penggunaan bumbu rempah yang kuat dan kecap manis gurih yang pas membuat banyak sate punya pelanggan masing-masing. Hampir di setiap sudut Jakarta, sate dengan mudah dijumpai. Ada yang berbumbu kacang, ada pula yang sekadar kecap dengan rempah dan irisan bawang merah. Semua ragam punya pelanggan tersendiri. Namun, jika bicara legenda, makanan Indonesia bakaran dengan ciri khas daging ditusuk ini biasa diantre pelanggan di Sate Pak Budi, Sate RSPP, hingga sate Maranggi Hj Tetty.',
      price: 20.000,
      imageAsset: 'images/daftar_makanan/sate.png',
    ),
    DaftarMakanan(
      name: 'Nasi Kambing',
      id: '6',
      description:
          'Penggunaan bumbu rempah yang kuat dan kecap manis gurih yang pas membuat banyak sate punya pelanggan masing-masing. Hampir di setiap sudut Jakarta, sate dengan mudah dijumpai. Ada yang berbumbu kacang, ada pula yang sekadar kecap dengan rempah dan irisan bawang merah. Semua ragam punya pelanggan tersendiri. Namun, jika bicara legenda, makanan Indonesia bakaran dengan ciri khas daging ditusuk ini biasa diantre pelanggan di Sate Pak Budi, Sate RSPP, hingga sate Maranggi Hj Tetty.',
      price: 20.000,
      imageAsset: 'images/daftar_makanan/sate.png',
    ),
  ];

  List<DaftarMakanan> get allMakanan {
    return [..._allMakanan];
  }

  DaftarMakanan findById(String name) {
    return _allMakanan.firstWhere((makanan) => makanan.name == name);
  }

  void addMakanan(DaftarMakanan makanan) {
    _allMakanan.add(makanan);
    notifyListeners();
  }
}
