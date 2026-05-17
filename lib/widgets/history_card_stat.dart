import 'package:flutter/material.dart';

class HistoryCardStat extends StatelessWidget {
  final int increments;
  final int decrements;
  final int resets;
  final int netChange;

  const HistoryCardStat({
    super.key,
    required this.increments,
    required this.decrements,
    required this.resets,
    required this.netChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white.withOpacity(0.02)
                : Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.add_circle_outline,
              number: increments,
              label: 'Increments',
              mainColor: const Color.fromRGBO(117, 93, 236, 1),
              lightColor: const Color.fromRGBO(236, 231, 255, 1),
            ),
          ),
          const _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.remove,
              number: decrements,
              label: 'Decrements',
              mainColor: const Color.fromRGBO(255, 105, 125, 1),
              lightColor: const Color.fromRGBO(255, 232, 236, 1),
            ),
          ),
          const _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.refresh_rounded,
              number: resets,
              label: 'Resets',
              mainColor: const Color.fromRGBO(83, 125, 255, 1),
              lightColor: const Color.fromRGBO(226, 233, 255, 1),
            ),
          ),
          const _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.show_chart_rounded,
              number: netChange,
              label: 'Net Change',
              mainColor: const Color.fromRGBO(67, 180, 105, 1),
              lightColor: const Color.fromRGBO(226, 246, 233, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int number;
  final String label;
  final Color mainColor;
  final Color lightColor;

  const _StatItem({
    required this.icon,
    required this.number,
    required this.label,
    required this.mainColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? lightColor.withOpacity(0.18) : lightColor,
          ),
          child: Icon(icon, color: mainColor, size: 22),
        ),
        const SizedBox(height: 10),
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color.fromRGBO(20, 24, 35, 1),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : mainColor,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 1,
      height: 100,
      color: isDark ? Colors.white12 : const Color.fromRGBO(230, 230, 240, 1),
    );
  }
}
