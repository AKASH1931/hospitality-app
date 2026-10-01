import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../widgets/luxero.dart';
import 'contact_screen.dart';

/// Services — mirrors web /services: PageHero + 6 espresso cards + Six Heads + Engagement Models.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SERVICES')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionHeader(
            kicker: 'What we do',
            title: 'Six heads, one partner',
            subtitle: 'Operations, F&B management, artists, catering, vendors and training — pick one head or combine any four.',
          ),
          const SizedBox(height: 16),
          ...heads.map((h) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.espresso,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('${h.index}',
                          style: GoogleFonts.bodoniModa(
                              fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.lightGold)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(h.title.toUpperCase(),
                        style: GoogleFonts.bodoniModa(
                            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(h.text,
                        style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: Colors.white70)),
                  ])),
                ]),
              )),
          const SizedBox(height: 8),
          const SectionHeader(
            kicker: 'How we engage',
            title: 'Engagement models',
          ),
          const SizedBox(height: 10),
          _model('Individual', 'Rs 20,000 per head per month. Start with one function.'),
          _model('Combo', 'Rs 50,000 for any 4 heads. Save Rs 30,000 every month.'),
          _model('Events', 'Per-event artists, catering and staff. Reserve from the Events tab.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.push(context, seamlessRoute(const ContactScreen())),
            child: const Text('Enquire About Services'),
          ),
          const SizedBox(height: 12),
          const ContactStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _model(String title, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.champagne),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.toUpperCase(),
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
        const SizedBox(height: 4),
        Text(text, style: GoogleFonts.inter(fontSize: 14, height: 1.5)),
      ]),
    );
  }
}
