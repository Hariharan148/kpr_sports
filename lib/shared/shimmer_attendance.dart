import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const ShimmerWidget({
    Key? key,
    this.height = 50.0,
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

class ShimmerCardList extends StatelessWidget {
  final int itemCount;

  const ShimmerCardList({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: ShimmerWidget(),
        );
      },
    );
  }
}
