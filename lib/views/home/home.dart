import 'package:flutter/material.dart';
import 'package:gusto_coupon/config/router/routes.dart';
import 'package:gusto_coupon/utils/loading/loading_dialog.dart';
import 'package:gusto_coupon/views/home/coupon.dart';
import 'package:gusto_coupon/widgets/base/base_button.dart';
import 'package:gusto_coupon/widgets/base/base_image_container.dart';
import 'package:gusto_coupon/widgets/base/base_textform_field.dart';
import '../../utils/constants/render_url.dart' as urls;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String keyWord = '';

  void setKeyWord(String value) {
    setState(() {
      keyWord = value;
    });
  }

  void moveResult(BuildContext context, List<Coupon> coupons) {
    Navigator.pushNamed(context, Routes.result, arguments: {
      'coupons': coupons,
    });
  }

  bool filterByKeyWord(String name) {
    if (name.toLowerCase().contains(keyWord.toLowerCase())) {
      return true;
    }
    return false;
  }

  List<String> formatCoupons(List<String> results) {
    results.removeRange(results.length - 3, results.length);

    return results;
  }

  showErrorMessage(String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
    ));
  }

  Future<List<Coupon>> search(String url) async {
    List<Coupon> coupons = [];
    final target = Uri.parse(url);
    final response = await http.get(target);
    final document = parse(response.body);
    List<String> scrapResults = document
        .querySelectorAll('tr td')
        .map((doc) => doc.text.trim())
        .toList();
    final formattedResult = formatCoupons(scrapResults);
    for (int i = 0; i < formattedResult.length; i += 5) {
      if (filterByKeyWord(formattedResult[i])) {
        Coupon coupon = Coupon(
            name: formattedResult[i],
            code: formattedResult[i + 1],
            newPrice: formattedResult[i + 2],
            oldPrice: formattedResult[i + 3],
            dueDate: formattedResult[i + 4]);
        coupons.add(coupon);
      }
    }
    if (coupons.isEmpty) {
      await LoadingDialog.hide(context);
      throw showErrorMessage('検索結果が0件です');
    } else {
      return coupons;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
        imagePath: 'images/home.jpg',
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTextformField(
                  label: 'キーワード', setValue: (value) => setKeyWord(value)),
              BaseButton(
                  label: '検索',
                  onPressed: () async {
                    await LoadingDialog.show(context, ('検索中'));
                    List<Coupon> coupons = await search(urls.renderUrl);
                    await LoadingDialog.hide(context);
                    moveResult(context, coupons);
                  })
            ],
          ),
        ));
  }
}
