import 'package:flutter/material.dart';

class Mycircle extends StatelessWidget {
  final List<dynamic> child;

  Mycircle({this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          
          padding: EdgeInsets.all(4.0),
          child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                image: DecorationImage(image: NetworkImage(this.child[1])),
              ),
            ),
        ),
        SizedBox(height: 10,),
             Text(
                  this.child[0],
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
      ],
    );
  }
}
