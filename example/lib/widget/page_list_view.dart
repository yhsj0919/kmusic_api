import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageListView extends StatefulWidget {
  PageListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.onLoadMore,
    required this.totalCount,
    required this.pageSize,
    this.padding,
    this.itemExtent,
  })  : assert(pageSize > 0),
        super(key: key);

  final RefreshCallback? onRefresh;
  final LoadMoreCallback? onLoadMore;
  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final int totalCount;
  final int pageSize;

  final EdgeInsetsGeometry? padding;
  final double? itemExtent;

  @override
  _PageListViewState createState() => _PageListViewState();
}

typedef RefreshCallback = Future<void> Function(int index);
typedef LoadMoreCallback = Future Function(int index);

class _PageListViewState extends State<PageListView> {
  /// 是否正在加载数据
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Widget child = RefreshIndicator(
      onRefresh: () => widget.onRefresh?.call(0) ?? Future.value(),
      child: isEmpty()
          ? emptyWidget()
          : ListView.builder(
              itemCount: widget.onLoadMore == null ? widget.itemCount : widget.itemCount + 1,
              padding: widget.padding,
              itemExtent: widget.itemExtent,
              itemBuilder: (BuildContext context, int index) {
                /// 不需要加载更多则不需要添加FootView
                if (widget.onLoadMore == null) {
                  return widget.itemBuilder(context, index);
                } else {
                  return index < widget.itemCount ? widget.itemBuilder(context, index) : MoreWidget(widget.itemCount, widget.pageSize, widget.totalCount);
                }
              },
            ),
    );
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        /// 确保是垂直方向滚动，且滑动至底部
        if (note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical) {
          _loadMore();
        }
        return true;
      },
      child: child,
    );
  }

  bool isEmpty() {
    return widget.itemCount == 0;
  }

  Widget emptyWidget() {
    return Center(
      child: Text("暂无数据"),
    );
  }

  Future<void> _loadMore() async {
    if (widget.onLoadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (widget.itemCount == widget.totalCount) {
      return;
    }
    _isLoading = true;
    await widget.onLoadMore!((widget.itemCount ~/ widget.pageSize) + 1);
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.pageSize, this.totalCount);

  final int itemCount;
  final int pageSize;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    print("当前$itemCount >>>> $totalCount");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (itemCount < totalCount) const CupertinoActivityIndicator(),

          /// 只有一页的时候，就不显示FooterView了
          Text(totalCount > itemCount ? '正在加载中...' : '没有了呦~'),
        ],
      ),
    );
  }
}
