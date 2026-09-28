import 'worker.dart';

class Booking {
  final String id;
  final Worker worker;
  final DateTime date;
  final String shift; // Morning / Evening / Full Day
  final String venue;
  final String status; // Confirmed / Pending / Completed
  final int totalPrice;

  Booking({
    required this.id,
    required this.worker,
    required this.date,
    required this.shift,
    required this.venue,
    required this.status,
    required this.totalPrice,
  });
}
