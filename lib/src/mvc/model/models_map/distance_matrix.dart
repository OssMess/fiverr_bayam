/// Includes result from `GoogleMapsApi`'s `queryDistanceMatrix` route.
class DistanceMatrix {
  DistanceMatrix({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    required this.status,
  });

  final List<String> destinationAddresses;
  final List<String> originAddresses;
  final List<Rows> rows;
  final String status;

  factory DistanceMatrix.fromMap(Map<String, dynamic> json) => DistanceMatrix(
        destinationAddresses:
            List<String>.from(json['destination_addresses'].map((x) => x)),
        originAddresses:
            List<String>.from(json['origin_addresses'].map((x) => x)),
        rows: List<Rows>.from(json['rows'].map((x) => Rows.fromMap(x))),
        status: json['status'],
      );

  int get distance => rows.first.elements.first.distance.value;
  int get duration => rows.first.elements.first.duration.value;
}

class Rows {
  Rows({
    required this.elements,
  });

  final List<Element> elements;

  factory Rows.fromMap(Map<String, dynamic> json) => Rows(
        elements:
            List<Element>.from(json['elements'].map((x) => Element.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'elements': List<dynamic>.from(elements.map((x) => x.toMap())),
      };
}

class Element {
  Element({
    required this.distance,
    required this.duration,
    required this.status,
  });

  final Distance distance;
  final Distance duration;
  final String status;

  factory Element.fromMap(Map<String, dynamic> json) => Element(
        distance: Distance.fromMap(json['distance']),
        duration: Distance.fromMap(json['duration']),
        status: json['status'],
      );

  Map<String, dynamic> toMap() => {
        'distance': distance.toMap(),
        'duration': duration.toMap(),
        'status': status,
      };
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });

  final String text;
  final int value;

  factory Distance.fromMap(Map<String, dynamic> json) => Distance(
        text: json['text'],
        value: json['value'],
      );

  Map<String, dynamic> toMap() => {
        'text': text,
        'value': value,
      };
}
