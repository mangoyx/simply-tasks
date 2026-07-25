import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final ThemeMode currentMode;
  final Function(ThemeMode) onModeChanged;

  const SettingsPage({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (value) => onModeChanged(value!),
            ),
          ),
          ListTile(
            title: const Text('Dark'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: currentMode,
              onChanged: (value) => onModeChanged(value!),
            ),
          ),
          ListTile(
            title: const Text('Auto (6am-6pm)'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (value) => onModeChanged(value!),
            ),
          ),
        ],
      ),
    );
  }
}