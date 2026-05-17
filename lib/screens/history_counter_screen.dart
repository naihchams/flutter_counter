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
  final TextEditingController _searchController = TextEditingController();

  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> filters = ['All', 'Increment', 'Decrement', 'Reset'];

  final List<HistoryItem> allHistoryItems = [
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
      value: 20,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 19,
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    ),
    HistoryItem(
      type: 'reset',
      value: 0,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    HistoryItem(
      type: 'increment',
      value: 30,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    HistoryItem(
      type: 'decrement',
      value: 29,
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<HistoryItem> get filteredItems {
    return allHistoryItems.where((item) {
      final matchesFilter =
          selectedFilter == 'All' ||
          item.type.toLowerCase() == selectedFilter.toLowerCase();

      final matchesSearch =
          searchQuery.isEmpty ||
          item.type.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.value.toString().contains(searchQuery);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final horizontalPadding = width * 0.06;

    final now = DateTime.now();
    final visibleItems = filteredItems;

    final todayItems = visibleItems.where((item) {
      return isSameDay(item.createdAt, now);
    }).toList();

    final yesterdayItems = visibleItems.where((item) {
      final yesterday = now.subtract(const Duration(days: 1));
      return isSameDay(item.createdAt, yesterday);
    }).toList();

    final lastWeekItems = visibleItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference >= 2 && difference <= 7;
    }).toList();

    final lastMonthItems = visibleItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference > 7 && difference <= 30;
    }).toList();

    final olderItems = visibleItems.where((item) {
      final difference = now.difference(item.createdAt).inDays;
      return difference > 30;
    }).toList();

    final increments = visibleItems
        .where((item) => item.type == 'increment')
        .length;
    final decrements = visibleItems
        .where((item) => item.type == 'decrement')
        .length;
    final resets = visibleItems.where((item) => item.type == 'reset').length;
    final netChange = increments - decrements;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.07),
        child: AppBar(
          toolbarHeight: 50,
          backgroundColor: const Color.fromRGBO(117, 93, 236, 1),
          title: const Text(
            'History',
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height * 0.05,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search history',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    searchQuery = text;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Container(
                      height: height * 0.05,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(239, 236, 253, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(110, 91, 217, 1),
                          ),
                          items: filters.map((filter) {
                            return DropdownMenuItem(
                              value: filter,
                              child: Text(
                                filter,
                                style: const TextStyle(
                                  color: Color.fromRGBO(110, 91, 217, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              selectedFilter = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                HistoryCardStat(
                  increments: increments,
                  decrements: decrements,
                  resets: resets,
                  netChange: netChange,
                ),

                const SizedBox(height: 10),

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

                if (visibleItems.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'No history found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                HistoryTotalCard(
                  totalActions: visibleItems.length,
                  currentCount: visibleItems.isEmpty
                      ? 0
                      : visibleItems.first.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
