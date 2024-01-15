import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:sewa_kamera1/models/category_model/category_model.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/screens/product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

@override
  void initState() {
    getCategoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight*1,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        BackButton(),
                        Text(widget.categoryModel.name,
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold),)
                      ],
                    )
                  ),
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Best Product is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.7,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (ctx, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
            
                              // Format the price into Indonesian currency
                              final formattedPrice = NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'Rp')
                                  .format(singleProduct.price);
            
                              return Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 143, 255, 145)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      singleProduct.image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      singleProduct.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Display the formatted price with '/hari'
                                    Text("Harga : $formattedPrice/hari"),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 140,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Routes.instance.push(
                                              widget: ProductDetails(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: Text(
                                          "Sewa",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
          ),
    );
  }
}
