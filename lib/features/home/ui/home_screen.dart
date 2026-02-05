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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(9, (index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: index == 8 ? 16 : 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(53),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: LocalImage(img: "car-logo", type: "svg", size: 36),
                      ),
                      CustomText(text: "Mercedes", color: Colors.white),
                    ],
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

  Widget _buildContentPart(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: index == 0
            ? const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                LocalImage(
                  img: "car4",
                  type: "png",
                  height: MediaQuery.of(context).size.height * 0.25,
                  alternativeBorderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: LocalImage(img: "car-logo", type: "svg", size: 24),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "Ferrari Convertible",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CustomIcon(icon: Iconsax.heart),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(4, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF3D923A).withAlpha(12),
                        ),
                        child: CustomText(text: "Car Tag Chip", fontSize: 12),
                      );
                    }),
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: "1700",
                    decoration: TextDecoration.lineThrough,
                    color: Theme.of(context).hintColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "AED 1000/Day",
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: "AED 1000/Mo",
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          textAlign: TextAlign.end,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomIcon(icon: Iconsax.bag),
                            SizedBox(height: 8),
                            CustomText(text: "2 Bags"),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        child: CustomButton(onTap: () {}, title: "Car Details", verticalPadding: 10),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        flex: 1,
                        child: CustomButton(
                          onTap: () {},
                          color: Color(0xFF777777),
                          borderRadius: BorderRadius.circular(16),
                          verticalPadding: 10,
                          child: LocalImage(img: "phone", type: "svg", size: 24),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        flex: 1,
                        child: CustomButton(
                          onTap: () {},
                          color: Color(0xFF25D366),
                          borderRadius: BorderRadius.circular(16),
                          verticalPadding: 10,
                          child: LocalImage(img: "whatsapp", type: "svg", size: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
              (context, index) => _buildContentPart(context, index),
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
