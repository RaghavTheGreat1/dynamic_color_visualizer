import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = MediaQuery.of(context).size.width;

        if (width > 1200) {

          return desktop == null ? const SizedBox() : desktop!.call(context);
        } else if (width > 800 && width < 1200) {
     
          return tablet == null ? const SizedBox() : tablet!.call(context);
        } else {
          return mobile == null ? const SizedBox() : mobile!.call(context);
        }
      },
    );
  }
}
