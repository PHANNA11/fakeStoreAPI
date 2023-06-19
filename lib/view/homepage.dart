import 'package:fetch_api/controller/product_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

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
      initiallyExpanded: true,
      title: Text(product.title),
      trailing: IconButton(
          onPressed: () async {
            Share.share(product.image, subject: 'Look what I made!');
          },
          icon: Icon(Icons.share)),
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
            Expanded(
              child: ReadMoreText(
                product.description,
                trimLines: 6,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                moreStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.price.toString()),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarIndicator(
                  rating: product.rating.rate,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  product.rating.count.toString(),
                ),
                Text(
                  product.category.name,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
