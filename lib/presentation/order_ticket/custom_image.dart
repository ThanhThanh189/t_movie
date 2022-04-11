import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            'https://picsum.photos/250?image=9',
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          ),
        )),
      ),
    ));
  }
}
