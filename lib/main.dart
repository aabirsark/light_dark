import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool _isON = false;

  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 0.1,
        duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _isON ? Colors.yellow : Colors.grey.shade700,
              )),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 4,
            right: MediaQuery.of(context).size.width / 2 - 4,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          _isON
              ? Positioned(
                  top: 202,
                  left: MediaQuery.of(context).size.width / 2 - 72,
                  right: MediaQuery.of(context).size.width / 2 - 72,
                  child: Transform.scale(
                      scale: _scale,
                      child: Transform.rotate(
                          angle: 3.14,
                          child: GestureDetector(
                            onTapUp: _onTapUp,
                            onTapDown: _onTapDown,
                            onTap: () {
                              setState(() {
                                _isON = false;
                              });
                            },
                            child: Image.asset(
                              'assets/light.png',
                              width: 150,
                            ),
                          ))),
                )
              : Positioned(
                  top: 202,
                  left: MediaQuery.of(context).size.width / 2 - 72,
                  right: MediaQuery.of(context).size.width / 2 - 72,
                  child: Transform.scale(
                      scale: _scale,
                      child: Transform.rotate(
                          angle: 3.14,
                          child: GestureDetector(
                            onTapUp: _onTapUp,
                            onTapDown: _onTapDown,
                            onTap: () {
                              setState(() {
                                _isON = true;
                              });
                            },
                            child: Image.asset(
                              'assets/dusk.png',
                              // color: Colors.grey.shade800,
                              width: 150,
                            ),
                          ))),
                )
        ],
      ),
    );
  }

  void _onTapUp(TapUpDetails _) {
    _controller.forward();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.reverse();
  }
}
