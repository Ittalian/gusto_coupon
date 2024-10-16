import 'package:flutter/material.dart';
import 'package:gusto_coupon/views/home/coupon.dart';
import 'package:gusto_coupon/views/result/result.dart';

class Routes {
  static const String result = 'result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case result:
        final resultOptions = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) =>
                Result(coupons: resultOptions['coupons'] as List<Coupon>));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('${settings.name}は存在しません',
                        style: const TextStyle(fontSize: 20)),
                  ),
                ));
    }
  }
}
