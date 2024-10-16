import 'package:flutter/material.dart';
import 'package:gusto_coupon/views/home/coupon.dart';

class ResultTile extends StatelessWidget {
  final Coupon coupon;

  const ResultTile({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.5),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(coupon.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Text(coupon.code, textAlign: TextAlign.center),
            Text(coupon.newPrice, textAlign: TextAlign.center),
            Text(coupon.oldPrice, textAlign: TextAlign.center),
            Text(coupon.dueDate, textAlign: TextAlign.center),
          ],
        ));
  }
}
