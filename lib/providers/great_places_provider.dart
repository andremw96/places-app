import 'package:flutter/material.dart';
import 'package:great_place_app/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
}
