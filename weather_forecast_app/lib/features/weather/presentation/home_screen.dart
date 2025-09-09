import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_model/home_view_model.dart';
import '../domain/entities/location.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: state.when(
        data: (weather) => Center(child: Text('${weather.temperature}°')),
        loading: () {
          ref
              .read(homeViewModelProvider.notifier)
              .fetch(const Location(lat: 0, lon: 0));
          return const Center(child: CircularProgressIndicator());
        },
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
