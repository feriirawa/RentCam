import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/favourite_screen/widgets/single_favourite_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorit"),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(child: Text("Tidak ada produk"))
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              },
            ),
    );
  }
}