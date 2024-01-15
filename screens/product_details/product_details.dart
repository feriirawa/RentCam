import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/check_out/check_out.dart';
import 'package:sewa_kamera1/screens/cart_screen/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: Icon(Icons.shopping_cart), // Corrected the icon usage
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 300,
              width: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.singleProduct.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.singleProduct.isFavourite =
                          !widget.singleProduct.isFavourite;
                    });
                    if (widget.singleProduct.isFavourite) {
                      appProvider.addFavouriteProduct(widget.singleProduct);
                    } else {
                      appProvider.removeFavouriteProduct(widget.singleProduct);
                    }
                  },
                  icon: Icon(appProvider.getFavouriteProductList.contains(widget.singleProduct)
                      ? Icons.favorite
                      : Icons.favorite_border),
                )
              ],
            ),
            Text(widget.singleProduct.description),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    if (qty >= 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    backgroundColor: Colors.green, // Warna latar belakang hijau
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  qty.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    backgroundColor: Colors.green, // Warna latar belakang hijau
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Ditambahkan Ke Keranjang");
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0), // Sesuaikan sesuai kebutuhan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Masukkan Keranjang",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Container(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      Routes.instance
                          .push(widget: Checkout(singleProduct: productModel,), context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Sewa",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ) ,
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
