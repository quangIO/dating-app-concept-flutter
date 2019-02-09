import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef void OnDismissedCallback(int dismissedItem, DismissDirection direction);

class CustomPageView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;

  final OnDismissedCallback dismissedCallback;

  final double viewportFraction;

  final int height;

  final int width;
  final bool dismissibleItems;

  final int itemCount;
  final Function(int) onPageChanged;

  const CustomPageView({
    @required this.itemBuilder,
    this.dismissibleItems: false,
    this.dismissedCallback,
    this.viewportFraction: .85,
    this.height: 525,
    this.width: 700,
    @required this.itemCount, this.onPageChanged,
  }) : assert(itemBuilder != null);

  @override
  _CoverFlowState createState() => _CoverFlowState();
}

class _CoverFlowState extends State<CustomPageView> {
  PageController controller;
  int currentPage = 0;
  bool _pageHasChanged = false;

  @override
  initState() {
    super.initState();
    controller = PageController(viewportFraction: widget.viewportFraction);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _pageHasChanged = true;
            currentPage = value;
          });
          widget.onPageChanged(value);
        },
        controller: controller,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) => builder(index));
  }

  Widget builder(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, Widget child) {
        double result = _pageHasChanged ? controller.page : 0.0;
        double value = result - index;

        value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);

        final actualWidget = Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: Curves.easeOut.transform(value) * widget.height ,
            width: Curves.easeOut.transform(value) * widget.width,
            child: child,
          ),
        );
        if (!widget.dismissibleItems) return actualWidget;

        return Dismissible(
          key: ObjectKey(child),
          direction: DismissDirection.vertical,
          child: actualWidget,
          onDismissed: (direction) {
            setState(
              () {
                widget.dismissedCallback(index, direction);
                controller.animateToPage(currentPage,
                    duration: Duration(seconds: 2), curve: Curves.easeOut);
              },
            );
          },
        );
      },
      child: widget.itemBuilder(context, index),
    );
  }
}
