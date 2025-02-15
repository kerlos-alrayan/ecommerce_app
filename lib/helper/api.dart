import 'package:dio/dio.dart';

class Api {
  final Dio _dio = Dio();

  Future<Response> get({
    required String uri,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await _dio.get(
        uri,
        cancelToken: cancelToken,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Error: ${response.statusCode} - ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("❌ Unknown Error: $e");
      throw Exception('Something went wrong: $e');
    }
  }
}
