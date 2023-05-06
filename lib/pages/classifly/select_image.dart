import 'dart:convert';

import 'package:asparagus_app/models/asparagus_model.dart';
import 'package:asparagus_app/pages/classifly/show_result.dart';
import 'package:asparagus_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  XFile? image;
  String image_path = "";
  bool _isLoading = false;
  late Asparagus _result;

  Future pickImage(ImageSource source) async {
    try {
      image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        image_path = image!.path;
      });

      //final imageTemporary = File(image.path);
      //final imagePermanent = await saveImagePermanent(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e ');
    }
  }

  void fetchResult() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print(image == null);
      final response = await Api().submit("predict", image!);
      Map<String, dynamic> jsonData = jsonDecode(response);
      print(jsonData);
      _result = Asparagus.fromJson(jsonData);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowResult(asparagus: _result,),
          ));
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: const Color.fromRGBO(160, 224, 213, 1.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image_path == "")
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 500.0,
                    ),
                  ),
                if (image_path != "")
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                    child: Image.file(
                      File(image_path),
                      height: 500.0,
                      width: double.infinity,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(3, 27, 31, 1.0)),
                      onPressed: () {
                        fetchResult();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          "CLASSIFY",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            size: 50.0,
                          )),
                      IconButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 50.0,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.8),
            child: const Center(
              child: CircularProgressIndicator(), // Loader
            ),
          ),
      ],
    );
  }
}
