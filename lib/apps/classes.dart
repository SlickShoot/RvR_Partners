import 'package:flutter/material.dart';
import '../router/router.dart';


class RvRPartners extends StatelessWidget {
  const RvRPartners({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: routes,
    );
  }
}