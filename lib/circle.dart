import 'package:flutter/material.dart';
class Mycircle extends StatelessWidget {
final List<dynamic> child;

Mycircle({this.child});

  @override
  Widget build(BuildContext context) {
    return   Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          this.child[1]
                                          )),
                                ),
                                child: Column(
                                
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