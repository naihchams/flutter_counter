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
  final VoidCallback? onThemeChanged;

  const SettingsScreen({super.key, this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool allowNegative = true;
  bool darkMode = false;
  int stepValue = 1;
  int defaultValue = 0;
  bool hasChanges = false;

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
    final theme = Theme.of(context);
    final controller = TextEditingController(text: defaultValue.toString());

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.08),
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
                    color: themeColor.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.refresh_rounded,
                    color: themeColor,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Default Value',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Set the starting value for your counter.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.75),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 22),

                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorColor: themeColor,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.cardColor,
                    hintText: '0',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.6,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: themeColor, width: 2),
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
                            hasChanges = true;
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
    final theme = Theme.of(context);
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
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Theme Color',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
                          hasChanges = true;
                        });
                        await _saveThemeColor(color);
                        widget.onThemeChanged?.call();
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
                                ? theme.colorScheme.onSurface
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
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.08),
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
                    color: themeColor.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: themeColor,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Clear History?',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'This will permanently remove all counter history.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.75),
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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final horizontalPadding = width * 0.06;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.07),
        child: AppBar(
          toolbarHeight: 50,
          backgroundColor: themeColor,
          title: Text(
            'Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, hasChanges),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
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
                      iconColor: themeColor,
                      iconBackgroundColor: themeColor.withOpacity(0.16),
                      title: 'Allow Negative Numbers',
                      subtitle: 'Allow counter to go below zero',
                      trailing: CustomToggle(
                        value: allowNegative,
                        activeColor: themeColor,
                        onChanged: (value) async {
                          setState(() {
                            allowNegative = value;
                            hasChanges = true;
                          });
                          await _saveAllowNegative(value);
                        },
                      ),
                    ),
                    const SettingsDivider(),
                    SettingsTile(
                      icon: Icons.stairs_rounded,
                      iconColor: themeColor,
                      iconBackgroundColor: themeColor.withOpacity(0.16),
                      title: 'Step Value',
                      subtitle: 'Amount to change on each tap',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _SmallButton(
                            icon: Icons.remove,
                            color: themeColor,
                            onTap: () async {
                              if (stepValue > 1) {
                                setState(() {
                                  stepValue--;
                                  hasChanges = true;
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
                            color: themeColor,
                            onTap: () async {
                              setState(() {
                                stepValue++;
                                hasChanges = true;
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
                        iconColor: themeColor,
                        iconBackgroundColor: themeColor.withOpacity(0.16),
                        title: 'Default Value',
                        subtitle: 'Set initial value for the counter',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              defaultValue.toString(),
                              style: TextStyle(
                                color: themeColor,
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
                        iconColor: themeColor,
                        iconBackgroundColor: themeColor.withOpacity(0.16),
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
                      iconColor: themeColor,
                      iconBackgroundColor: themeColor.withOpacity(0.16),
                      title: 'Dark Mode',
                      subtitle: 'Use dark theme',
                      trailing: CustomToggle(
                        value: darkMode,
                        activeColor: themeColor,
                        onChanged: (value) async {
                          setState(() {
                            darkMode = value;
                            hasChanges = true;
                          });
                          await _saveDarkMode(value);
                          widget.onThemeChanged?.call();
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
                        iconColor: themeColor,
                        iconBackgroundColor: themeColor.withOpacity(0.16),
                        title: 'Clear History',
                        subtitle: 'Remove all counter history',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: themeColor.withOpacity(0.16),
                              child: Icon(
                                Icons.delete_outline,
                                color: themeColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.chevron_right,
                              color: themeColor.withOpacity(0.75),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SettingsDivider(),
                    GestureDetector(
                      onTap: _exportHistory,
                      child: SettingsTile(
                        icon: Icons.download_rounded,
                        iconColor: themeColor,
                        iconBackgroundColor: themeColor.withOpacity(0.16),
                        title: 'Export History',
                        subtitle: 'Save your history as a file',
                        trailing: Icon(
                          Icons.chevron_right,
                          color: themeColor.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                SettingsSection(
                  title: 'About',
                  children: [
                    SettingsTile(
                      icon: Icons.info_outline,
                      iconColor: themeColor,
                      iconBackgroundColor: themeColor.withOpacity(0.16),
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

  const _SmallButton({
    required this.icon,
    required this.onTap,
    this.color = const Color.fromRGBO(117, 93, 236, 1),
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.16),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
