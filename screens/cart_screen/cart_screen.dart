import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/cart_screen/widget/single_cart_item.dart';
import 'package:sewa_kamera1/widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    // Fungsi untuk mengonversi harga ke format Indonesia tanpa digit di belakang koma
    String formatCurrency(double price) {
      return NumberFormat.currency(
              locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
          .format(price);
    }

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatCurrency(
                        appProvider.totalPrice()), // Gunakan formatCurrency
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              PrimaryButton(
                title: "Checkout",
                onPressed: () {
                  // Routes.instance.push(widget: Checkout(), context: context);
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Keranjang"),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(child: Text("Tidak ada produk"))
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
