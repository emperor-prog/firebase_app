import 'package:hive/hive.dart';

part 'cart_product.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final int count;

  CartItem(
      {required this.id,
      required this.count,
      required this.title,
      required this.price,
      required this.image});
}
