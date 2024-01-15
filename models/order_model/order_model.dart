import 'package:sewa_kamera1/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.orderid,
    required this.totalPrice,
    required this.Pembayaran,
    required this.products,
    required this.status,
  });

  String Pembayaran;
  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderid;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderid: json["orderId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
      status: json["status"],
      Pembayaran: json["Pembayaran"],
    );
  }
}
