import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/shared/components/components.dart';

class SelectRoom extends StatelessWidget {
  const SelectRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text("Select Room",
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          IconButton(
              //function
              onPressed: (){},
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              InkWell(
                  child: Container(
                    //color: Colors.white24,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Room Id',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Row(
                            children: [
                              Text(
                                'Xo game/ ahmed need to play with you',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////edit here>>>
                  onTap: (){
                    navigateBack(context, HomeLayoutScreen());
                  },
                ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
              Divider(
                color: Colors.white54,
              ),
              InkWell(
                child: Container(
                  //color: Colors.white24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room Id',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(
                              'Xo game/ ahmed need to play with you',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////edit here>>>
                onTap: (){
                  navigateBack(context, HomeLayoutScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
