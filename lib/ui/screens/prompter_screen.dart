import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/script_provider.dart';

class PrompterScreen extends ConsumerWidget {
  const PrompterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = ref.watch(scriptProvider);

    if (script == null) {
      return const Scaffold(
        body: Center(child: Text('No script provided.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Script name goes here'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            script.text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
