import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../widgets/worker_card.dart';
import 'worker_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSearchTap;
  const HomeScreen({super.key, required this.onSearchTap});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = 'All';

  IconData _iconFor(String c) {
    switch (c) {
      case 'Chef': return Icons.restaurant_menu_rounded;
      case 'Waiter': return Icons.room_service_rounded;
      case 'Bartender': return Icons.local_bar_rounded;
      case 'Housekeeping': return Icons.cleaning_services_rounded;
      case 'Decor': return Icons.celebration_rounded;
      case 'Manager': return Icons.manage_accounts_rounded;
      default: return Icons.grid_view_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = selected == 'All'
        ? dummyWorkers
        : dummyWorkers.where((w) => w.category == selected).toList();
    final featured = dummyWorkers.where((w) => w.rating >= 4.7).toList();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => setState(() {}),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('📍 Delhi NCR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          Text('Namaste, Brand 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                        ]),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(onPressed: widget.onSearchTap, icon: const Icon(Icons.notifications_rounded)),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => Navigator.push(context, seamlessRoute(const SearchScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                        child: Row(children: [
                          Icon(Icons.search_rounded, color: Colors.grey.shade500),
                          const SizedBox(width: 10),
                          Text('Search chef, waiter, decor…', style: TextStyle(color: Colors.grey.shade500, fontSize: 15)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: AppTheme.midnight, borderRadius: BorderRadius.circular(10)),
                            child: const Text('Hire', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 92,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, i) {
                          final c = categories[i];
                          final sel = c == selected;
                          return GestureDetector(
                            onTap: () => setState(() => selected = c),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: 72,
                              decoration: BoxDecoration(
                                color: sel ? AppTheme.midnight : Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: sel ? AppTheme.midnight : Colors.grey.shade200),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(_iconFor(c), color: sel ? Colors.white : AppTheme.midnight),
                                const SizedBox(height: 6),
                                Text(c, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sel ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text('Top rated this week', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: featured.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) {
                      final w = featured[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, seamlessRoute(WorkerDetailScreen(worker: w))),
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(colors: [Color(0xFF0B1B2B), Color(0xFF243B55)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Hero(
                                tag: 'avatar-${w.id}',
                                child: CircleAvatar(radius: 24, backgroundColor: AppTheme.gold, child: Text(w.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20))),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(w.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                                Text(w.category, style: const TextStyle(color: Color(0xFFC9A24B), fontSize: 13, fontWeight: FontWeight.w600)),
                              ])),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                                  child: Text('⭐ ${w.rating}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                            ]),
                            const Spacer(),
                            Text('₹${w.dayRate}/day • ${w.location}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                            const SizedBox(height: 8),
                            Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                child: const Center(child: Text('View & Hire →', style: TextStyle(fontWeight: FontWeight.w800)))),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Row(children: [
                    Text('Available ${selected == 'All' ? '' : '• $selected'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const Spacer(),
                    Text('${list.length} pros', style: TextStyle(color: Colors.grey.shade600)),
                  ]),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => WorkerCard(
                    worker: list[i],
                    onTap: () => Navigator.push(ctx, seamlessRoute(WorkerDetailScreen(worker: list[i]))),
                  ),
                  childCount: list.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
