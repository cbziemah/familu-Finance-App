import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/money.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'theme.dart';
import 'widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rates = ref.watch(ratesProvider).value ?? const {'GHS': 1.0};
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    final held = {for (final a in accounts) a.account.currency}..remove('GHS');
    final currencies = {...held, ...rates.keys.where((c) => c != 'GHS')}.toList()..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          const SectionTitle('Exchange rates'),
          const SizedBox(height: 4),
          const Text('Foreign balances are converted to GHS with these rates. Use the Bank of Ghana reference rate for the day.', style: TextStyle(color: AppColors.muted, fontSize: 13)),
          const SizedBox(height: 12),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(children: [
              for (final c in currencies)
                ListTile(
                  title: Text(c, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(rates[c] == null ? 'No rate yet' : '1 $c = GHS ${rates[c]!.toStringAsFixed(4)}'),
                  trailing: const Icon(Icons.edit_rounded, size: 20),
                  onTap: () => _editRate(context, ref, c, rates[c]),
                ),
              ListTile(
                leading: const Icon(Icons.add_rounded),
                title: const Text('Add a currency'),
                onTap: () async {
                  final c = await showDialog<String>(
                    context: context,
                    builder: (d) => SimpleDialog(title: const Text('Currency'), children: [
                      for (final c in supportedCurrencies.where((c) => c != 'GHS'))
                        SimpleDialogOption(onPressed: () => Navigator.pop(d, c), child: Text(c)),
                    ]),
                  );
                  if (c != null && context.mounted) _editRate(context, ref, c, rates[c]);
                },
              ),
            ]),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Your data'),
          const SizedBox(height: 8),
          const SectionCard(
            child: Text(
              'Everything is stored on this phone only. Encrypted Google Drive backup, PIN lock and partner sharing are the next steps on the roadmap.',
              style: TextStyle(color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editRate(BuildContext context, WidgetRef ref, String currency, double? current) async {
    final controller = TextEditingController(text: current?.toString() ?? '');
    final value = await showDialog<double>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('1 $currency in GHS'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(prefixText: 'GHS ', fillColor: AppColors.ground),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(d, double.tryParse(controller.text.replaceAll(',', ''))), child: const Text('Save')),
        ],
      ),
    );
    if (value != null && value > 0) await ref.read(repositoryProvider).setRate(currency, value);
  }
}
