import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate  {
  final Widget child;
  final double minHeight; //最小高度
  final double maxHeight; //最大高度

  HeaderDelegate({required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
