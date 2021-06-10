import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: LoginWidget(),
        ),
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  initState() {
    initialTimer();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  GlobalKey _keyRed = GlobalKey();

  var gotPosition = false;
  var redPositionX;
  var redPositionY;
  var redWidth;
  var redHeight;

  _afterLayout(_) {
    _getPositions();
    _getSizes();
    setState(() {
      gotPosition = true;
    });
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
    redWidth = sizeRed.width;
    redHeight = sizeRed.height;
  }

  _getPositions() {
    print("beer");
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    print(renderBoxRed);
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed ");
    redPositionY = positionRed.dy;
    redPositionX = positionRed.dx;
  }

  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print('width/height $screenWidth / $screenHeight');

    return Container(
      color: Colors.blue,
      child: Center(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
                  key: _keyRed,
                  color: Colors.red,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.yellow,
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.05,
                      ),
                      Container(
                        color: Colors.yellow,
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.05,
                      )
                    ],
                  ),
                ),
                // ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: startAnimation
                  ? ((redPositionY / 2) - (redHeight / 2))
                  : redPositionY,
              curve: Curves.easeInCubic,
              left: 0.3 * screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.green,
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}