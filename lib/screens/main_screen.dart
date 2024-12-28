import 'package:bucketlist/screens/add_item.dart';
import 'package:bucketlist/screens/view_bucketitem.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  bool isError = false;
  List<dynamic> bucketList = [];
  void getData() async {
    setState(() {
      isLoading = true;
    });
    final dio = Dio();
    try {
      Response response = await dio.get(
          'https://dummyapianil-default-rtdb.firebaseio.com/bucketlist.json');

      if (response.data is List) {
        bucketList = response.data;
      } else {
        bucketList = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isError = true;
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget LoadList() {
    List<dynamic> filteredlist = bucketList
        .where((element) => (!element?['completed'] ?? false))
        .toList();

    return filteredlist.length < 0
        ? const Center(child: Text("No items in the list"))
        : ListView.builder(
            itemCount: bucketList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: (bucketList[index] is Map &&
                        (!(bucketList[index]?['completed'] ?? false)))
                    ? ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ViewBucket(
                                index: index,
                                title: bucketList[index]?['name'] ?? " ",
                                image: bucketList[index]?['image'] ?? "",
                              );
                            }),
                          ).then((value) {
                            if (value == 'refresh') {
                              return getData();
                            }
                          });
                        },
                        title: Text(bucketList[index]?['name'] ?? " "),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(bucketList[index]?['image'] ?? ""),
                          radius: 20,
                        ),
                        trailing: Text(bucketList[index]?['cost'].toString() ??
                            "Not Available "),
                      )
                    : const SizedBox(),
              );
            },
          );
  }

  Widget errorMsg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning),
          const SizedBox(
            height: 10,
          ),
          const Text("Error Getting data"),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: getData,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddItem(
              newIndex: bucketList.length,
            );
          })).then((value) {
            if (value == 'refresh') {
              getData();
            }
          });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('BucktList'),
        actions: [
          InkWell(
            onTap: getData,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                return getData();
              },
              child: isError
                  ? errorMsg()
                  : bucketList.isEmpty
                      ? const Center(child: Text("No data in the Bucket list"))
                      : LoadList(),
            ),
    );
  }
}
