import 'package:dio/dio.dart';
import 'package:lafyuu/models/category_repo_model.dart';

class CategoryRepository{
  Future<Response> getAllCategories() async{
    final response = await Dio().get('https://student.valuxapps.com/api/categories');
    return response;
  }
}

class CategoryDetails {
  Future<Map<String, dynamic>> getCategoriesDetails(int id) async {
    final response = await Dio().get('https://student.valuxapps.com/api/categories/$id');
    if(response.data == null){
      throw Exception("Response data is null");
    }
    return response.data;
  }
}


class Products{
  Future<Response> getProduct() async{
    final productResponse = await Dio().get('https://student.valuxapps.com/api/products');
    print(productResponse);
    return productResponse;
  }
}

class Home{
  Future<Response> getHomeData() async{
    final response = await Dio().get('https://student.valuxapps.com/api/home');
    return response;
  }
}

 class HomeProducts{
  Future<Response> getHomeProducts(int id) async{
    final response = await Dio().get('https://student.valuxapps.com/api/home/$id');
    return response;
  }
 }

void main(){
  print(CategoryDetails().getCategoriesDetails(44));
}

// class CategoryRepository {
//   Future<List<CategoryRepoModel>> getAllCategories() async {
//     final response =
//         await Dio().get('https://api.escuelajs.co/api/v1/categories/');
//
//     final listOfCategories = List<CategoryRepoModel>.from(
//       response.data.map(
//         (value) => CategoryRepoModel(
//           id: value['id'],
//           name: value['name'],
//           image: value['image'],
//          ),
//       ),
//     );
//     return listOfCategories;
//   }
// }

// class RepoTest {
//
//   Future<Response> getHttp() async {
//     final response = await Dio().get('https://dart.dev');
//     print(response);
//     return response;
//   }
//
//   void getHttp1() {
//     final response = Dio().get('https://dart.dev');
//     print(response);
//     print('_________________________________________________');
//   }
// }
//
// void main() {
//  // RepoTest().getHttp();
//
//  // RepoTest().getHttp1();
//
//   CategoryText().getCategoryRepo();
// }
//
// class CategoryText{
//   void getCategoryRepo() async{
//     final response = await Dio().get('https://api.escuelajs.co/api/v1/categories/');
//     print(response);
//   }
// }
