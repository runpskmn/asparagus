import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL =
      "https://1a79-184-22-14-102.ap.ngrok.io";
  Future<dynamic> submit(String endpoint, XFile image) async {
    File imageFile = File(image.path);
    var request =
        http.MultipartRequest('POST', Uri.parse('${BASE_URL}/${endpoint}'));

    var imageStream = http.ByteStream(imageFile.openRead());
    var imageLength = await imageFile.length();
    var imageMultipartFile = http.MultipartFile(
        'image', imageStream, imageLength,
        filename: 'asparagus.jpg'); // Update field name and file name
    request.files.add(imageMultipartFile);

    try {
      // Send the request and await for the response
      var response = await request.send();
      if (response.statusCode == 200) {
        final String responseString = await response.stream.bytesToString();
        return responseString;
      } else {
        throw Exception(
            'Server connection failed!'); // Use proper exception handling
      }
    } catch (e) {
      print('Error: $e'); // Print error for debugging
      throw Exception(
          'Failed to upload image: $e'); // Provide meaningful error message
    }
  }
}
