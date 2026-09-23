import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/productos/presentation/screens/productos_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: SifposApp()));
}

class SifposApp extends StatelessWidget {
  const SifposApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIFPOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProductosListScreen(),
    );
  }
}
