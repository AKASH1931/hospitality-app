import 'package:flutter/material.dart';
import '../models/worker.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import 'booking_screen.dart';

class WorkerDetailScreen extends StatelessWidget {
  final Worker worker;
  const WorkerDetailScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF0B1B2B), Color(0xFF243B55)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: SafeArea(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Hero(
                      tag: 'avatar-${worker.id}',
                      child: CircleAvatar(radius: 44, backgroundColor: AppTheme.gold, child: Text(worker.name[0], style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.w800))),
                    ),
                    const SizedBox(height: 10),
                    Text(worker.name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                    Text('${worker.category} • ⭐ ${worker.rating} (${worker.reviewsCount})', style: const TextStyle(color: Colors.white70)),
                  ]),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  _pill(worker.isAvailable ? '● Available' : '● Busy', worker.isAvailable ? Colors.green : Colors.grey),
                  const SizedBox(width: 8),
                  _pill('${worker.experienceYears}y experience', AppTheme.midnight),
                ]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('₹${worker.dayRate}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                      const Text('/ per day', style: TextStyle(color: Colors.grey)),
                    ]),
                    const Spacer(),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      const Icon(Icons.location_on_rounded, size: 18),
                      Text(worker.location, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ]),
                  ]),
                ),
                const SizedBox(height: 18),
                const Text('Skills', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: worker.skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: AppTheme.midnight.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Text(s, style: const TextStyle(fontWeight: FontWeight.w600)))).toList()),
                const SizedBox(height: 18),
                const Text('About', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(worker.about, style: TextStyle(color: Colors.grey.shade700, height: 1.5)),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)]),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: worker.isAvailable ? () => Navigator.push(context, seamlessRoute(BookingScreen(worker: worker))) : null,
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
      child: Text(t, style: TextStyle(color: c == Colors.grey ? Colors.grey.shade700 : c, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}
