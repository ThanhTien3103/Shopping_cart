import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/src/view/pages/my_home_page.dart';
import 'package:shopping_cart/src/view/widgets/list_cart_widget.dart';
import 'package:shopping_cart/src/view_model/controller/product_view_model.dart';

class MyCartPage extends GetWidget<ProductViewModel> {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: [
          InkWell(
            onTap: () {
              controller.clearCart();
              Get.offAll(() => const MyHomePage());
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: const Text('Clear all', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Colors.white)),
            ),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
          itemCount: controller.productInCartList.length,
          itemBuilder: (context, index) => Row(
            children: [
              Expanded(
                  child: ListCartWidget(controller.productInCartList[index], key: UniqueKey())
              ),
              CupertinoButton(
                onPressed: () {
                  controller.removeFromCart(controller.productInCartList[index]);
                },
                child: const Icon(Icons.remove_shopping_cart),
              )
            ],
           )
      ))
    );
  }
}