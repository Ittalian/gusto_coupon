import 'package:flutter/material.dart';
import 'package:gusto_coupon/views/home/coupon.dart';
import 'package:gusto_coupon/widgets/base/base_image_container.dart';
import 'package:gusto_coupon/widgets/result/result_tile.dart';

class Result extends StatelessWidget {
  final List<Coupon> coupons;

  const Result({super.key, required this.coupons});

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
        imagePath: 'images/result.jpg',
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0),
            body: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    child: Column(children: [
                  for (var coupon in coupons) ResultTile(coupon: coupon)
                ])))));
  }
}
