// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shutter_api/json.dart';
import 'package:shutter_api/models/ShutterStockModel.dart';
import 'package:shutter_api/models/hmodel.dart';
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
  int length = 4;
  var box = Hive.box<hmodel>("HiveModalBox");
  addDataToHive(List<Data> data) async {
    await box.clear();
    // print("5050 : " + data.length.toString());
    for (int i = 0; i < length; i++) {
      // var hiveModel = hmodel(hurls: data[i].assets!.preview!.url!);
      // box.add(hiveModel);
      var hiveModel;
      switch (quality) {
        case "preview":
          hiveModel = hmodel(hurls: data[i].assets!.preview!.url!);
          break;
        case "small_thumb":
          hiveModel = hmodel(hurls: data[i].assets!.smallThumb!.url!);
          break;
        case "large_thumb":
          hiveModel = hmodel(hurls: data[i].assets!.largeThumb!.url!);
          break;
        case "huge_thumb":
          hiveModel = hmodel(hurls: data[i].assets!.hugeThumb!.url!);
          break;
        case "preview_1000":
          hiveModel = hmodel(hurls: data[i].assets!.preview1000!.url!);
          break;
        case "preview_1500":
          hiveModel = hmodel(hurls: data[i].assets!.preview1500!.url!);
          break;

        default:
          hiveModel = hmodel(hurls: data[i].assets!.preview!.url!);
      }
      box.add(hiveModel);
      // if (quality == "preview") {
      //   var hiveModel = hmodel(hurls: data[i].assets!.preview!.url!);
      //   box.add(hiveModel);
      // } else if (quality == "small_thumb") {
      //   var hiveModel = hmodel(hurls: data[i].assets!.smallThumb!.url!);
      //   box.add(hiveModel);
      // }
      // print("4040 : " + hiveModel.hurls);

    }
  }

  Future imageLoader() async {
    //print("2");
    response = await fetchJson();
    // print(response);
    setState(() {
      // print("3");
      response = response;
      // print("4");
      model = ShutterStockModel.fromJson(response);

      addDataToHive(model.data!);
      // print("hello");
      // print(model);
      // print(model.data![0].assets!.preview!.url!);
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
        (length < 20)) {
      print("pass 1");
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        length = length + 2;
        addDataToHive(model.data!);
      });
    }
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
            :
            // child: Text(model.data![index].aspect.toString()),
            // child: Text(model.search_id!),
            // Container(
            //     child: Text("hello"),
            //   )
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // DecoratedBox(
                    //   decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     border: Border.all(color: Colors.black38, width: 3),
                    //     borderRadius: BorderRadius.circular(50),
                    //   ),
                    // ),
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
                                addDataToHive(model.data!);
                                // print(quality);
                                scrollcontroller.position.moveTo(0);
                                length = 4;
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
                          itemCount: length < 20 ? length + 1 : length,
                          itemBuilder: (context, index) =>
                              ValueListenableBuilder<Box<hmodel>>(
                                  valueListenable: box.listenable(),
                                  builder: (context, mybox, _) {
                                    final hiveModelBox =
                                        mybox.values.toList().cast<hmodel>();
                                    // print(
                                    //     "40401 : " + hiveModelBox[index].hurls);
                                    return index < length
                                        ? SizedBox(
                                            height: 300,
                                            width: double.infinity,
                                            child:
                                                // Text(hiveModelBox[index].hurls)
                                                Image.network(
                                              hiveModelBox[index].hurls,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                            // Image.network(response["data"][index]
                                            //             ["assets"][quality]["url"]) ==
                                            //         ConnectionState.waiting
                                            //     ? Center(child: CircularProgressIndicator())
                                            //     : Image.network(
                                            //         response["data"][index]["assets"][quality]
                                            //             ["url"],
                                            //         fit: BoxFit.cover,
                                            //       ),
                                            //   Image.network(
                                            // response["data"][index]["assets"][quality]
                                            //     ["url"],
                                            // fit: BoxFit.cover,
                                          )
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 18),
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                  })

                          // {
                          //   return SizedBox(
                          //       height: 300,
                          //       width: double.infinity,
                          //       //link : response["data"][index]["assets"][quality]["url"],
                          //       child: Image.network(
                          //         model.data![index].assets!.preview!.url!,
                          //         //response["data"][index]["assets"][quality]["url"],
                          //         fit: BoxFit.cover,
                          //         loadingBuilder:
                          //             (context, child, loadingProgress) {
                          //           if (loadingProgress == null) return child;
                          //           return const Center(
                          //               child: CircularProgressIndicator());
                          //         },
                          //       )
                          //       // Image.network(response["data"][index]
                          //       //             ["assets"][quality]["url"]) ==
                          //       //         ConnectionState.waiting
                          //       //     ? Center(child: CircularProgressIndicator())
                          //       //     : Image.network(
                          //       //         response["data"][index]["assets"][quality]
                          //       //             ["url"],
                          //       //         fit: BoxFit.cover,
                          //       //       ),
                          //       //   Image.network(
                          //       // response["data"][index]["assets"][quality]
                          //       //     ["url"],
                          //       // fit: BoxFit.cover,
                          //       );
                          // }

                          ),
                    )
                    // ListView.builder(
                    //     itemCount: response["data"].length,
                    //     itemBuilder: ((context, index) => SizedBox(
                    //           // width: double.infinity,
                    //           // height: 200,
                    //           child: Image.network(
                    //             response["data"][index]["assets"][quality]
                    //                 ["url"],
                    //             // fit: BoxFit.cover,
                    //           ),
                    //         )))
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
