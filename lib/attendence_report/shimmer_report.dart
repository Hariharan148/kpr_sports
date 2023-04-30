import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgetReport extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const ShimmerWidgetReport({
    Key? key,
    this.height = 250,
    this.width = 0,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
