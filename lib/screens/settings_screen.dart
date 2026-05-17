import 'package:counter_ui_practice/widgets/custom_toggle.dart';
import 'package:counter_ui_practice/widgets/setting_section.dart';
import 'package:counter_ui_practice/widgets/setting_tile.dart';
import 'package:counter_ui_practice/widgets/settings_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool allowNegative = true;
  bool darkMode = false;
  int stepValue = 1;
  int defaultValue = 0;
  Color themeColor = const Color.fromRGBO(117, 93, 236, 1);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allowNegative = prefs.getBool('allowNegative') ?? true;
      darkMode = prefs.getBool('darkMode') ?? false;
      stepValue = prefs.getInt('stepValue') ?? 1;
      defaultValue = prefs.getInt('defaultValue') ?? 0;
      final colorValue = prefs.getInt('themeColor');
      if (colorValue != null) {
        themeColor = Color(colorValue);
      }
    });
  }

  Future<void> _exportHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString('counter_history');

    if (historyString == null || historyString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No history to export'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/counter_history.txt');

    await file.writeAsString(historyString);

    await Share.shareXFiles([XFile(file.path)], text: 'Counter history export');
  }

  Future<void> _saveAllowNegative(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('allowNegative', value);
  }

  Future<void> _saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  Future<void> _saveStepValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepValue', value);
  }

  Future<void> _saveDefaultValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultValue', value);
  }

  Future<void> _saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
  }

  void _showDefaultValueDialog() {
    final controller = TextEditingController(text: defaultValue.toString());

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(242, 239, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: Color.fromRGBO(117, 93, 236, 1),
                    size: 30,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Default Value',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Set the starting value for your counter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                ),

                const SizedBox(height: 22),

                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorColor: const Color.fromRGBO(117, 93, 236, 1),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 40, 50, 1),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(248, 246, 253, 1),
                    hintText: '0',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(170, 170, 185, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 93, 236, 1),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                  ),
                ),
                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            117,
                            93,
                            236,
                            1,
                          ),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          final value = int.tryParse(controller.text);

                          if (value == null) return;

                          setState(() {
                            defaultValue = value;
                          });

                          await _saveDefaultValue(value);
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemeColorDialog() {
    final colors = [
      const Color.fromRGBO(117, 93, 236, 1),
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.red,
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Theme Color',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 22),

                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: colors.map((color) {
                    final isSelected = color == themeColor;

                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          themeColor = color;
                        });
                        await _saveThemeColor(color);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('counter_history');
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 232, 236, 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color.fromRGBO(255, 80, 95, 1),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Clear History?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  'This will permanently remove all counter history.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color.fromRGBO(117, 93, 236, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 80, 95, 1),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          await _clearHistory();
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('History cleared'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text('Clear'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final horizontalPadding = width * 0.06;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.07),
        child: AppBar(
          toolbarHeight: 50,
          backgroundColor: const Color.fromRGBO(117, 93, 236, 1),
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(248, 246, 253, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsSection(
                  title: 'Counter Behavior',
                  children: [
                    SettingsTile(
                      icon: Icons.exposure_minus_1,
                      title: 'Allow Negative Numbers',
                      subtitle: 'Allow counter to go below zero',
                      trailing: CustomToggle(
                        value: allowNegative,
                        onChanged: (value) async {
                          setState(() {
                            allowNegative = value;
                          });
                          await _saveAllowNegative(value);
                        },
                      ),
                    ),
                    const SettingsDivider(),
                    SettingsTile(
                      icon: Icons.stairs_rounded,
                      title: 'Step Value',
                      subtitle: 'Amount to change on each tap',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _SmallButton(
                            icon: Icons.remove,
                            onTap: () async {
                              if (stepValue > 1) {
                                setState(() {
                                  stepValue--;
                                });
                                await _saveStepValue(stepValue);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Step value cannot be smaller than 1',
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                          ),

                          const SizedBox(width: 14),

                          SizedBox(
                            width: 24,
                            child: Text(
                              stepValue.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          _SmallButton(
                            icon: Icons.add,
                            onTap: () async {
                              setState(() {
                                stepValue++;
                              });
                              await _saveStepValue(stepValue);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SettingsDivider(),
                    GestureDetector(
                      onTap: _showDefaultValueDialog,
                      child: SettingsTile(
                        icon: Icons.refresh_rounded,
                        title: 'Default Value',
                        subtitle: 'Set initial value for the counter',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              defaultValue.toString(),
                              style: const TextStyle(
                                color: Color.fromRGBO(117, 93, 236, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                SettingsSection(
                  title: 'Appearance',
                  children: [
                    GestureDetector(
                      onTap: _showThemeColorDialog,
                      child: SettingsTile(
                        icon: Icons.palette_outlined,
                        title: 'Theme Color',
                        subtitle: 'Choose your preferred color theme',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: themeColor,
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SettingsDivider(),
                    SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Use dark theme',
                      trailing: CustomToggle(
                        value: darkMode,
                        onChanged: (value) async {
                          setState(() {
                            darkMode = value;
                          });
                          await _saveDarkMode(value);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                SettingsSection(
                  title: 'Data & History',
                  children: [
                    GestureDetector(
                      onTap: _showClearHistoryDialog,
                      child: SettingsTile(
                        icon: Icons.history,
                        title: 'Clear History',
                        subtitle: 'Remove all counter history',
                        trailing: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color.fromRGBO(255, 232, 236, 1),
                              child: Icon(
                                Icons.delete_outline,
                                color: Color.fromRGBO(255, 80, 95, 1),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SettingsDivider(),
                    GestureDetector(
                      onTap: _exportHistory,
                      child: SettingsTile(
                        icon: Icons.download_rounded,
                        title: 'Export History',
                        subtitle: 'Save your history as a file',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                SettingsSection(
                  title: 'About',
                  children: const [
                    SettingsTile(
                      icon: Icons.info_outline,
                      title: 'About Counter App',
                      subtitle: 'Version 1.0.0',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SmallButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(242, 239, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color.fromRGBO(117, 93, 236, 1)),
      ),
    );
  }
}
