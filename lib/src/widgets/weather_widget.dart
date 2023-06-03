import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({
    required this.iconName,
    this.featureName,
    required this.value,
  });

  String? iconName;
  String? featureName;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 100,
      padding: EdgeInsets.only(left: 20, top: 10),
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/${iconName}.png',
            height: 30,
            width: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(featureName!),
          ),
          Text(value!),
        ],
      ),
    );
  }
}
