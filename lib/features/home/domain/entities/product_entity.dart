import 'package:hive/hive.dart';

part 'product_entity.g.dart';


@HiveType(typeId: 0)
class ProductData extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String image;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final String category;

  @HiveField(6)
  int? quantity=1; // ✅ added


  ProductData({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.quantity=1
  });




}