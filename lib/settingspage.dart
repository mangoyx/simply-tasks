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
     body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'App Theme',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
   DropdownMenu<ThemeMode>(
  initialSelection: currentMode,
  width: MediaQuery.of(context).size.width - 32,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  menuStyle: MenuStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  onSelected: (ThemeMode? newMode) {
    if (newMode != null) {
      onModeChanged(newMode);
    }
  },
  dropdownMenuEntries: const [
    DropdownMenuEntry(value: ThemeMode.light, label: 'Light'),
    DropdownMenuEntry(value: ThemeMode.dark, label: 'Dark'),
    DropdownMenuEntry(value: ThemeMode.system, label: 'Dynamic'),
  ],
),
    ],              
  ),                     
),
  );
  }
}