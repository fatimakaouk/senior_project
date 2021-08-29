import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:senior_project/Screens/MainPage/MyGarden/viewPlant.dart';
import 'package:senior_project/Screens/MainPage/Notes/addNote.dart';
import 'package:senior_project/classes/note.dart';
import 'package:senior_project/classes/plant.dart';
import 'package:senior_project/classes/savedPlant.dart';
import 'package:senior_project/constants.dart';
import 'package:senior_project/services/plant.services.dart';
import 'gardenNoteCard.dart';

PlantService _plantService = PlantService();
List<Note> demoNotes = [];
double maxHeight;

class PlantCard extends StatefulWidget {
  const PlantCard({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final SavedPlant plant;

  @override
  _PlantCardState createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  bool extended = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BoxShadow elevation;
    if (extended)
      elevation = BoxShadow(
        color: Colors.black45,
        blurRadius: 25,
        offset: Offset(0, 15),
      );
    else
      elevation = kBoxShadow;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Plant p = await _plantService.getPlant(widget.plant.idplant);
            if (p != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPlant(
                            plant: p,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: kPrimaryLightColor,
              boxShadow: [elevation],
            ),
            height: size.height * 0.15,
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.02,
                    size.height * 0.01, 0, size.height * 0.01),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: size.width * 0.25,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          //this child should be an image
                          child: Hero(
                            tag: 'details-${widget.plant.id}',
                            child: Image.asset('${widget.plant.imagePath}'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: size.width * 0.4,
                          child: Text(
                            '${widget.plant.addedName}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0),
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Text(
                          '${widget.plant.name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              letterSpacing: 1.0),
                          maxLines: 1,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.amber),
                            children: [
                              TextSpan(
                                  text: '${widget.plant.date.split("T")[0]}',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    if (!extended)
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          setState(() {
                            if (extended == true)
                              extended = false;
                            else
                              extended = true;
                          });
                        },
                      ),
                    if (extended)
                      IconButton(
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          setState(() {
                            if (extended == true)
                              extended = false;
                            else
                              extended = true;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (extended)
          SizedBox(
            height: size.height * 0.01,
          ),
        if (extended) NotesListWidget(widget.plant.id),
      ],
    );
  }
}

class NotesListWidget extends StatefulWidget {
  int savedPlantid;

  NotesListWidget(int id);

  @override
  _NotesListWidgetState createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Note>>(
        future: _plantService
            .getNotes(widget.savedPlantid)
            .then((value) => demoNotes = value),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            if (demoNotes.length < 2)
              maxHeight = size.height * 0.15;
            else
              maxHeight = size.height * 0.3;
            if (demoNotes.length == 0)
              return SizedBox(
                height: size.height * 0.1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.height*0.01),
                      child: Text(
                        'No notes attached to this plant.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNote(savedPlantId: widget.savedPlantid)));
                      },
                      child: Icon(Icons.add),
                      backgroundColor: kPrimaryColor,
                    ),
                  ],
                ),
              );
            else
              return LimitedBox(
                maxHeight: maxHeight,
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: demoNotes.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Dismissible(
                          key: Key(demoNotes[index].id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              demoNotes.removeAt(index);
                            });
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(Icons.delete),
                              ],
                            ),
                          ),
                          child: GardenNoteCard(note: demoNotes[index]),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, size.width * 0.07, size.width * 0.05),
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddNote(savedPlantId: widget.savedPlantid)));
                                },
                                child: Icon(Icons.add),
                                backgroundColor: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
          } else {
            return SizedBox(
                width: size.width,
                child: SpinKitThreeBounce(
                  color: kPrimaryColor,
                  size: 30.0,
                ));
          }
        });
  }
}
