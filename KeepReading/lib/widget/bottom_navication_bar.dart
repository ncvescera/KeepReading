import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.jumpToPage,
  }) : super(key: key);

  final Function jumpToPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: BottomAppBar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: Image.asset('assets/button_icons/wires.png'),
                onPressed: () {
                  jumpToPage(5); // normal wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/button.png'), // button
                onPressed: () {
                  jumpToPage(6);
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/simbol.png'),
                onPressed: () {
                  jumpToPage(7); // icons
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/saymon.png'),
                onPressed: () {
                  jumpToPage(8); // Simon says
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/text.png'),
                onPressed: () {
                  jumpToPage(9); // screen words
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/number.png'),
                onPressed: () {
                  jumpToPage(11); // screen numbers
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/morse.png'),
                onPressed: () {
                  jumpToPage(12); // morse
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/complex.png'),
                onPressed: () {
                  jumpToPage(13); // complex wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/cross.png'),
                onPressed: () {
                  jumpToPage(14); // crossed wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/maze.png'),
                onPressed: () {
                  jumpToPage(15); // maze
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/pass.png'),
                onPressed: () {
                  jumpToPage(16); // password
                },
              ),
              IconButton(
                icon: Image.asset('assets/button_icons/knob.png'),
                onPressed: () {
                  jumpToPage(20); // knobs
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
