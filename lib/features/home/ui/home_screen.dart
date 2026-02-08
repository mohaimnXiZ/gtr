import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/icon.dart';
import 'package:gtr/core/widgets/icon_button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:gtr/features/home/component/product_card.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _stationaryKey = GlobalKey();
  final GlobalKey _movingKey = GlobalKey();
  final TextEditingController _search = TextEditingController();
  double _stationaryHeight = 0;
  double _movingHeight = 0;
  bool _isMeasured = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderBox? sBox = _stationaryKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? mBox = _movingKey.currentContext?.findRenderObject() as RenderBox?;

      if (sBox != null && mBox != null) {
        setState(() {
          _stationaryHeight = sBox.size.height;
          _movingHeight = mBox.size.height;
          _isMeasured = true;
        });
      }
    });
  }

  Widget _buildStationaryPart() {
    return Container(
      key: _stationaryKey,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(53),
                  child: CustomIcon(icon: Iconsax.location, color: Colors.white),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Location", color: Colors.white),
                      CustomText(text: "🇦🇪  AED", fontWeight: FontWeight.w800, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(53),
                  child: CustomIcon(icon: Iconsax.notification, color: Colors.white),
                ),
                SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    context.push('/profile');
                  },
                  child: LocalImage(img: "avatar", type: "png", size: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovingPart() {
    return Container(
      key: _movingKey,
      child: Column(
        children: [
          Padding(
            padding: screenPadding,
            child: CustomField(
              controller: _search,
              hintText: "Search",
              hintColor: Colors.white,
              textColor: Colors.white,
              borderColor: Colors.white,
              focusedBorderColor: Colors.white,
              cursorColor: Colors.white,
              borderRadius: 100,
              icon: "search",
              textInputAction: TextInputAction.search,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (index) {
                final bool isLastItem = index == 9;
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: isLastItem ? 16 : 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (isLastItem) {
                        context.push('/all-categories');
                      } else {}
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(53),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: isLastItem
                              ? const Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              : LocalImage(img: "car-logo", type: "svg", size: 36),
                        ),
                        const SizedBox(height: 8),
                        CustomText(text: isLastItem ? "View All" : "Mercedes", color: Colors.white),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    if (!_isMeasured) {
      return Scaffold(
        backgroundColor: themeColor,
        body: Offstage(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [_buildStationaryPart(), _buildMovingPart()],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: themeColor,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SlidingAppBarDelegate(
              stationaryHeight: _stationaryHeight,
              movingHeight: _movingHeight,
              stationaryChild: _buildStationaryPart(),
              movingChild: _buildMovingPart(),
              statusBarHeight: MediaQuery.of(context).padding.top,
              backgroundColor: themeColor,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductCard(
                carName: "Ferrari Convertible",
                carImage: "car4",
                carLogo: "car-logo",
                dailyPrice: "18000",
                monthlyPrice: "13204",
                tags: ["sport", "good", "fast"],
                onDetailsTap: () {},
                onPhoneTap: () {},
                onWhatsappTap: () {},
              ),
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// --- DELEGATE ---

class SlidingAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double stationaryHeight;
  final double movingHeight;
  final Widget stationaryChild;
  final Widget movingChild;
  final double statusBarHeight;
  final Color backgroundColor;

  SlidingAppBarDelegate({
    required this.stationaryHeight,
    required this.movingHeight,
    required this.stationaryChild,
    required this.movingChild,
    required this.statusBarHeight,
    required this.backgroundColor,
  });

  @override
  double get minExtent => stationaryHeight + statusBarHeight;

  @override
  double get maxExtent => stationaryHeight + movingHeight + statusBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double movingPartY = stationaryHeight + statusBarHeight - shrinkOffset;

    return ClipRect(
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(top: movingPartY, left: 0, right: 0, child: movingChild),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                color: backgroundColor,
                child: stationaryChild,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SlidingAppBarDelegate oldDelegate) {
    return oldDelegate.stationaryHeight != stationaryHeight || oldDelegate.movingHeight != movingHeight;
  }
}
