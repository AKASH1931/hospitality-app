import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/worker_card.dart';
import '../main.dart';
import 'worker_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final String initialQuery;
  const SearchScreen({super.key, this.initialQuery = ''});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController ctrl;
  String cat = 'All';

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: widget.initialQuery);
  }

  @override
  Widget build(BuildContext context) {
    final q = ctrl.text.toLowerCase();
    final list = dummyWorkers.where((w) {
      final matchQ = q.isEmpty ||
          w.name.toLowerCase().contains(q) ||
          w.category.toLowerCase().contains(q) ||
          w.skills.any((s) => s.toLowerCase().contains(q));
      final matchC = cat == 'All' || w.category == cat;
      return matchQ && matchC;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search pros')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: TextField(
            controller: ctrl,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Name, skill, category…',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            children: categories.map((c) {
              final sel = c == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(label: Text(c), selected: sel, onSelected: (_) => setState(() => cat = c)),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(child: Text('Kuch nahi mila — spelling badal ke dekho'))
              : ListView.builder(
                  itemCount: list.length,
                  padding: const EdgeInsets.only(top: 6, bottom: 20),
                  itemBuilder: (_, i) => WorkerCard(
                    worker: list[i],
                    onTap: () => Navigator.push(context, seamlessRoute(WorkerDetailScreen(worker: list[i]))),
                  ),
                ),
        ),
      ]),
    );
  }
}
