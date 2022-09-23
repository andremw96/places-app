import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/db/db_helper.dart';
import 'package:great_place_app/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(
        latitude: 0.0,
        longitude: 0.0,
      ),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      "places",
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("places");
    _items = dataList
        .map(
          (e) => Place(
            id: e["id"],
            title: e["title"],
            location: PlaceLocation(
              latitude: 0.0,
              longitude: 0.0,
            ),
            image: File(e["image"]),
          ),
        )
        .toList();
    notifyListeners();
  }
}
