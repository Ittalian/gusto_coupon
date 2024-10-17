import 'package:flutter/material.dart';
import 'package:gusto_coupon/views/home/coupon.dart';
import 'package:gusto_coupon/widgets/result/result_tile_row.dart';

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
            ResultTileRow(label: 'メニュー', value: coupon.name),
            ResultTileRow(label: 'クーポンコード', value: coupon.code),
            ResultTileRow(label: '割引価格', value: coupon.newPrice),
            ResultTileRow(label: '元の値段', value: coupon.oldPrice),
            ResultTileRow(label: '期限', value: coupon.dueDate),
          ],
        ));
  }
}
