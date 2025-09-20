import 'dart:math';

import 'package:business_card/colors/colors.dart';
import 'package:business_card/helper/hive_helper.dart';
import 'package:business_card/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home screen.dart';

final _textController3 = TextEditingController();
final _textController4 = TextEditingController();

class noteList extends StatefulWidget {
  late List<Note> listShowed;
  noteList({super.key, required this.listShowed});

  @override
  State<noteList> createState() => _noteListState();
}

class _noteListState extends State<noteList> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return (Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: backgroundColor,
                                title: Text(
                                  'Edit your note!',
                                  style: TextStyle(
                                      color: darkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: backgroundColor),
                                        height: 40,
                                        width: double.infinity,
                                        child: TextField(
                                          autofocus: true,
                                          controller: _textController3,
                                          decoration: InputDecoration(
                                              hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('enter note title'),
                                          )),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: backgroundColor),
                                      height: 40,
                                      width: double.infinity,
                                      child: TextField(
                                          controller: _textController4,
                                          decoration: InputDecoration(
                                              hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('enter note content'),
                                          ))),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Note editedNote = Note(
                                            noteTitle: _textController3.text,
                                            noteText: _textController4.text,
                                            noteColor: widget
                                                .listShowed[index].noteColor);
                                        if (showFavourite == true) {
                                          HiveHelper.editNoteFromFavourite(
                                              widget.listShowed[index],
                                              editedNote);
                                        } else {
                                          HiveHelper.editNote(
                                              index, editedNote);
                                        }

                                        _textController3.text = '';
                                        _textController4.text = '';
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      child: Text('edit',
                                          style: TextStyle(color: darkBlue))),
                                ],
                              ));
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: shadow,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 3))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: widget.listShowed[index].noteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.listShowed[index].noteTitle,
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            widget.listShowed[index].noteText,
                            style: TextStyle(color: white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              HiveHelper.setFavourite(index);
                              setState(() {});
                            },
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              color: backgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (showFavourite == true) {
                                HiveHelper.deleteNoteFromFavourite(
                                    widget.listShowed[index]);
                              } else {
                                HiveHelper.deleteNote(index);
                              }

                              setState(() {});
                            },
                            child: Icon(
                              CupertinoIcons.trash_fill,
                              color: backgroundColor,
                            ),
                          ),
                        ],
                      ))
                ],
              )));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1,
          );
        },
        itemCount: widget.listShowed.length);
  }
}
