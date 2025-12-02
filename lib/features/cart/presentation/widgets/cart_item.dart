import 'package:flutter/material.dart';

import '../../../home/domain/entities/product_entity.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key, required this.productData, required this.onDeletePressed, required this.onIncreasePressed,required this.onDecreasePressed});

  final VoidCallback onDeletePressed;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;
  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 160, // 👈 gives consistent height for image and text
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🖼️ Image fills the full height of the Card
            ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                child: Image.network(productData.image,
                    width: 120, fit: BoxFit.cover)),

            // 📜 Expanded ensures text area uses remaining space safely
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // 👈 keeps layout neat
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              productData.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            )),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                onDeletePressed();
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'This is a sample product description that can wrap to multiple lines safely.multiple lines safely.',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 13),
                          maxLines: 2, // 👈 prevents overflow
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Quantity : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              onIncreasePressed();
                            },
                          ),
                          Text('${productData.quantity}',
                              style: TextStyle(fontSize: 16)),
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              onDecreasePressed();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
