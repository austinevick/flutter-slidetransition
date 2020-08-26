import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  final Animation<double> transitionAnimation;

  const SecondPage({Key key, this.transitionAnimation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SlidingContainer(
            image: 'images/greenf.jpeg',
            initialOffsetX: 1,
            intervalEnd: 0.5,
            intervalStart: 0,
            color: Colors.purple,
          )),
          Expanded(
              child: SlidingContainer(
            image: 'images/pinkf.jpg',
            initialOffsetX: -1,
            intervalEnd: 1,
            intervalStart: 0.5,
            color: Colors.green,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text('Go Back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SlidingContainer extends StatelessWidget {
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final Color color;
  final String image;

  const SlidingContainer(
      {Key key,
      this.image,
      this.initialOffsetX,
      this.intervalStart,
      this.intervalEnd,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          child: child,
          position: Tween<Offset>(
            begin: Offset(initialOffsetX, 0),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(intervalStart, intervalEnd,
                  curve: Curves.easeInOutCubic),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.darken))),
      ),
    );
  }
}
