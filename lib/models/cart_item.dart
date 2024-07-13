class CartItem {
  String id;
  String createdAt;
  String name;
  double price;
  int qty;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.createdAt,
    required this.price,
    required this.qty,
    required this.name,
    required this.imageUrl,
  });
}
