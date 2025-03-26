import 'package:flutter/material.dart';

import '../../utility/assets_path.dart';

class CommonAuthAppBar extends StatelessWidget {
  final String? appBarTitle;
  const CommonAuthAppBar({
    super.key,
    this.appBarTitle = " ",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 30,
          ),
        ),
        Text("$appBarTitle",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        Image.asset(
          AssetsPath.appLogo,
          scale: .5,
          height: 60,
        ),
      ],
    );
  }
}
