import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ResponsiveGrid extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final ScrollPhysics? physics;

  final VoidCallback? onLimitReached;
  final ScrollController? controller;

  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.childAspectRatio = 1,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 12,
    this.padding = const EdgeInsets.all(16),
    this.physics,
    this.onLimitReached,
    this.controller,
  });

  @override
  State<ResponsiveGrid> createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= (maxScroll * 0.5)) {
      widget.onLimitReached?.call();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  int _getCrossAxisCount(double width) {
    if (width < 350) return 1;
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        return MasonryGridView.builder(
          controller: _scrollController,
          padding: widget.padding,
          itemCount: widget.itemCount,
          physics: widget.physics,
          shrinkWrap: widget.physics is NeverScrollableScrollPhysics ? true : false,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          itemBuilder: widget.itemBuilder,
        );
      },
    );
  }
}
