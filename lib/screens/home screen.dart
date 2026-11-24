import 'dart:math';

import 'package:business_card/colors/colors.dart';

import 'package:business_card/components/notesList.dart';
import 'package:business_card/components/welcomeNote.dart';
import 'package:business_card/helper/hive_helper.dart';
import 'package:business_card/model/note.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

List<Color> colors = [darkBlue, lightBlue, lightGreen, yellow];

final _textController = TextEditingController();
final _textController2 = TextEditingController();
bool showFavourite = false;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text(
          'DayFlow.',
          style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                HiveHelper.removeAll();

                setState(() {});
              },
              child: Icon(
                CupertinoIcons.trash_fill,
                color: yellow,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            welcomeNote(),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: darkBlue, width: 1),
                    color: getContainerColor(!showFavourite),
                  ),
                  height: 40,
                  width: 70,
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      showFavourite = false;
                      setState(() {});
                    },
                    child: Text(
                      'All',
                      style: TextStyle(
                          color: getTextColor(!showFavourite),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: darkBlue, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: getContainerColor(showFavourite),
                  ),
                  height: 40,
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      showFavourite = true;
                      setState(() {});
                    },
                    child: Text(
                      'Favourites',
                      style: TextStyle(
                          color: getTextColor(showFavourite),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                )
              ],
            ),
            Expanded(child: noteList(listShowed: getShownList())),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: darkBlue,
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: darkBlue,
                    title: Text(
                      'A new note!',
                      style:
                          TextStyle(color: yellow, fontWeight: FontWeight.bold),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: backgroundColor),
                            height: 40,
                            width: double.infinity,
                            child: TextField(
                              autofocus: true,
                              controller: _textController,
                              decoration: InputDecoration(
                                  hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('enter note title'),
                              )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: backgroundColor),
                          height: 40,
                          width: double.infinity,
                          child: TextField(
                              controller: _textController2,
                              decoration: InputDecoration(
                                  hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('enter note content'),
                              ))),
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Random random = Random();
                            Color randomColor =
                                colors[random.nextInt(colors.length)];
                            HiveHelper.addNote(
                                noteTitle: _textController.text,
                                noteText: _textController2.text,
                                color: randomColor);
                            _textController.text = '';
                            _textController2.text = '';
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: Text('add', style: TextStyle(color: yellow))),
                      TextButton(
                        child: Text('Cancel', style: TextStyle(color: yellow)),
                        onPressed: () {
                          _textController.text = "";
                          _textController2.text = '';
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
        },
        child: Icon(
          Icons.add,
          color: yellow,
          size: 27,
        ),
      ),
    ));
  }
}

List<dynamic> getShownList() {
  if (showFavourite == true) {
    return HiveHelper.notes.where((e) => e.isFavourite == true).toList();
  } else {
    return HiveHelper.notes;
  }
}

Color getContainerColor(bool test) {
  if (test == true)
    return darkBlue;
  else
    return backgroundColor;
}

Color getTextColor(bool test) {
  if (test == true)
    return yellow;
  else
    return darkBlue;
}
