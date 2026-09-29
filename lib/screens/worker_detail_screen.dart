import 'package:flutter/material.dart';
import '../models/worker.dart';
import '../main.dart';
import 'booking_screen.dart';

/// District-style detail: big photo header, info card overlapping
class WorkerDetailScreen extends StatelessWidget {
  final Worker worker;
  const WorkerDetailScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'img-${worker.id}',
                child: Image.network(
                  worker.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: const Color(0xFF0B1B2B)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFFAF7F2), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(worker.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                              Text('${worker.category} • ${worker.location}', style: TextStyle(color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(12)),
                          child: Text('⭐ ${worker.rating}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('${worker.reviewsCount} reviews • ${worker.experienceYears} yrs experience',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    const SizedBox(height: 14),
                    Row(children: [
                      _pill(worker.isAvailable ? '● Available' : '● Busy',
                          worker.isAvailable ? Colors.green.shade700 : Colors.grey),
                      const SizedBox(width: 8),
                      _pill('₹${worker.dayRate}/day', const Color(0xFF0B1B2B)),
                    ]),
                    const SizedBox(height: 16),
                    const Text('Skills', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: worker.skills.map((s) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                        child: Text(s, style: const TextStyle(fontWeight: FontWeight.w600)),
                      )).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text('About', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(worker.about, style: TextStyle(color: Colors.grey.shade700, height: 1.55, fontSize: 15)),
                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)]),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: worker.isAvailable
                ? () => Navigator.push(context, seamlessRoute(BookingScreen(worker: worker)))
                : null,
            child: Text(worker.isAvailable ? 'Hire Now • ₹${worker.dayRate}/day' : 'Currently Busy'),
          ),
        ),
      ),
    );
  }

  Widget _pill(String t, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}
