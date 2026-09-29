import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../data/app_state.dart';

/// District-style bookings: photo thumbnails ke saath
class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = context.watch<AppState>().bookings;
    return Scaffold(
      appBar: AppBar(title: const Text('My bookings')),
      body: bookings.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=400&q=60',
                        width: 180, height: 130, fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(width: 180, height: 130, color: Colors.grey.shade200, child: const Icon(Icons.calendar_month_rounded, size: 44)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('No bookings yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    Text('Home se kisi chef ya decor ko hire karo', style: TextStyle(color: Colors.grey.shade600), textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              itemCount: bookings.length,
              itemBuilder: (_, i) {
                final b = bookings[i];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'img-${b.worker.id}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                          child: Image.network(b.worker.imageUrl, width: 92, height: 92, fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(width: 92, height: 92, color: const Color(0xFF0B1B2B), child: Center(child: Text(b.worker.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24)))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${b.worker.name} • ${b.worker.category}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                              Text('${DateFormat('EEE, dd MMM').format(b.date)} • ${b.shift}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                              Text('₹${b.totalPrice}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                        child: Text(b.status, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w700, fontSize: 11)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
