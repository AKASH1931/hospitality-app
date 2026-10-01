import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/luxero.dart';

/// Pricing — mirrors web /pricing + quoteFor() calculator.
class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});
  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  final Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    final quote = quoteFor(selected.toList());
    return Scaffold(
      appBar: AppBar(title: const Text('PRICING')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionHeader(
            kicker: 'Simple pricing',
            title: 'Individual vs Combo',
            subtitle: 'Rs 20,000 per head per month. Any 4 heads for Rs 50,000 — save Rs 30,000.',
          ),
          const SizedBox(height: 14),
          _card('INDIVIDUAL', 'Rs 20,000', 'per head / month', false),
          _card('COMBO — ANY 4', 'Rs 50,000', 'save Rs 30,000', true),
          const SizedBox(height: 16),
          Text('QUOTE CALCULATOR',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
          const SizedBox(height: 4),
          Text('Tap heads to estimate. Combo auto-applies at 4+ heads.',
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: heads.map((h) {
              final sel = selected.contains(h.id);
              return FilterChip(
                label: Text(h.title),
                selected: sel,
                onSelected: (_) => setState(() {
                  sel ? selected.remove(h.id) : selected.add(h.id);
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.espresso, borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(quote.plan.toUpperCase(),
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        letterSpacing: 1.2, color: AppTheme.lightGold)),
                Text('${selected.length} head(s) selected',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
                if (quote.savings > 0)
                  Text('You save Rs ${quote.savings}',
                      style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.lightGold)),
              ])),
              Text('Rs ${quote.total}',
                  style: GoogleFonts.bodoniModa(
                      fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white)),
            ]),
          ),
          const SizedBox(height: 16),
          const ContactStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _card(String title, String price, String sub, bool highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: highlight ? AppTheme.espresso : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: highlight ? AppTheme.espresso : AppTheme.champagne),
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2,
                  color: highlight ? AppTheme.lightGold : AppTheme.gold)),
          Text(price,
              style: GoogleFonts.bodoniModa(
                  fontSize: 28, fontWeight: FontWeight.w600,
                  color: highlight ? Colors.white : AppTheme.ink)),
          Text(sub,
              style: GoogleFonts.inter(
                  fontSize: 13, color: highlight ? Colors.white70 : Colors.grey.shade600)),
        ])),
      ]),
    );
  }
}
