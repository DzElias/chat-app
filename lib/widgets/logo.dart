import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key, 
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            const Image( image: AssetImage('assets/tag-logo.png') ),
            const SizedBox(height: 20,),
            Text(title, style: const TextStyle(fontSize: 30))
          ],
        ),
      )
    );
  }
}