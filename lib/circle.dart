import 'package:flutter/material.dart';
class Mycircle extends StatelessWidget {
final String child;

Mycircle({this.child});

  @override
  Widget build(BuildContext context) {
    return   Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                height: 92,
                                width: 92,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://arbaminch.gov.et/sites/default/files/images/office/football.jpg')),
                                ),
                                child: Text('',style: TextStyle()),
                              ),
                            );

  }
}