import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({super.key, required this.singleProduct});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.money),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Cash on Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.money),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Pembayaran Online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            PrimaryButton(
              title: "Lanjutkan",
              onPressed: () async {
                appProvider.getBuyProductList.clear();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        groupValue == 1 ? "Cash on delevery" : "Paid");
                if (value) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Routes.instance.push(
                        widget: const CustomBottomBar(), context: context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
