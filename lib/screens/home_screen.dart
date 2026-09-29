import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../main.dart';
import '../widgets/worker_card.dart';
import 'worker_detail_screen.dart';
import 'search_screen.dart';

/// District-style Home: hero banner + image categories + image cards
class HomeScreen extends StatefulWidget {
  final VoidCallback onSearchTap;
  const HomeScreen({super.key, required this.onSearchTap});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = 'All';

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
              // Location + Luxero header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('📍 Delhi NCR ▾', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            Text('LUXERO', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(onPressed: widget.onSearchTap, icon: const Icon(Icons.notifications_rounded)),
                      ),
                    ],
                  ),
                ),
              ),
              // Search
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, seamlessRoute(const SearchScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
                      ),
                      child: Row(children: [
                        Icon(Icons.search_rounded, color: Colors.grey.shade500),
                        const SizedBox(width: 10),
                        Text('Search "wedding chef"…', style: TextStyle(color: Colors.grey.shade500, fontSize: 15)),
                      ]),
                    ),
                  ),
                ),
              ),
              // Hero banner (Luxero gold-standard)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1000&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
                          colors: [Colors.black.withOpacity(0.75), Colors.transparent]),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Gold-standard hospitality', style: TextStyle(color: Color(0xFFC9A24B), fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1)),
                        SizedBox(height: 4),
                        Text('Staff that makes\nthem stay.', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, height: 1.15)),
                      ],
                    ),
                  ),
                ),
              ),
              // Categories with images (District style)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
                      child: Text('What do you need?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      height: 108,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) {
                          final c = categories[i];
                          final sel = c == selected;
                          final img = categoryImages[c];
                          return GestureDetector(
                            onTap: () => setState(() => selected = c),
                            child: Column(
                              children: [
                                Container(
                                  width: 68, height: 68,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: sel ? const Color(0xFF0B1B2B) : Colors.grey.shade200, width: sel ? 2.5 : 1),
                                    image: img == null
                                        ? null
                                        : DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                                    color: img == null ? const Color(0xFF0B1B2B) : null,
                                  ),
                                  child: img == null
                                      ? const Icon(Icons.grid_view_rounded, color: Colors.white)
                                      : sel
                                          ? Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.black.withOpacity(0.25)))
                                          : null,
                                ),
                                const SizedBox(height: 6),
                                Text(c, style: TextStyle(fontSize: 12, fontWeight: sel ? FontWeight.w800 : FontWeight.w600)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Featured horizontal image cards
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 14, 20, 10),
                      child: Text('Top rated this week ⭐', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: featured.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (_, i) {
                          final w = featured[i];
                          return GestureDetector(
                            onTap: () => Navigator.push(context, seamlessRoute(WorkerDetailScreen(worker: w))),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: 'img-${w.id}',
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                      child: Image.network(w.imageUrl, height: 150, width: 180, fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => Container(height: 150, color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(w.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14), overflow: TextOverflow.ellipsis),
                                        Text('${w.category} • ⭐ ${w.rating}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                        Text('₹${w.dayRate}/day', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Row(children: [
                    Text(selected == 'All' ? 'All professionals' : selected, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const Spacer(),
                    Text('${list.length} found', style: TextStyle(color: Colors.grey.shade600)),
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
