// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class HomeModel {
  final String name;
  final AssetImage image;
  final Widget ?widget;
  const HomeModel({
    required this.name,
    required this.image,
    required this.widget,
  });

}
