import 'package:flutter/material.dart';
import '../models/booking.dart';

class AppState extends ChangeNotifier {
  String? role; // 'brand' or 'worker'
  final List<Booking> _bookings = [];
  final Set<String> _favorites = {};

  List<Booking> get bookings => List.unmodifiable(_bookings);
  bool isFav(String id) => _favorites.contains(id);

  void setRole(String r) {
    role = r;
    notifyListeners();
  }

  void toggleFav(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }

  void addBooking(Booking b) {
    _bookings.insert(0, b);
    notifyListeners();
  }
}
