import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';
import 'package:rh_host/src/core/system/network/connectivity.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({
    required this.child,
    this.offlineChild,
    super.key,
  });

  final Widget child;
  final Widget? offlineChild;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, connectivity, _) {
        if (!connectivity.hasConnection && offlineChild != null) {
          return Stack(
            children: [
              Opacity(opacity: 0.5, child: child),
              offlineChild!,
            ],
          );
        }
        return child;
      },
    );
  }
}
