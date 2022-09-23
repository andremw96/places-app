import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/db/db_helper.dart';
import 'package:great_place_app/db/location_helper.dart';
import 'package:great_place_app/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updatedLocation,
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
        "loc_lat": newPlace.location.latitude,
        "loc_lng": newPlace.location.longitude,
        "address": newPlace.location.address,
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
              latitude: e["loc_lat"],
              longitude: e["loc_lng"],
              address: e["address"],
            ),
            image: File(e["image"]),
          ),
        )
        .toList();
    notifyListeners();
  }
}
