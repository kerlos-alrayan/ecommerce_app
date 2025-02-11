import 'package:lafyuu/cubits/home_products_cubit/home_product_cubit.dart';
import 'package:lafyuu/presentation/screens/init_screens/single_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProductCubit>().getHomeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Main
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search & Favorite
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Search
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search Product',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // Favorite
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/main_screen/Vector_main.png',
                        width: 22,
                        height: 22,
                      ),
                    ),
                    // Notification
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/main_screen/Group.png',
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Line
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Color(0xffEBF0FF),
              ),

              // CarouselSlider
              _banners(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banners() {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (BuildContext context, state) {
        if (state is LoadingHomeState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeDataSuccess) {
          final banners = state.homeResponse.data.banners;
          // final products = state.homeResponse.data.products;
          return CarouselSlider.builder(
              itemCount: banners.length,
              options: CarouselOptions(
                viewportFraction: 1,
                height: 206,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                enableInfiniteScroll: true,
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                final bannerItem = banners[itemIndex];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SingleProductScreen(
                              id: bannerItem.id,
                              name: '',
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(bannerItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
        return SizedBox();
      },
    );
  }

}
