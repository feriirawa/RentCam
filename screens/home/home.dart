// ignore: unnecessary_import
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sewa_kamera1/constants/routes.dart';
import 'package:sewa_kamera1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:sewa_kamera1/models/category_model/category_model.dart';
import 'package:sewa_kamera1/models/product_model/product_model.dart';
import 'package:sewa_kamera1/provider/app_provider.dart';
import 'package:sewa_kamera1/screens/category_view/category_view.dart';
import 'package:sewa_kamera1/screens/product_details/product_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  final List images = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];

  final CarouselController controller = CarouselController();
  int _currentIndex = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    if (!mounted) return;
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    setState(() {
      isLoading = true;
    });
    try {
      categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
      productModelList =
          await FirebaseFirestoreHelper.instance.getBestProducts();

      productModelList.shuffle();
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.map((url) {
        int index = images.indexOf(url);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Color.fromARGB(255, 0, 122, 0) : Colors.grey,
          ),
        );
      }).toList(),
    );
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Rent Cam",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Cari...",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            CarouselSlider.builder(
                              carouselController: controller,
                              itemCount: images.length,
                              itemBuilder: (context, index, realIndex) {
                                final imagePath = images[index];
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors
                                            .white, // Ubah warna border sesuai kebutuhan
                                        width: 2.0, // Ubah lebar border sesuai kebutuhan
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          18), // Kurangi sedikit dari border utama
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                viewportFraction: 0.85,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                initialPage: 0,
                                reverse: false,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 10,
                              child: buildIndicator(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Kategori",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? Center(
                          child: Text("Kategori tidak ditemukan"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                          widget:
                                              CategoryView(categoryModel: e),
                                          context: context,
                                        );
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 20.0),
                    child: Text(
                      "Populer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Best Product is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12),
                          child: GridView.builder(
                            padding: EdgeInsets.only(bottom: 50),
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

                              final formattedPrice = NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp',
                                decimalDigits: 0,
                              ).format(singleProduct.price);

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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Harga: $formattedPrice/hari"),
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
                                              singleProduct: singleProduct,
                                            ),
                                            context: context,
                                          );
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
