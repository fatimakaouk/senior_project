import 'package:flutter/material.dart';

class Note{

  int id;
  String title,text;
  String image;
  bool reminder;
  String date;

  Note({
    @required this.id,
    this.title,
    @required this.text,
    this.reminder = false,
    this.image,
    this.date,
  });

  void addImage(String image){
    this.image =image;
  }

  void editText(String text){
    this.text =text;
    //edit in db
  }

  void editTitle(String title){
    this.title = title;
    //edit in db
  }
}

List<Note> demoNotes = [
  Note(id: 1,title: 'Growing',text: 'My first tomatoes are growing!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 2,title: 'Dead',text: 'My apples are dead!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 3,title: 'Bugs on apples',text: 'I found bugs on my apple tree!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 4,title: 'Clean',text: 'My garden needs some cleaning\nMaybe do it on monday\nI also need to water some trees.!',date: DateTime.now().toString().split(' ')[0], reminder: true),
  Note(id: 5,title: 'Test',text: 'This is a very long note to test how much you can type in the note without the noteCard widget overflowing and to see if it will at all overflow so im hoping this is long enough, lets test that shall we?',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 6,title: 'Another test but this time its a long title instead! Lets see what happens',text: 'My apples are dead!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 7,title: 'Tests',text: 'My apples are dead!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 8,title: 'Tests',text: 'My apples are dead!',date: DateTime.now().toString().split(' ')[0]),
  Note(id: 9,title: 'Tests',text: 'My apples are dead!',date: DateTime.now().toString().split(' ')[0],reminder: true),
];