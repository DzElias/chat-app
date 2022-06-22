
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key, 
    this.onPressed, 
    required this.text,
    
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape:     const StadiumBorder(),
        padding:   const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(text)
        )
      )
    );
  }
}