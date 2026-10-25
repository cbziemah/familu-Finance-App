import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/shell.dart';
import 'ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
  runApp(const ProviderScope(child: HomeFinanceApp()));
}

class HomeFinanceApp extends StatelessWidget {
  const HomeFinanceApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Home Finance',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const AppShell(),
      );
}
