import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  final _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages()async{
    QuerySnapshot qn = await _firestoreInstance.collection('carousel-slider').get();
   setState(() {
     for (int i = 0; i<qn.docs.length; i++){
       _carouselImages.add(
           qn.docs[i]['img'],
       );



     }
   });
   return qn.docs;
  }


  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });

      }
    });

    return qn.docs;
  }


  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 60.h,
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Search product here',
                              hintStyle: TextStyle(
                                fontSize: 15.sp,

                              )
                            ),
                          ),
                        )),
                    GestureDetector(
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        color: Colors.green,
                        child: const Center(
                          child: const Icon(Icons.search,
                          color: Colors.black),
                        ),
                      ),
                      onTap: (){},
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              AspectRatio(
                  aspectRatio: 3.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: CarouselSlider(
                    items: _carouselImages.map((item) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(item),fit: BoxFit.fitWidth),
                      ),
                    )).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
             DotsIndicator(
               dotsCount: _carouselImages.length == 0 ? 1: _carouselImages.length,
               position: _dotPosition.toDouble(),
               decorator: const DotsDecorator(
                 activeColor: Colors.green,
                 color: Colors.red,
                 spacing: EdgeInsets.all(2),
                 activeSize: Size(8, 8),
                 size: Size(6, 6)

               ),
             ),

              SizedBox(
                height:
                15.h,
              ),
              Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (_, index){
                        return Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(aspectRatio: 2,child: Container(
                                color: Colors.yellow,
                                  child: Image.network(_products[index]['product-img'][0]))),
                              Text('${_products[index]['product-name']}'),
                              Text('${_products[index]['product-price'].toString()}'),


                            ],
                          ),
                        );
                      }
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
