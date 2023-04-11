import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdPage extends ConsumerWidget {
  static const pageUrl = '/third';

  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Center(
        child: Text('Work in progress', style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
