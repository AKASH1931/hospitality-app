import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/role_select_screen.dart';

void main() {
  runApp(const HospitalityApp());
}

class HospitalityApp extends StatelessWidget {
  const HospitalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Hospitality Hire',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const RoleSelectScreen(),
      ),
    );
  }
}

// Seamless navigation helper: fade + slide
Route<T> seamlessRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) {
      final tween = Tween(begin: const Offset(0, 0.04), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: anim,
        child: SlideTransition(position: anim.drive(tween), child: child),
      );
    },
  );
}
