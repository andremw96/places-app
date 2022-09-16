import 'package:flutter/material.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/screens/add_place_screen.dart';
import 'package:great_place_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => GreatPlacesProvider()),
      child: MaterialApp(
        title: 'Greate Place',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
