import 'package:flutter/material.dart';
import 'package:senior_project/Screens/MainPage/Notes/components/noteCard.dart';
import 'package:senior_project/classes/note.dart';
import 'package:senior_project/classes/savedPlant.dart';
import 'package:senior_project/constants.dart';

import 'gardenNoteCard.dart';

bool extended = false;

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BoxShadow elevation;
    if(extended)
      elevation = BoxShadow(
        color: Colors.black45,
        blurRadius: 25,
        offset: Offset(0, 15),
      );
    else elevation = kBoxShadow;
    return Column(
      children: [
        Container(
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
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.02, size.height * 0.01, 0, size.height * 0.01),
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
                          child: Image.asset(
                              'assets/images/plant_grainy_illustration_alinashi.png'),
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
                        '${widget.plant.plantName}',
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
                              fontWeight: FontWeight.w600, color: Colors.amber),
                          children: [
                            TextSpan(
                                text: '${widget.plant.date}',
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
                        // TODO: Extend card when pressed
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
                        // TODO: Extend card when pressed
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
        if(extended)
          SizedBox(
            height: size.height*0.01,
          ),
        if (extended)
          SizedBox(
            height: size.height * 0.3,
            child: ListView.builder(
              itemCount: demoNotes.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: GardenNoteCard(note: demoNotes[index]),
              ),
            ),
          ),
      ],
    );
  }
}
