import 'package:flutter/material.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

class BuildDropdown extends StatefulWidget {
  List array;
  String hintText;
  String dropdownValue;
  BuildDropdown(this.dropdownValue, this.array, this.hintText);

  @override
  _BuildDropdownState createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
          child: Align(
        alignment: Alignment.bottomLeft,
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(widget.hintText == null ? widget.dropdownValue.toString() : widget.hintText,
            style: TextStyle(
                color: Colors.blueGrey,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w800,
                fontSize: 18),
          ),
          value: widget.dropdownValue,
          icon: Icon(Icons.arrow_drop_down, color: Constants.mainColor),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.blueGrey,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w800,
              fontSize: 18),
          underline: Container(
            height: 2,
            color: Constants.mainColor,
          ),
          onChanged: (String newValue) {
            setState(() {
              widget.dropdownValue = newValue;
            });
          },
          items: widget.array.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
