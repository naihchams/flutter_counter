import 'package:counter_ui_practice/model/history_item.dart';
import 'package:counter_ui_practice/widgets/history_card_stat.dart';
import 'package:counter_ui_practice/widgets/history_section.dart';
import 'package:counter_ui_practice/widgets/history_total_card.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCounterScreen extends StatefulWidget {
  final int currentCount;

  const HistoryCounterScreen({super.key, required this.currentCount});

  @override
  State<HistoryCounterScreen> createState() => _HistoryCounterScreenState();
}

class _HistoryCounterScreenState extends State<HistoryCounterScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> filters = ['All', 'Increment', 'Decrement', 'Reset'];

  List<HistoryItem> allHistoryItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final historyString = prefs.getString('counter_history');

    if (historyString == null) return;

    final decoded = jsonDecode(historyString);

    setState(() {
      allHistoryItems = decoded.map<HistoryItem>((item) {
        return HistoryItem(
          type: item['type'],
          value: item['value'],
          createdAt: DateTime.parse(item['createdAt']),
        );
      }).toList();
    });
  }

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
      body: visibleItems.isEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/emptyHistory.png',
                        width: width * 0.7,
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'No history yet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(30, 30, 40, 1),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Your counter activity will appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SafeArea(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
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
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
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
                            width: width * 0.25,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(239, 236, 253, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedFilter,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(110, 91, 217, 1),
                                ),
                                style: const TextStyle(
                                  color: Color.fromRGBO(110, 91, 217, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                items: filters.map((filter) {
                                  return DropdownMenuItem<String>(
                                    value: filter,
                                    child: Text(
                                      filter,
                                      overflow: TextOverflow.ellipsis,
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
                        HistorySection(
                          title: 'Yesterday',
                          items: yesterdayItems,
                        ),
                        const SizedBox(height: 28),
                      ],
                      if (lastWeekItems.isNotEmpty) ...[
                        HistorySection(
                          title: 'Last Week',
                          items: lastWeekItems,
                        ),
                        const SizedBox(height: 28),
                      ],
                      if (lastMonthItems.isNotEmpty) ...[
                        HistorySection(
                          title: 'Last Month',
                          items: lastMonthItems,
                        ),
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
                        currentCount: widget.currentCount,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
