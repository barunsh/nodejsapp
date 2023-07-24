class Property {
  final String propertyAddress;
  final String ownerName;
  final String propertyLocality;
  final String propertyRent;
  final String propertyType;
  final int propertyBalconyCount;
  final int propertyBedroomCount;
  final DateTime propertyDate;
  final String prop;
  int bookingRemaining;
  String? email;
  int? phone;
  String? names; // Change from final to regular instance variable

  Property({
    required this.propertyAddress,
    required this.ownerName,
    required this.propertyLocality,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
    required this.bookingRemaining,
    required this.prop,
    this.email,
    this.phone,
    this.names,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyAddress: json['propertyAddress'] ?? '',
      ownerName: json['ownerName'] ?? '',
      propertyLocality: json['propertyLocality'] ?? '',
      propertyRent: json['propertyRent'] ?? 0,
      propertyType: json['propertyType'] ?? '',
      propertyBalconyCount: json['propertyBalconyCount'] ?? 0,
      propertyBedroomCount: json['propertyBedroomCount'] ?? 0,
      propertyDate: json['propertyDate'] != null ? DateTime.parse(json['propertyDate']) : DateTime.now(),
      bookingRemaining: json['bookingRemaining'] ?? 0,
      email: json['email'],
      phone: json['phone'],
      names: json['names'],
      prop: json['prop'] ?? '',
    );
  }
}
