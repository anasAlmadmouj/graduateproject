import 'package:flutter/material.dart';

class LogoAddingPages extends StatelessWidget {
  const LogoAddingPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: MediaQuery.of(context).size.height/4.5,
          height: MediaQuery.of(context).size.height/4.5,
          child: Image.asset('assets/images/LogoFinal.jpg',
              fit: BoxFit.cover),
        ));
  }
}