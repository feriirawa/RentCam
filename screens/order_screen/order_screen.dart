import 'package:flutter/material.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:sewa_kamera1/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Pesanan Saya",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Tidak ada pesanan yang ditemukan"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = snapshot.data![index];
              return ExpansionTile(
                title: Text(
                  orderModel.Pembayaran,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      orderModel.status,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
