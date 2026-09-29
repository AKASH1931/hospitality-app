import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/worker.dart';
import '../data/app_state.dart';

/// District-style image-first card: photo upar, info neeche
class WorkerCard extends StatelessWidget {
  final Worker worker;
  final VoidCallback onTap;
  const WorkerCard({super.key, required this.worker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final fav = app.isFav(worker.id);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'img-${worker.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                      child: Image.network(
                        worker.imageUrl,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (c, child, p) =>
                            p == null ? child : Container(height: 170, color: Colors.grey.shade200, child: const Center(child: CircularProgressIndicator())),
                        errorBuilder: (c, e, s) => Container(
                          height: 170,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xFF0B1B2B), Color(0xFF243B55)]),
                          ),
                          child: Center(child: Text(worker.name[0], style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w800))),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12, bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Text('⭐ ${worker.rating} (${worker.reviewsCount})', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ),
                  Positioned(
                    right: 10, top: 10,
                    child: GestureDetector(
                      onTap: () => app.toggleFav(worker.id),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              key: ValueKey(fav), color: fav ? Colors.red : Colors.grey, size: 20),
                        ),
                      ),
                    ),
                  ),
                  if (!worker.isAvailable)
                    Positioned(
                      left: 12, top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                        child: const Text('BUSY', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(worker.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                          Text('${worker.category} • ${worker.experienceYears}y exp • ${worker.location}',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13), overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text('₹${worker.dayRate}/day', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              const SizedBox(width: 8),
                              if (worker.isAvailable)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                                  child: Text('Available', style: TextStyle(color: Colors.green.shade800, fontSize: 11, fontWeight: FontWeight.w700)),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(color: const Color(0xFF0B1B2B), borderRadius: BorderRadius.circular(12)),
                      child: const Text('Hire →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
