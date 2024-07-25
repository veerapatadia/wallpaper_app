import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/photo_model.dart';

class ApiHelpers {
  ApiHelpers._();

  static final ApiHelpers apiHelper = ApiHelpers._();

  // Future<Map?> fetchSinglePost() async {
  //   http.Response response = await http.get(Uri.parse(SINGLE_POST_API));
  //
  //   if (response.statusCode == 200) {
  //     String body = response.body;
  //
  //     Map decodedData = jsonDecode(body);
  //
  //     return decodedData;
  //   }
  //   return null;
  // }

  Future<List<PhotoModal>?> fetchPhoto({required String searchItem}) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://pixabay.com/api/?key=45055846-817ff1afb2627151d12a4c3f2&q=$searchItem&image_type=photo&pretty=true"),
    );

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      List allPics = decodedData["hits"];

      List<PhotoModal> allPhotos =
          allPics.map((e) => PhotoModal.fromMap(data: e)).toList();

      return allPhotos;
    }
  }
}
