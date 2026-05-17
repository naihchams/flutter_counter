import 'package:flutter/material.dart';

class HistoryTotalCard extends StatelessWidget {
  final int totalActions;
  final int currentCount;

  const HistoryTotalCard({
    super.key,
    required this.totalActions,
    required this.currentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 239, 255, 1),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              color: const Color.fromRGBO(230, 223, 249, 1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.bar_chart_rounded,
              color: Color.fromRGBO(117, 93, 236, 1),
              size: 30,
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: _TotalItem(label: 'Total Actions', value: totalActions),
          ),

          const _CenterDivider(),

          Expanded(
            child: _TotalItem(label: 'Current Count', value: currentCount),
          ),
        ],
      ),
    );
  }
}

class _TotalItem extends StatelessWidget {
  final String label;
  final int value;

  const _TotalItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color.fromRGBO(117, 93, 236, 1),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Color.fromRGBO(117, 93, 236, 1),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CenterDivider extends StatelessWidget {
  const _CenterDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 55,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color.fromRGBO(170, 155, 230, 1),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
