import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        onPressed: () {
                          final value = int.tryParse(controller.text);

                          if (value == null) return;

                          setState(() {
                            defaultValue = value;
                          });

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
                      onTap: () {
                        setState(() {
                          themeColor = color;
                        });
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
                        onChanged: (value) {
                          setState(() {
                            allowNegative = value;
                          });
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
                            onTap: () {
                              if (stepValue > 1) {
                                setState(() {
                                  stepValue--;
                                });
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
                            onTap: () {
                              setState(() {
                                stepValue++;
                              });
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
                        onChanged: (value) {
                          setState(() {
                            darkMode = value;
                          });
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
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Export feature coming soon'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
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

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(25, 31, 45, 1),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(242, 239, 255, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color.fromRGBO(117, 93, 236, 1),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(120, 130, 150, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ?trailing,
        ],
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 84, right: 18),
      color: const Color.fromRGBO(230, 230, 240, 1),
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

class CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 58,
        height: 32,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: value
              ? const Color.fromRGBO(117, 93, 236, 1)
              : const Color.fromRGBO(232, 230, 240, 1),
          border: value
              ? null
              : Border.all(
                  color: const Color.fromRGBO(210, 207, 222, 1),
                  width: 1.5,
                ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value
                  ? Colors.white
                  : const Color.fromRGBO(170, 165, 185, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
