import 'package:flutter/material.dart';
import 'package:gtr/features/favorite/ui/favorite_screen.dart';
import 'package:gtr/features/home/ui/home_screen.dart';
import 'package:gtr/features/profile/ui/profile_screen.dart';
import 'package:gtr/features/search/ui/search_screen.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/app_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [HomeScreen(), FavoriteScreen(), SearchScreen(), ProfileScreen()];
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final double kRailBreakpoint = 900;

  List<BottomNavigationBarItem> _bottomNavItems() => const [
    BottomNavigationBarItem(icon: Icon(Iconsax.home), activeIcon: Icon(Iconsax.home_15), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Iconsax.heart), activeIcon: Icon(Iconsax.heart5), label: "Fav"),
    BottomNavigationBarItem(icon: Icon(Iconsax.search_normal), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Iconsax.frame_1), activeIcon: Icon(Iconsax.frame5), label: "Profile"),
  ];

  List<NavigationRailDestination> _railDestinations() => const [
    NavigationRailDestination(icon: Icon(Iconsax.home), selectedIcon: Icon(Iconsax.home_15), label: Text("Home")),
    NavigationRailDestination(icon: Icon(Iconsax.heart), selectedIcon: Icon(Iconsax.heart5), label: Text("Fav")),
    NavigationRailDestination(icon: Icon(Iconsax.search_normal), label: Text("Search")),
    NavigationRailDestination(icon: Icon(Iconsax.frame_1), selectedIcon: Icon(Iconsax.frame5), label: Text("Profile")),
  ];

  void _navigate(int index) {
    setState(() {
      _pageIndex = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 150), curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showRail = constraints.maxWidth >= kRailBreakpoint;

        return Scaffold(
          body: Row(
            children: [
              if (showRail) _buildNavigationRail(context),

              Expanded(
                child: Stack(
                  children: [
                    PageView(controller: _pageController, onPageChanged: _navigate, children: _screens),

                    if (!showRail) _buildBottomNav(context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 24,
      right: 24,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20, offset: const Offset(0, -1))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Theme.of(context).colorScheme.primary.withAlpha(64),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    enableFeedback: false,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                    selectedLabelStyle: const TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.normal),
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _pageIndex,
                  onTap: _navigate,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  items: _bottomNavItems(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Colors.transparent,
          labelType: NavigationRailLabelType.all,
          selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 26),
          unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface, size: 24),
          selectedLabelTextStyle: const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),
          unselectedLabelTextStyle: const TextStyle(fontFamily: fontFamily),
        ),
      ),
      child: NavigationRail(selectedIndex: _pageIndex, onDestinationSelected: _navigate, destinations: _railDestinations()),
    );
  }
}
