import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyList extends StatelessWidget {
  final String name;
  const EmptyList(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child:  Center(
        child: Text(name),
      ),
    );
  }
}
