import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/models/category_model/category_model.dart';
import 'package:sewa_kamera1/models/order_model/order_model.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String Pembayaran) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }

      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("orders").doc();
      admin.set({
        "products": list.map((e) => e.toJson()).toList(),
        "status": "pending",
        "totalPrice": totalPrice,
        "Pembayaran": Pembayaran,
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()).toList(),
        "status": "pending",
        "totalPrice": totalPrice,
        "Pembayaran": Pembayaran,
      });

      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Pesanan berhasil dengan ID: ${documentReference.id}");
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  //// Get Order User///

  Future<List<OrderModel>> getUserOrder() async {
  try {
    print("Fetching user orders...");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("usersOrders")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("orders")
            .get();

    List<OrderModel> orderList = querySnapshot.docs
        .map((element) => OrderModel.fromJson(element.data()))
        .toList();
    print("User orders: $orderList");
    return orderList;
  } catch (e) {
    print("Error fetching user orders: $e");
    showMessage(e.toString());
    return [];
  }
}

}
