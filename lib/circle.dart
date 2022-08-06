import 'package:flutter/material.dart';
class Mycircle extends StatelessWidget {
final List<dynamic> child;

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
                                          this.child[1]
                                          )),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      this.child[0],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),]    
                                )
                              ),
                            );

  }
}