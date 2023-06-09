import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  late double width;
   Loading({
    super.key,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 243, 242, 242)),
          borderRadius: BorderRadius.circular(10)),
      child: Shimmer.fromColors(
        baseColor: Color.fromARGB(255, 234, 233, 233),
        highlightColor: Color.fromARGB(255, 255, 255, 255),
        child: const Center(
          child: FittedBox(
            child: Text(
              'Loading',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
