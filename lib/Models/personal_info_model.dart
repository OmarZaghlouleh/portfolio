import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';

class PersonalInfoModel {
  String bio = '';
  int likes = 0;
  String education = "";
  String location = "";
  String phoneNumber = "";
  String email = "";
  String imageUrl = '';

  PersonalInfoModel();

  PersonalInfoModel.fromJson(Map json) {
    bio = json['bio'] ?? "";
    likes = json["likes"] ?? 0;
    education = json['education'] ?? "";
    location = json['location'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    email = json['email'] ?? "";
    imageUrl = json['imageUrl'] ?? '';
  }
}
