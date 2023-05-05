import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 250,
      child: Center(
        child: Lottie.network(
          'https://assets7.lottiefiles.com/packages/lf20_3qzrm0wa.json',
        ),
      ),
    );
  }
}
