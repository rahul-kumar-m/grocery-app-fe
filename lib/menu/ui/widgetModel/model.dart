import 'package:flutter/material.dart';

class TextButtonCustom extends StatefulWidget {
  final String text;
  const TextButtonCustom({super.key, required this.text});

  @override
  State<TextButtonCustom> createState() => _TextButtonCustomState(text:text);
}

class _TextButtonCustomState extends State<TextButtonCustom> {
  final String text;

  _TextButtonCustomState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.10,
      width: MediaQuery.of(context).size.width*0.80,
      //padding:EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 15, 10, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //border: Border.all(width: 1.0,color:Colors.black54),
        color : Colors.teal[700],
        backgroundBlendMode: BlendMode.luminosity
      ),
      child: FilledButton(onPressed: (){}, child: Text(text),)
    );
  }
}
