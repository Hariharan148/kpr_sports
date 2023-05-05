import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
    required this.onCancelPressed,
    required this.onSubmitPressed,
  }) : super(key: key);

  final VoidCallback onCancelPressed;
  final VoidCallback onSubmitPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 145,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFFA8A9AC),
                  Color(0xFFE0E1E2)
                  //add more colors
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: onCancelPressed,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 145,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF319753),
                  Color(0xFF4DC274)
                  //add more colors
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: onSubmitPressed,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
