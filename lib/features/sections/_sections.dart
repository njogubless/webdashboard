import 'package:flutter/material.dart';
import 'package:webdashboard/features/sections/analytics/analytics.dart';
import 'package:webdashboard/features/sections/inventory/inventory.dart';
import 'package:webdashboard/features/sections/sales/sales.dart';
import 'package:webdashboard/utils/_index.dart';

class SectionsPage extends StatefulWidget {
  const SectionsPage({super.key});

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  late ScreenSection _currentSection;

  @override
  void initState() {
    _currentSection = ScreenSection.sales;
    super.initState();
  }

  Widget _showSection(ScreenSection section) {
    switch (section) {
      case ScreenSection.analytics:
        return AnalyticsScreen(
          scrollController: ScrollController(),
        );
      case ScreenSection.inventory:
        return const InventoryScreen();
      case ScreenSection.profile:
        // Update page
        return const SalesScreen();
      case ScreenSection.sales:
        return const SalesScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Malibu Restaurant'),
                    ),
                    const SizedBox(height: 50),
                    SectionSelectionBtn(
                      title: 'Sales',
                      selected: _currentSection == ScreenSection.sales,
                      onPressed: () =>
                          setState(() => _currentSection = ScreenSection.sales),
                    ),
                    SectionSelectionBtn(
                      title: 'Inventory',
                      selected: _currentSection == ScreenSection.inventory,
                      onPressed: () => setState(
                        () => _currentSection = ScreenSection.inventory,
                      ),
                    ),
                    SectionSelectionBtn(
                      title: 'Analytics',
                      selected: _currentSection == ScreenSection.analytics,
                      onPressed: () => setState(
                        () => _currentSection = ScreenSection.analytics,
                      ),
                    ),
                    SectionSelectionBtn(
                      title: 'Profile',
                      selected: _currentSection == ScreenSection.profile,
                      onPressed: () => setState(
                        () => _currentSection = ScreenSection.profile,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: _showSection(_currentSection),
          ),
        ],
      ),
    );
  }
}

class SectionSelectionBtn extends StatelessWidget {
  const SectionSelectionBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.selected,
  });

  final String title;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, right: 10),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        color: selected
            ? Theme.of(context).primaryColorLight
            : Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Text(title),
          ],
        ),
      ),
    );
  }
}
