class Booking {
  final String propertyName;
  final String propertyAddress;
  final int propertyRent;
  final String propertyType;
  final int propertyBalconyCount;
  final int propertyBedroomCount;
  final DateTime propertyDate;
  int bookingRemaining; // Change from final to regular instance variable

  Booking({
    required this.propertyName,
    required this.propertyAddress,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
    required this.bookingRemaining,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      propertyName: json['propertyName'] ?? '',
      propertyAddress: json['propertyAddress'] ?? '',
      propertyRent: json['propertyRent'] ?? 0,
      propertyType: json['propertyType'] ?? '',
      propertyBalconyCount: json['propertyBalconyCount'] ?? 0,
      propertyBedroomCount: json['propertyBedroomCount'] ?? 0,
      propertyDate: json['propertyDate'] != null ? DateTime.parse(json['propertyDate']) : DateTime.now(),
      bookingRemaining: json['bookingRemaining'] ?? 0,
    );
  }
}
