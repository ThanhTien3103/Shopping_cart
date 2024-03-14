import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/src/view/pages/my_cart_page.dart';
import 'package:shopping_cart/src/view/widgets/card_widget.dart';
import 'package:shopping_cart/src/view_model/controller/product_view_model.dart';

class MyHomePage extends GetWidget<ProductViewModel> {
  const MyHomePage({super.key});

  //final baseUrl = 'https://fakestoreapi.com/products';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: const Text('ThanhDuongApp'),
       ),
      body: Obx(() =>
          controller.isLoading.value?
              const Center(
                child: CircularProgressIndicator(),
              )
              :
          Column(
            children: [
              Stack(
                children: [
                  Positioned(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            color: Colors.blue,
                            child: Row(
                              //color: const Color(Colors.lightBlue),
                              children: [
                                const Padding(padding: EdgeInsets.all(10.0)),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Obx(() => Text(
                                    'Total: ${controller.total.toStringAsFixed(2)} \$',
                                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: CupertinoButton(
                                        child: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(() => const MyCartPage());
                                        },
                                      ),
                                    )
                                ),
                                Obx(() => Text('${controller.num_in_cart}',
                                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                                const Padding(padding: EdgeInsets.all(5.0))
                              ],
                            ),
                          ),
                          SizedBox(
                            //width: VisualDensity.compact.vertical,
                            height: 60,
                            child: CupertinoSearchTextField(
                              onSubmitted: (value) {
                                controller.onTextChanged(value);
                              },
                              placeholder: 'Search',
                              //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CupertinoColors.white,
                                  border: const Border(bottom: BorderSide(color: Colors.blue, width: 1.0))
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(CupertinoIcons.search),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchList.length,
                    itemBuilder: (context, index) {
                      return CardWidgets(controller.searchList[index], key: UniqueKey());
                    },
                  )
              ),
            ],
          )
      ),
    );
  }
}