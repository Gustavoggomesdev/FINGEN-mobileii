import 'package:flutter/material.dart';
import '../design_system/components/navigation/custom_tab_bar.dart';
import '../scenes/home/home_factory.dart';
import '../scenes/investments/investments_factory.dart';
import '../scenes/settings/settings_factory.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _pages.addAll([
          HomeFactory.create(context),
          InvestmentsFactory.create(context),
          SettingsFactory.create(context),
        ]);
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomTabBar(
        tabs: [
          TabItem(label: 'Início', icon: Icons.home),
          TabItem(label: 'Investimentos', icon: Icons.trending_up),
          TabItem(label: 'Configurações', icon: Icons.settings),
        ],
        onTabChanged: _onTabChanged,
      ),
    );
  }
}