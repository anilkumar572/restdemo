import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewBucket extends StatefulWidget {
  ViewBucket(
      {super.key,
      required this.index,
      required this.title,
      required this.image});
  String title;
  String image;
  int index;

  @override
  State<ViewBucket> createState() => _ViewBucketState();
}

class _ViewBucketState extends State<ViewBucket> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          'https://dummyapianil-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json');
      Navigator.pop(context, 'refresh');
    } catch (e) {
      print(e);
    }
  }

  Future<void> markAsDone() async {
    try {
      Map<String, dynamic> data = {
        "completed": true,
      };
      Response response = await Dio().patch(
          'https://dummyapianil-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json',
          data: data);
    } catch (e) {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(" Are you sure to delete"),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: deleteData, child: const Text("Conform")),
                      ],
                    );
                  });
            }
            if (value == 2) {
              markAsDone();
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 1,
                child: Text('Delets'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Mark as done'),
              ),
            ];
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image))),
          ),
          Text(
            widget.index.toString(),
          ),
        ],
      ),
    );
  }
}
