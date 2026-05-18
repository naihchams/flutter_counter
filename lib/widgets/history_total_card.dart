import 'package:flutter/material.dart';

class HistoryTotalCard extends StatelessWidget {
  final int totalActions;
  final int currentCount;
  final Color primaryColor;

  const HistoryTotalCard({
    super.key,
    required this.totalActions,
    required this.currentCount,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.bar_chart_rounded, color: primaryColor, size: 30),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: _TotalItem(
              label: 'Total Actions',
              value: totalActions,
              textColor: primaryColor,
            ),
          ),

          _CenterDivider(primaryColor: primaryColor),

          Expanded(
            child: _TotalItem(
              label: 'Current Count',
              value: currentCount,
              textColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalItem extends StatelessWidget {
  final String label;
  final int value;
  final Color textColor;

  const _TotalItem({
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CenterDivider extends StatelessWidget {
  final Color primaryColor;

  const _CenterDivider({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            primaryColor.withValues(alpha: 0.6),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
