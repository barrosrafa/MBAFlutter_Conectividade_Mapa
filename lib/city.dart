class City {

  final String city;
  final String state;
  final double latitude;
  final double longitude;

  City(this.city, this.state, this.latitude, this.longitude);

  City.fromMap(Map<String, dynamic> map)
      : city = map['city'],
        state = map['state'],
        latitude = double.parse(map['latitude']),
        longitude = double.parse(map['longitude']);

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude
  };

}
