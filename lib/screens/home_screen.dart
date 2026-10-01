import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../data/content.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../widgets/worker_card.dart';
import '../widgets/luxero.dart';
import 'worker_detail_screen.dart';
import 'search_screen.dart';
import 'contact_screen.dart';

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
      case 'Chef': return Icons.chef_hat_rounded;
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
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('DELHI NCR · LUCKNOW',
                              style: GoogleFonts.inter(
                                  fontSize: 11, fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4, color: AppTheme.gold)),
                          Text('Namaste, Brand',
                              style: GoogleFonts.bodoniModa(
                                  fontSize: 26, fontWeight: FontWeight.w600, color: AppTheme.ink)),
                        ]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: AppTheme.champagne)),
                        child: IconButton(
                            onPressed: () => Navigator.push(
                                context, seamlessRoute(const SearchScreen())),
                            icon: const Icon(Icons.search_rounded)),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    LuxeroHero(
                      onEnquire: () => Navigator.push(context, seamlessRoute(const ContactScreen())),
                      onHireTap: () => Navigator.push(context, seamlessRoute(const SearchScreen())),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => Navigator.push(context, seamlessRoute(const SearchScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.champagne)),
                        child: Row(children: [
                          Icon(Icons.search_rounded, color: Colors.grey.shade500),
                          const SizedBox(width: 10),
                          Text('Search chef, waiter, decor...', style: TextStyle(color: Colors.grey.shade500, fontSize: 15)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: AppTheme.gold, borderRadius: BorderRadius.circular(10)),
                            child: const Text('HIRE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.0)),
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
                                color: sel ? AppTheme.espresso : Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: sel ? AppTheme.espresso : AppTheme.champagne),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(_iconFor(c), color: sel ? Colors.white : AppTheme.espresso),
                                const SizedBox(height: 6),
                                Text(c, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sel ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text('TOP RATED THIS WEEK',
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w800,
                            letterSpacing: 1.2, color: AppTheme.gold)),
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
                            gradient: const LinearGradient(colors: [AppTheme.espresso, Color(0xFF4A3521)], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                                Text(w.category.toUpperCase(), style: const TextStyle(color: AppTheme.lightGold, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
                              ])),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                                  child: Text('${w.rating.toStringAsFixed(1)} / 5', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                            ]),
                            const Spacer(),
                            Text('Rs ${w.dayRate}/day · ${w.location}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                            const SizedBox(height: 8),
                            Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: AppTheme.gold, borderRadius: BorderRadius.circular(10)),
                                child: const Center(child: Text('VIEW AND HIRE', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1.0)))),
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
                    Text('AVAILABLE ${selected == 'All' ? '' : '· $selected}'.toUpperCase(),
                        style: GoogleFonts.inter(
                            fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
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
