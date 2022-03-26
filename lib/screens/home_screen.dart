import 'dart:io';

import 'package:cooking_papa/screens/ingredient_screen.dart';
import 'package:cooking_papa/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 8
            // title: Text(_pages[_selectedPageIndex]['title']),
            ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Find best recipes for cooking',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: Color.fromARGB(255, 187, 187, 187)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  // _authData['email'] = value;
                },
              ),
            ),
            ImagePickerButton(onImageSelected: onImageSelected)
          ]),
        ));
  }

  onImageSelected(XFile p1) async {
    File receiptFile = File(p1.path);
    var bytes = receiptFile.readAsBytesSync();
    String base64Image = convert.base64Encode(bytes);
    print(base64Image);
    var exclude = [
      "Food",
      "Ingredient",
      "Natural foods",
      "Tableware",
      "Recipe",
      "Dishware",
      "Food group",
      "Cuisine",
      "Dish",
      "Whole food",
      "Produce",
    ];
    var url = Uri.https('vision.googleapis.com', '/v1/images:annotate',
        {'key': 'AIzaSyDoMQOH0kHkPPo25OCxCZ2_oPaeRKNeXac'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode({
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [
              {"type": "OBJECT_LOCALIZATION"}
            ],
          }
        ]
      }),
    );

    // // Await the http get response, then decode the json-formatted response.
    // var response2 = await http.post(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: convert.jsonEncode({
    //     "requests": [
    //       {
    //         "image": {"content": base64Image},
    //         "features": [
    //           {"type": "LABEL_DETECTION"}
    //         ],
    //       }
    //     ]
    //   }),
    // );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var jsonResponse2 = convert.jsonDecode(response2.body);
      var data = jsonResponse["responses"][0]["localizedObjectAnnotations"];
      // var data2 = jsonResponse["responses"][0]["labelAnnotations"];
      var itemList = '';
      for (var i = 0; i < data.length; i++) {
        itemList += data[i]["name"] + ',';
      }
      // if (itemList.length != 0) {
      await Navigator.of(context).pushNamed(
        IngredientScreen.routeName,
        arguments: {
          'image': base64Image,
          'ingredients': itemList,
        },
      );
      // }
      // print(jsonResponse2);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
