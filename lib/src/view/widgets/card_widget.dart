import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/view_model/controller/product_view_model.dart';

class CardWidgets extends GetWidget<ProductViewModel> {
  const CardWidgets(this.product, {super.key});
  final Product product;
  Widget buildCard() {
    return Card(
      //color: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              //border: BorderSide(color: Colors.black, width:  1.0)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Image.network(product.image!),
            )
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                product.title!,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text(
                  '${product.price.toString()} \$' ,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            )
          ),
          Container(

            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),

              child:
              Obx(() =>
              controller.productInCartList.any((element) => product.id == element.id)?
              CupertinoButton(
                onPressed: () {
                  controller.removeFromCart(product);
                },
                color: Colors.blue,
                child: const Text('Remove form cart', style: TextStyle(fontWeight: FontWeight.bold),),
              )
                  :
              CupertinoButton(
                onPressed: () {
                  controller.addToCart(product);
                },
                color: Colors.blue,
                child: const Text('Add to cart', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              )
            )
          ),
          //Text('Price'),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildCard();

  }

}