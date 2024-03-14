import 'package:get/get.dart';
import 'package:shopping_cart/src/view_model/controller/product_view_model.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductViewModel>(() => ProductViewModel());

  }
}