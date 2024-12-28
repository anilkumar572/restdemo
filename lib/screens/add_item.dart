import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  AddItem({super.key, required this.newIndex});

  int newIndex;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController item = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController image = TextEditingController();

  Future<void> addData() async {
    Navigator.pop(context, 'refresh');

    try {
      Map<String, dynamic> data = {
        "completed": false,
        "cost": cost.text,
        "image": image.text,
        "name": item.text,
      };
      Response response = await Dio().patch(
          'https://dummyapianil-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json',
          data: data);
    } catch (e) {
      print("erroe");
    }
  }

  @override
  Widget build(BuildContext context) {
    var addform = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: addform,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must not be empty';
                  } else {
                    return null;
                  }
                },
                controller: item,
                decoration: InputDecoration(
                  hintText: 'Enter Item',
                  labelText: "Item",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must not be empty';
                  }
                },
                keyboardType: TextInputType.numberWithOptions(),
                controller: cost,
                decoration: InputDecoration(
                  hintText: 'Enter cost',
                  labelText: "Cost",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must not be empty';
                  }
                },
                controller: image,
                decoration: InputDecoration(
                  hintText: 'Upload image',
                  labelText: "Image",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (addform.currentState!.validate()) {
                    addData();
                  }
                },
                child: Text("Add data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
