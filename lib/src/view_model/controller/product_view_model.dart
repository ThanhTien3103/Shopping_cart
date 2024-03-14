import 'package:get/get.dart';
//import 'package:http/http.dart';
import 'package:shopping_cart/src/repositories/product_repository.dart';

import '../../model/products.dart';

class ProductViewModel extends GetxController {
  double get total => productInCartList.fold(0, (sum, item) => sum+item.price!);
  int get num_in_cart =>  productInCartList.length;
  var productList = [].obs;
  var isLoading = true.obs;
  var searchList = [].obs;
  var productInCartList =  [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProducts();
    getAllProductsInCart();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    saveAllProductsInCart();
    super.onClose();

  }
  void clearCart() {
    productInCartList.clear();
    ProductRepository().clearDb();
  }
  void addToCart(Product product) {
    productInCartList.add(product);
    saveAllProductsInCart();
  }
  void removeFromCart(Product product) {
    productInCartList.removeWhere((element) => element.id == product.id);
    saveAllProductsInCart();
  }
  void onTextChanged(String text) {
    searchList.clear();
    if(text.isEmpty) {
      for (var element in productList) {
        searchList.add(element);
        //print(searchList[0]);
      }
    } else {
      for (var element in productList) {
        if(element.title!.toLowerCase().contains(text.toLowerCase())){
          searchList.add(element);
        }
      }
    }
  }
  Future<void> getAllProducts() async {
    var product = await ProductRepository().fetchProducts();
    if(product != null) {
      productList.value = product;
      for (var element in productList) {
        searchList.add(element);
      }
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }
  Future<void> getAllProductsInCart() async {
    var product = await ProductRepository().fetchProductsInCartDB();
    productInCartList.value = product;
  }
  Future<void> saveAllProductsInCart() async {
    ProductRepository().saveToDb(productInCartList);
    //var result = ProductRepository().saveToDb(productInCartList as Product);
  }
}