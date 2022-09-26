import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ProjectsModel {
  String name = "";
  String description = "";
  String framework = "";
  int likes = 0;
  List features = [];
  List upComingFeatures = [];
  List images = [];
  List videos = [];
  List colors = [];
  GlobalKey key = GlobalKey();

  ProjectsModel();
  ProjectsModel.forNAme(this.name);
  ProjectsModel.fromJson(Map json) {
    if (kDebugMode) log(json.toString());
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    framework = json['framwork'] ?? "";
    likes = json['likes'] ?? 0;
    images = json['images'] ?? [];
    videos = json['videos'] ?? [];
    features = json['Features'] ?? [];
    upComingFeatures = json['upComingFeatures'] ?? [];
    colors = json['colors'] ?? [];
    key = GlobalKey(debugLabel: name);
  }
}
