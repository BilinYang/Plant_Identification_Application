import 'package:flutter/material.dart';
int groupValue = 0;

class RadioGroupColumnWidget extends StatefulWidget {
  const RadioGroupColumnWidget({super.key});

  @override
  State<RadioGroupColumnWidget> createState() => _RadioGroupColumnWidget();
}
class _RadioGroupColumnWidget extends State<RadioGroupColumnWidget> {

  int box=0;
  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          Container(
            width: 30,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: 0,
                groupValue: this.box,
                onChanged: (value) {
                  setState(() {
                    this.box = value!;
                  });
                },
              ),
              Text("leaf")
            ],
          ),
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              value: 1,
              groupValue: this.box,
              onChanged: (value) {
                setState(() {
                  this.box = value!;
                });
              },
            ),
            Text("flower")
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: 2,
                groupValue: this.box,
                onChanged: (value) {
                  setState(() {
                    this.box = value!;
                  });
                },
              ),
              Text("fruit")
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: 3,
                groupValue: this.box,
                onChanged: (value) {
                  setState(() {
                    this.box = value!;
                  });
                },
              ),
              Text("bark")
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: 4,
                groupValue: this.box,
                onChanged: (value) {
                  setState(() {
                    this.box = value!;
                  });
                },
              ),
              Text("auto")
            ],
          ),

        ],
      );
  }
}