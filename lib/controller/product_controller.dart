import 'package:fetch_api/model/product_model.dart';
import 'package:fetch_api/service/api_service.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<ProductModel>?> getProduct() async {
    var response = await http.get(Uri.parse(productRoute));
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    }
    return [];
  }
}
