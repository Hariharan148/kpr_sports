import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.height,
  });

  final height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - height,
          child: Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_3qzrm0wa.json',
          ),
        ),
      ),
    );
  }
}
