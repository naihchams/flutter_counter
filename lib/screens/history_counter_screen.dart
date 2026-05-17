import 'package:counter_ui_practice/widgets/history_card_stat.dart';
import 'package:counter_ui_practice/widgets/history_section.dart';
import 'package:counter_ui_practice/widgets/history_total_card.dart';

import 'package:flutter/material.dart';

class HistoryCounterScreen extends StatefulWidget {
  const HistoryCounterScreen({super.key});

  @override
  State<HistoryCounterScreen> createState() => _HistoryCounterScreenState();
}

class _HistoryCounterScreenState extends State<HistoryCounterScreen> {
  final List<HistoryItem> allHistoryItems = [
    // TODAY
    HistoryItem(type: 'increment', value: 16, createdAt: DateTime.now()),
    HistoryItem(
      type: 'decrement',
      value: 15,
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    HistoryItem(
      type: 'increment',
      value: 16,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    HistoryItem(
      type: 'increment',
      value: 5,
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    HistoryItem(
      type: 'increment',
      value: 6,
      createdAt: DateTime.now().subtract(const Duration(minutes: 18)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 5,
      createdAt: DateTime.now().subtract(const Duration(minutes: 22)),
    ),

    // YESTERDAY
    HistoryItem(
      type: 'decrement',
      value: 4,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    HistoryItem(
      type: 'increment',
      value: 5,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
    ),
    HistoryItem(
      type: 'increment',
      value: 10,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
    HistoryItem(
      type: 'increment',
      value: 11,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 7)),
    ),

    // LAST WEEK
    HistoryItem(
      type: 'increment',
      value: 20,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 19,
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    ),
    HistoryItem(
      type: 'increment',
      value: 25,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 5)),
    ),
    HistoryItem(
      type: 'increment',
      value: 7,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 6,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    HistoryItem(
      type: 'increment',
      value: 8,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),

    // LAST MONTH
    HistoryItem(
      type: 'increment',
      value: 30,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 29,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 16)),
    ),
    HistoryItem(
      type: 'increment',
      value: 13,
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    ),
    HistoryItem(
      type: 'increment',
      value: 14,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 13,
      createdAt: DateTime.now().subtract(const Duration(days: 22)),
    ),
    HistoryItem(
      type: 'increment',
      value: 40,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 28)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final horizontalPadding = width * 0.06;

    final TextEditingController _searchController = TextEditingController();

    final now = DateTime.now();

    bool isSameDay(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    final todayItems = allHistoryItems.where((item) {
      return isSameDay(item.createdAt, now);
    }).toList();

    final yesterdayItems = allHistoryItems.where((item) {
      final yesterday = now.subtract(const Duration(days: 1));
      return isSameDay(item.createdAt, yesterday);
    }).toList();

    final lastWeekItems = allHistoryItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference >= 2 && difference <= 7;
    }).toList();

    final lastMonthItems = allHistoryItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference > 7 && difference <= 30;
    }).toList();

    final olderItems = allHistoryItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference > 30;
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.07),
        child: AppBar(
          toolbarHeight: 50,
          backgroundColor: Color.fromRGBO(117, 93, 236, 1),
          title: Text('History', style: TextStyle(fontWeight: FontWeight.w500)),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(248, 246, 253, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.65,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 12),
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search history',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (text) {
                                print('Current text: $text');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color.fromRGBO(239, 236, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                color: Color.fromRGBO(110, 91, 217, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(110, 91, 217, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                HistoryCardStat(
                  increments: 23,
                  decrements: 12,
                  resets: 5,
                  netChange: 16,
                ),
                SizedBox(height: 10),
                if (todayItems.isNotEmpty) ...[
                  HistorySection(title: 'Today', items: todayItems),
                  const SizedBox(height: 28),
                ],

                if (yesterdayItems.isNotEmpty) ...[
                  HistorySection(title: 'Yesterday', items: yesterdayItems),
                  const SizedBox(height: 28),
                ],

                if (lastWeekItems.isNotEmpty) ...[
                  HistorySection(title: 'Last Week', items: lastWeekItems),
                  const SizedBox(height: 28),
                ],

                if (lastMonthItems.isNotEmpty) ...[
                  HistorySection(title: 'Last Month', items: lastMonthItems),
                  const SizedBox(height: 28),
                ],

                if (olderItems.isNotEmpty) ...[
                  HistorySection(title: 'Older', items: olderItems),
                  const SizedBox(height: 28),
                ],

                const SizedBox(height: 24),
                HistoryTotalCard(totalActions: 40, currentCount: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
