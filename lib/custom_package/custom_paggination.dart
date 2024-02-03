// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

typedef ItemBuilderCallback<T> = Widget Function(T item, int index);
typedef LoaderBuilder = Widget Function();
typedef PlaceHolderBuilder = Widget Function();

class AutoPagination<T> extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int nextPageIndex, bool isCallAgain) onMaxScroll;

  final List<T> itemList;
  final int totalRecords;
  final double hight;
  final double width;
  final bool loader;
  final ScrollPhysics? scrollPhysics;
  final Axis scrollDirection;
  final LoaderBuilder loaderBuilder;
  final PlaceHolderBuilder placeHolderBuilder;
  final ItemBuilderCallback<T> itemBulder;

  const AutoPagination(
      {Key? key,
      required this.scrollController,
      required this.onMaxScroll,
      required this.itemList,
      required this.totalRecords,
      required this.hight,
      this.scrollPhysics,
      this.scrollDirection = Axis.vertical,
      required this.width,
      required this.loaderBuilder,
      required this.loader,
      required this.placeHolderBuilder,
      required this.itemBulder})
      : super(key: key);

  @override
  State<AutoPagination<T>> createState() => _AutoPaginationState<T>();
}

class _AutoPaginationState<T> extends State<AutoPagination<T>> {
  int pageIndex = 0;
  @override
  void initState() {
    onScroll();
    super.initState();
  }

  onScroll() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        pageIndex = pageIndex + 1;

        widget.onMaxScroll(pageIndex, !checkMaxCall());
      }
    });
  }

  bool checkMaxCall() {
    return widget.totalRecords == widget.itemList.length &&
        widget.totalRecords > 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hight,
      width: widget.width,
      child: widget.loader
          ? widget.loaderBuilder()
          : widget.itemList.isEmpty
              ? widget.placeHolderBuilder()
              : ListView.builder(
                  physics: widget.scrollPhysics,
                  scrollDirection: widget.scrollDirection,
                  controller: widget.scrollController,
                  itemCount: widget.itemList.length,
                  itemBuilder: (context, index) {
                    return widget.itemBulder(widget.itemList[index], index);
                  },
                ),
    );
  }
}
