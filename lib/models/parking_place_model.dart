// create this by https://jsontodart.com/
import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingPlaceModel {
  String id;
  String name;
  String? type;
  String? imageUrl;
  String? description;
  Location location;
  int totalNoOfSlots;
  List<int> slotsOnEachFloor;
  List<Slots> slots;

  ParkingPlaceModel({
    required this.id,
    required this.name,
    this.type,
    this.imageUrl,
    this.description,
    required this.location,
    required this.totalNoOfSlots,
    required this.slotsOnEachFloor,
    required this.slots
  });

  ParkingPlaceModel.fromJson(Map<String, dynamic> json) :
    id = json['id'] as String,
    name = json['name'] as String,
    type = json['type'] as String,
    imageUrl = json['image_url'] as String,
    description = json['description'] as String,
    location = Location.fromJson(json['location']),
    totalNoOfSlots = json['total_no_of_slots'],
    slotsOnEachFloor = json['slots_on_each_floor'].cast<int>(),
    slots = (json['slots'] as List).map((dynamic e) => Slots.fromJson(e as Map<String, dynamic>)).toList();

  ParkingPlaceModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) :
    id = json.id,
    name = json['name'],
    type = json['type'],
    imageUrl = json['image_url'],
    description = json['description'],
    location = Location(address: json['location']['address'], latitude: json['location']['latitude'], longitude: json['location']['longitude'], url: json['location']['url']),
    totalNoOfSlots = json['total_no_of_slots'],
    slotsOnEachFloor = json['slots_on_each_floor'].cast<int>(),
    slots = [];

  int getAvailableSlots() {
    int availableSlots = 0;
    for(var slot in slots) {
      if(slot.occupy == 0){
        availableSlots++;
      }
    }
    print(availableSlots);
    return availableSlots;
  }

  String availableSlots() => "${(getAvailableSlots())}/${(slots.length)} available";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['total_no_of_slots'] = this.totalNoOfSlots;
    data['slots_on_each_floor'] = this.slotsOnEachFloor;
    return data;
  }

}

class Location {
  String address;
  double? latitude;
  double? longitude;
  String url;

  Location({
    required this.address,
    this.latitude,
    this.longitude,
    required this.url
  });

  Location.fromJson(Map<String, dynamic> json) :
    address = json['address'],
    latitude = json['latitude'],
    longitude = json['longitude'],
    url = json['url'];

  Location.snapShot(Map<String, dynamic> json) :
    address = json['address'],
    latitude = json['latitude'],
    longitude = json['longitude'],
    url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['url'] = this.url;
    return data;
  }
}

class Slots {
  int no;
  List<String>? types;
  int occupy;

  Slots({
    required this.no,
    this.types,
    required this.occupy
  });

  Slots.fromJson(Map<String, dynamic> json) :
    no = json['no'],
    types = (json['types'] as List).cast<String>().toList(),
    occupy = json['occupy'];

  Slots.fromSnapshot(Map<String, dynamic> json) :
    no = json['no'],
    types = [],
    occupy = json['occupy'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['types'] = this.types;
    data['occupy'] = this.occupy;
    return data;
  }
}
