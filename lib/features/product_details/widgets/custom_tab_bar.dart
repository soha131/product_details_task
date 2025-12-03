import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  const CustomTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      color: Colors.white,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(22),
        ),
        child: TabBar(
          controller: controller,
          labelColor: const Color(0xFFFE7E00),
          unselectedLabelColor: Colors.grey.shade600,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          indicator: const BoxDecoration(),
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: "Product"),
            Tab(text: "Review"),
            Tab(text: "Help"),
          ],
        ),
      ),
    );
  }
}