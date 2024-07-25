import 'package:flutter/material.dart';

import '../../model/photo_model.dart';
import '../../utils/helper/api_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController searchController = TextEditingController();

  late Future<List<PhotoModal>?> getAllImages;

  @override
  void initState() {
    super.initState();

    getAllImages = ApiHelpers.apiHelper.fetchPhoto(searchItem: "red flowers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallpaper",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Search wallpaper..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    getAllImages = ApiHelpers.apiHelper
                        .fetchPhoto(searchItem: searchController.text);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: FutureBuilder(
              future: getAllImages,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  List<PhotoModal>? data = snapshot.data;
                  return (data == null || data.isEmpty)
                      ? Center(
                          child: Text("No any data"),
                        )
                      : GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data[i].webformatURL),
                                ),
                              ),
                            );
                          });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
