import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../cubits/category_product/category_product_cubit.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.homeData});
  final List homeData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 282, // height of container
          crossAxisCount: 2, // 3dd 2l container 2lly gnb b3d
          mainAxisSpacing: 12, // height between containers
          crossAxisSpacing: 13, // width between containers
        ),
        itemCount: homeData.length,
        itemBuilder: (context, index) {
          final homeItems = homeData[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
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
                    // Image
                    Center(
                        child: Image.network(
                          homeItems.image,
                          width: 133,
                          height: 133,
                        )),
                    SizedBox(
                      height: 8,
                    ),
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
                    SizedBox(
                      height: 8,
                    ),
                    // Rating
                    RatingBar.builder(
                      itemSize: 10,
                      ignoreGestures: true,
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding:
                      EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                      },
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
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP ${homeItems.oldPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            color: Color(0xff9098B1),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${homeItems.discount}% off',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            color: Color(0xffFB7181),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
