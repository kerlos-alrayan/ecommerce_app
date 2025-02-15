import 'package:lafyuu/cubits/home_products_cubit/home_product_cubit.dart';
import 'package:lafyuu/presentation/screens/init_screens/flash_sale_screen.dart';
import 'package:lafyuu/presentation/screens/init_screens/single_product_screen.dart';
import 'package:lafyuu/presentation/widgets/categories_widget.dart';
import 'package:lafyuu/presentation/widgets/product_widget.dart';
import 'package:lafyuu/presentation/widgets/text_more.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/categories/categories_cubit.dart';
import '../../cubits/categories/categories_state.dart';

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

              // Category & More Category
              TextAndMore(
                text: 'Category',
                more: 'More Category',
                onTap: () {},
              ),

              // Categories
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesLoaded) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoriesWidget(category: category);
                        },
                      ),
                    );
                  } else if (state is CategoriesError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),

              // Flash Sale
              TextAndMore(
                text: 'Flash Sale',
                more: 'See More',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FlashSaleScreen(
                            image: '',
                          )));
                },
              ),

              // Flash Sale Products
              _sale_products(),

              // Mega Sale
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: TextAndMore(
                  text: 'Mega Sale',
                  more: 'See More',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FlashSaleScreen()));
                  },
                ),
              ),

              // Mega Sale Products
              _sale_products(),

              // Recomended Product
              _recomended_product(),

              // GridView Builder
              Center(
                child: BlocBuilder<HomeProductCubit, HomeProductState>(
                    builder: (context, state) {
                  if (state is LoadingHomeState) {
                    return CircularProgressIndicator();
                  }
                  if (state is HomeDataSuccess) {
                    final homeData = state.homeResponse.data.products;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProductWidget(
                        homeData: homeData,
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recomended_product() {
    return Container(
      margin: EdgeInsets.only(top: 9, left: 16, right: 16),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/main_screen/image 51.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recomended \n Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'We recommend the best for you',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                              borderRadius: BorderRadius.circular(16),
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

  Widget _sale_products() {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is LoadingHomeState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeDataSuccess) {
          final homeData = state.homeResponse.data.products.where((product) {
            final discount = product.discount;
            final discountValue = discount is num
                ? discount
                : int.tryParse(discount.toString()) ?? 0;
            return discountValue > 0;
          }).toList();

          if (homeData.isEmpty) {
            return Center(
              child: Text(
                'There are no products currently on discount',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.only(top: 12, left: 16),
            child: SizedBox(
              height: 238,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeData.length,
                itemBuilder: (context, indexItem) {
                  final homeItems = homeData[indexItem];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SingleProductScreen(
                                id: homeItems.id,
                                name: homeItems.name,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 141,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffEBF0FF),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  homeItems.image,
                                  width: 109,
                                  height: 109,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Title
                              Text(
                                homeItems.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff223263),
                                ),
                              ),
                              Spacer(),
                              // Price
                              Text(
                                'EGP ${homeItems.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff40BFFF),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'EGP ${homeItems.oldPrice}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff9098B1),
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Discount
                                  Expanded(
                                    child: Text(
                                      '${homeItems.discount}% off',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        color: Color(0xffFB7181),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
