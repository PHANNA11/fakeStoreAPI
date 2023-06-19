import 'package:fetch_api/model/product_model.dart';
import 'package:fetch_api/service/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final RxList<ProductModel> _product = <ProductModel>[].obs;
  List<ProductModel> get products => _product;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change([], status: RxStatus.success());
    getProduct();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProduct();
  }

  Future getProduct() async {
    if (status.isLoadingMore) return;
    if (!status.isLoadingMore && value!.isNotEmpty) {
      change(value, status: RxStatus.loadingMore());
    } else {
      change([], status: RxStatus.loading());
    }
    final response = await http.get(Uri.parse(productRoute));
    if (response != null) {
      if (response.statusCode == 200) {
        value?.addAll(productModelFromJson(response.body));
        _product.addAll(value!);
        return change(value, status: RxStatus.success());
      } else {
        return change([], status: RxStatus.empty());
      }
    }

    return change([], status: RxStatus.empty());
  }
}
