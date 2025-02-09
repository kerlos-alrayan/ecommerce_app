import 'package:flutter/material.dart';
import '../screens/category_screen.dart';
import '../../models/categories_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.category});
  final Datum category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoryScreen(
            title: category.name,
            imageURL: category.image,
            id: category.id,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 30,
                backgroundImage: NetworkImage(category.image),
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint("Error: ${category.image}");
                },
              ),
            ),
            SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.19,
              child: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.027,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
