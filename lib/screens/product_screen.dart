import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample_api/services/product_service.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();
  List products = [];

  Future<List> loadAllProducts() async {
    ProductService productService = ProductService();
    await productService.fetchAllProducts();
    products = productService.data;

    return products;
  }

  @override
  void initState() {
    super.initState();
    loadAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            InterFont(
              text: 'Our',
              fontSize: ScreenUtil().setSp(30),
              color: Colors.blue,
            ),
            InterFont(
              text: 'Products',
              fontSize: ScreenUtil().setSp(30),
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomIconTextField(
                      hintText: 'Search',
                      hintTextSize: ScreenUtil().setSp(15),
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().screenWidth,
                      prefixIcon: Icon(
                        Icons.search,
                        size: ScreenUtil().setSp(20),
                      ),
                      controller: searchController,
                      fillColor: Colors.white24,
                      fontColor: null),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(630),
              child: FutureBuilder(
                future: loadAllProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (products.isEmpty) {
                    return SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(20),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15),
                              vertical: ScreenUtil().setHeight(15)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [genericLoading],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print("hasError");
                    Navigator.popAndPushNamed(context, '/splash');
                    return Container(
                        color: Colors.yellow,
                        child: Center(child: genericLoading));
                  } else if (products.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 1,
                              child: GestureDetector(
                                onTap: () {
                                  print('Index ${index}');
                                  Navigator.pushNamed(
                                    context,
                                    '/detail_screen',
                                    arguments: {
                                      'name': products[index]['name'],
                                      'rating': products[index]['rating'],
                                      'price': products[index]['price'],
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(15),
                                      vertical: ScreenUtil().setHeight(15)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Placeholder(
                                        fallbackHeight:
                                            ScreenUtil().setHeight(50),
                                        fallbackWidth:
                                            ScreenUtil().setWidth(50),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InterFont(
                                              text: products[index]['name'],
                                              fontSize: ScreenUtil().setSp(13),
                                              color: Colors.black45),
                                          InterFont(
                                              text: products[index]['rating']
                                                  .toString(),
                                              fontSize: ScreenUtil().setSp(10),
                                              color: Colors.blue),
                                          InterFont(
                                              text: products[index]['price']
                                                  .toString(),
                                              fontSize: ScreenUtil().setSp(17),
                                              color: Colors.yellow),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        });
                  } else {
                    print("hasError");
                    Navigator.popAndPushNamed(context, '/splash');
                    return Container(
                        color: Colors.yellow,
                        child: Center(child: genericLoading));
                  }
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
          ],
        ),
      ),
    );
  }
}
