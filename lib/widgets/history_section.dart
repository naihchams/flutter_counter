import 'package:counter_ui_practice/model/history_item.dart';
import 'package:flutter/material.dart';

String _formatTime(DateTime date) {
  final hour = date.hour > 12 ? date.hour - 12 : date.hour;
  final minute = date.minute.toString().padLeft(2, '0');
  final period = date.hour >= 12 ? 'PM' : 'AM';

  return '$hour:$minute $period';
}

class HistorySection extends StatelessWidget {
  final String title;
  final List<HistoryItem> items;

  const HistorySection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color.fromRGBO(25, 31, 45, 1),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF111111) : theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                HistoryTile(item: items[i]),
                if (i != items.length - 1) const _SoftDivider(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryTile extends StatelessWidget {
  final HistoryItem item;

  const HistoryTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark
        ? Colors.white
        : const Color.fromRGBO(20, 24, 35, 1);
    final subtitleColor = isDark
        ? Colors.white70
        : const Color.fromRGBO(120, 130, 150, 1);
    final chevronColor = isDark
        ? Colors.white54
        : const Color.fromRGBO(145, 150, 165, 1);
    final style = _getStyle(item.type);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: style.color.withValues(alpha: 0.92),
            ),
            child: Icon(style.icon, color: Colors.white, size: 24),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  _formatTime(item.createdAt),
                  style: TextStyle(fontSize: 12, color: subtitleColor),
                ),
              ],
            ),
          ),

          Text(
            item.value.toString(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: style.color,
            ),
          ),

          const SizedBox(width: 10),

          Icon(Icons.chevron_right, color: chevronColor, size: 22),
        ],
      ),
    );
  }
}

class _HistoryItemStyle {
  final IconData icon;
  final String title;
  final Color color;

  const _HistoryItemStyle({
    required this.icon,
    required this.title,
    required this.color,
  });
}

_HistoryItemStyle _getStyle(String type) {
  switch (type) {
    case 'increment':
      return const _HistoryItemStyle(
        icon: Icons.add,
        title: 'Increment',
        color: Color.fromRGBO(117, 93, 236, 1),
      );

    case 'decrement':
      return const _HistoryItemStyle(
        icon: Icons.remove,
        title: 'Decrement',
        color: Color.fromRGBO(255, 105, 125, 1),
      );

    case 'reset':
      return const _HistoryItemStyle(
        icon: Icons.refresh_rounded,
        title: 'Reset',
        color: Color.fromRGBO(83, 125, 255, 1),
      );

    default:
      return const _HistoryItemStyle(
        icon: Icons.circle,
        title: 'Unknown',
        color: Colors.grey,
      );
  }
}

class _SoftDivider extends StatelessWidget {
  const _SoftDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 70, right: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            isDark
                ? const Color(0xFF2E2E2E)
                : const Color.fromRGBO(225, 226, 238, 1),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
