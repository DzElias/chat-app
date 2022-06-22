import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key, 
    required this.routeName, 
    required this.ftext, 
    required this.ltext
  }) : super(key: key);

  final String routeName;
  final String ftext;
  final String ltext;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text( ftext, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 )),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(
            ltext, 
            style: TextStyle(
              color: Colors.blue[600], 
              fontSize: 18, 
              fontWeight: FontWeight.bold
            )),

            onTap: (){
              Navigator.pushReplacementNamed(context, routeName);
            },
          
          )
        ],
      ),
    );
  }
}