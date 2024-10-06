import 'package:bpt_gamer/hangman/hangman.dart';
import 'package:bpt_gamer/plant_identification_app/plantmain.dart';
import 'package:flutter/material.dart';

import 'camera/usecamera.dart';
import 'const.dart';
import 'discover_child_page.dart';
import 'flip/flip.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String imageName;
  final String? subImageName;
  final int index;

  DiscoverCell({
    required this.title,
    this.subTitle,
    required this.imageName,
    this.subImageName,
    required this.index,
}) : assert(title != null, 'title cannot be empty！'),assert(imageName != null,'imageName cannot be empty！ ');

  @override
  State<StatefulWidget> createState() => _DiscoverCellState();
}


class _DiscoverCellState extends State<DiscoverCell>{
  Color _currentColor = Colors.white;
  List <Widget> _programs = [Hangman(),FlutterFlipApp(), ScanScreen(title:'here'), PlantIdentificationApp(), PlantIdentificationApp()];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder:
          //         (BuildContext context) =>
          //         DiscoverChildPage(
          //           title: widget.title,
          //         )));
          Navigator.of(context).push(
              MaterialPageRoute(builder:
                  (BuildContext context) =>
                  _programs[widget.index]));
          setState(() {
            _currentColor = Colors.white;
          });
        },
        onTapDown: (TapDownDetails details) {
          setState(() {
            _currentColor = Colors.grey;
          });
        },
        onTapCancel: (){
          setState(() {
            _currentColor = Colors.white;
          });
        },
        child: Container(
          height: 150,
          //width: screenWidth * 0.5,
          //color: Colors.yellow,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              //

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                        image: AssetImage(widget.imageName))),
                // Image(
                //   image: AssetImage(widget.imageName),
                //   width: 80,
                // ),
              ),
              //
              SizedBox(width: 15,),
              //title
              Text(widget.title,
              style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
            //spaceBetween

    );
  }
}