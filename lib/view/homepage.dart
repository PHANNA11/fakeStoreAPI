import 'package:fetch_api/controller/product_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  getProduct() async {
    await ProductController().getProduct().then((value) {
      setState(() {
        products = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOP SHOP'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => buildCardProduct(products[index]),
      ),
    );
  }

  Widget buildCardProduct(ProductModel product) {
    return ExpansionTile(
      title: Text(product.title),
      children: [
        Row(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image(
                image: NetworkImage(
                  product.image,
                ),
              ),
            ),
            Expanded(child: Text(product.description))
          ],
        )
      ],
    );
  }
}
