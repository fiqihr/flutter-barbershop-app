import 'dart:developer';
import 'package:flutter/material.dart';
import '../pages/services.dart';
import '../pages/barberman.dart';
import '../pages/booking.dart';

class mainMenu extends StatelessWidget {
  const mainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              height: 550,
              decoration: BoxDecoration(
                // color: Color(0xFF1D1D1D),
                color: Color(0xFF1D1D1D),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFF1d1d1d),
                    // color: Colors.white,
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 130,
                      width: 490,
                      decoration: BoxDecoration(
                        color: Color(0xFF1d1d1d),
                        // color: Color(0xFF131311),
                        // color: Colors.grey[300],
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // color: Colors.white,
                            color: Colors.grey[300],
                            // color: Color(0xFF1d1d1d),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 95,
                                width: 95,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Center(
                                      child: IconButton(
                                        iconSize: 50,
                                        icon: Image.asset(
                                          'icons/barbershop1.png',
                                          width: 55,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Booking(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "Booking",
                                        style: TextStyle(
                                          color: Color(0xFF1d1d1d),
                                          fontSize: 12,
                                          // color: Colors.white, fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // color: Colors.white,
                            color: Colors.grey[300],
                            // color: Color(0xFF131311),
                          ),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.amber,
                                height: 95,
                                width: 95,
                                // child: Center(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Center(
                                      child: IconButton(
                                        iconSize: 50,
                                        icon: Image.asset(
                                          'icons/hairdresser.png',
                                          width: 55,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Barberman(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "Barberman",
                                        style: TextStyle(
                                          color: Color(0xFF131311),
                                          // color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // color: Colors.white,
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.amber,
                                height: 95,
                                width: 95,
                                // child: Center(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Center(
                                      child: IconButton(
                                        iconSize: 50,
                                        icon: Image.asset(
                                          'icons/barber-chair.png',
                                          width: 55,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Service(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "Services",
                                        style: TextStyle(
                                          color: Color(0xFF131311),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 25),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
