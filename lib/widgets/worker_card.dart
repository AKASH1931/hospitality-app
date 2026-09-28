import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/worker.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';

class WorkerCard extends StatelessWidget {
  final Worker worker;
  final VoidCallback onTap;
  const WorkerCard({super.key, required this.worker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final fav = app.isFav(worker.id);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Stack(children: [
                Hero(
                  tag: 'avatar-${worker.id}',
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.midnight,
                    child: Text(worker.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
                  ),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 14, height: 14,
                    decoration: BoxDecoration(
                      color: worker.isAvailable ? Colors.green : Colors.grey,
                      shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(worker.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8)),
                        child: Text('⭐ ${worker.rating}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
                  ]),
                  Text('${worker.category} • ${worker.experienceYears}y exp', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(children: [
                    Text('₹${worker.dayRate}/day', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(worker.location, style: TextStyle(color: Colors.grey.shade500, fontSize: 12), overflow: TextOverflow.ellipsis)),
                  ]),
                ]),
              ),
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(fav ? Icons.favorite_rounded : Icons.favorite_border_rounded, key: ValueKey(fav), color: fav ? Colors.red : Colors.grey),
                ),
                onPressed: () => app.toggleFav(worker.id),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
