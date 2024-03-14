import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/src/view_model/controller/product_view_model.dart';

import '../../model/products.dart';

class ListCartWidget extends GetWidget<ProductViewModel> {
  final Product product;
  const ListCartWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(product.image!),
                ),
                const SizedBox(width: 10), // Thêm khoảng cách giữa hình ảnh và văn bản
                Expanded(
                  child: Text(
                    product.title!,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  '${product.price?.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
