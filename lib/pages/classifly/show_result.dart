import 'package:asparagus_app/models/asparagus_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShowResult extends StatefulWidget {
  final Asparagus asparagus;
  const ShowResult({Key? key, required this.asparagus}) : super(key: key);

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  late Asparagus asparagus;

  @override
  void initState() {
    asparagus = widget.asparagus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Column(
          children: [
            const Text(
              "Result",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'เกรด A ${asparagus.count!.a} เกรด B ${asparagus.count!.b} เกรด C ${asparagus.count!.c}',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(160, 224, 213, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(160, 224, 213, 1.0),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                '',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: asparagus.result!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = asparagus.result!;
                  print(data[index].url!);
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 4.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              data[index].url!,
                              width: 100.0,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Class ${data[index].class_name!}',
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    'Confidence ${data[index].confidence!.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
