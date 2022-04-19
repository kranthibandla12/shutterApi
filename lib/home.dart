// import 'dart:js';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shutter_api/json.dart';
import 'package:shutter_api/models/ShutterStockModel.dart';
import 'json.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  ShutterStockModel model = ShutterStockModel();
  String quality = "preview";
  String link = "abc";
  List<String> urls = ['a', 'b', 'c', 'd'];
  ScrollController scrollcontroller = ScrollController();
  // var resoul = [
  //   "preview",
  //   "small_thumb",
  //   "large_thumb",
  //   "huge_thumb",
  //   "preview_1000",
  //   "preview_1500"
  // ];
  dynamic response;
  Future imageLoader() async {
    //print("2");
    response = await fetchJson();
    print(response);
    setState(() {
      print("3");
      response = response;
      print("4");
      model = ShutterStockModel.fromJson(response);
      print("hello");
      print(model);
      print(model.data![0].assets!.preview!.url!);
    });
  }

  @override
  void initState() {
    //print("1");
    // TODO: implement initState
    // write a function to call api
    super.initState();
    // futureAlbum =
    imageLoader();
    scrollcontroller.addListener(pagination);
  }

  void pagination() async {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (urls.length < 20)) {
      print("pass 1");
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        urls.add('e');
        urls.add('f');
      });
    }
  }

  String fetch(index, quality) {
    switch (quality) {
      case "preview":
        return urls[index] = model.data![index].assets!.preview!.url!;
      case "small_thumb":
        return urls[index] = model.data![index].assets!.smallThumb!.url!;
      case "large_thumb":
        return urls[index] = model.data![index].assets!.largeThumb!.url!;
      case "huge_thumb":
        return urls[index] = model.data![index].assets!.hugeThumb!.url!;
      case "preview_1000":
        return urls[index] = model.data![index].assets!.preview1000!.url!;
      case "preview_1500":
        return urls[index] = model.data![index].assets!.preview1500!.url!;
      default:
        return urls[index] = model.data![index].assets!.preview!.url!;
    }
    // return urls[index] = model.data![index].assets!.preview!.url!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ShutterStock Flutter Api"),
        ),
        body: response == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: DropdownButton<String>(
                            value: quality,
                            items: <String>[
                              "preview",
                              "small_thumb",
                              "large_thumb",
                              "huge_thumb",
                              "preview_1000",
                              "preview_1500"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            dropdownColor: Colors.lightGreen,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            //focusColor: Colors.red,
                            //iconEnabledColor: Colors.black,
                            //isExpanded: true,
                            underline: Container(),
                            onChanged: (value) {
                              setState(() {
                                quality = value!;
                                print(quality);
                                //empty the list
                                urls.clear();
                                urls = ['a', 'b', 'c', 'd'];
                                scrollcontroller.position.moveTo(0);
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      // child: Text("hello"),
                    ),
                    Expanded(
                      flex: 20,
                      child: ListView.builder(
                          controller: scrollcontroller,
                          itemCount:
                              urls.length < 20 ? urls.length + 1 : urls.length,
                          // urls.length + 1,
                          itemBuilder: (context, index) {
                            index < urls.length
                                ? urls[index] = fetch(index, quality)
                                // model.data![index].assets!.preview1500!.url!
                                : print("object");
                            // urls[index] =
                            //     model.data![index].assets!.preview1500!.url!;
                            return index < urls.length
                                ? SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    //link : response["data"][index]["assets"][quality]["url"],
                                    child: Image.network(
                                      urls[index],
                                      //response["data"][index]["assets"][quality]["url"],
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                            //child: Text("data")
                                            child: CircularProgressIndicator());
                                      },
                                    ))
                                : Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          }),
                    )
                  ],
                ),
              )

        // Main List view
        // ListView.builder(
        //     itemCount: response["data"].length,
        //     itemBuilder: ((context, index) => SizedBox(
        //           width: double.infinity,
        //           height: 200,
        //           child: Image.network(
        //             response["data"][index]["assets"][quality]["url"],
        //             fit: BoxFit.cover,
        //           ),
        //         )))

        // FutureBuilder(
        //   future: futureAlbum,
        //   builder: (context, snapshot) {
        //     print("hello");
        //     print(snapshot.connectionState);
        //     if (snapshot.hasError) {
        //       print('${snapshot.error}');
        //     } else if (snapshot.hasData) {
        //       print(" 404040 : Has Data");
        //     }
        //     return Text("data");
        //   },
        // )

        );
  }
}
