import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';

class ProductDto extends ProductData {


  ProductDto({required super.id,required super.title,required super.price,required super.image, required super.description, required super.category,super.quantity});


  Map<String, dynamic> toJson() => {
    "id" : id,
    "title": title,
    "price": price,
    "image": image,
    "description": description,
    "category":category,
    "quantity" :quantity
  };

  factory ProductDto.fromJson(Map<String, dynamic> json) {


    return ProductDto(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }


}

