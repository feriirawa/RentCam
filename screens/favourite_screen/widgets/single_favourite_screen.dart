import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/constants.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({Key? key, required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.green.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                AppProvider appProvider = Provider.of<AppProvider>(context,
                                listen: false);
                                appProvider.removeFavouriteProduct(widget.singleProduct);
                                showMessage("Dihapus dari Favorit");
                              },
                              child: Text(
                                "Hapus dari Favorit",
                                style: TextStyle(
                                    color: const Color.fromRGBO(76, 175, 80, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rp ${NumberFormat.decimalPattern().format(widget.singleProduct.price)}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
