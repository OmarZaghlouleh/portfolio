import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:portfolio/API%20Services/contacts_api.dart';
import 'package:portfolio/API%20Services/projects_api.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/values_manager.dart';
import 'package:portfolio/Models/contact_model.dart';
import 'package:portfolio/Models/project_model.dart';

import '../API Services/personal_info_api.dart';
import '../Models/personal_info_model.dart';

class HomeViewModel with ChangeNotifier {
  PersonalInfoModel _personalInfoModel = PersonalInfoModel();
  List<ContactModel> _contactModel = [];

  List<ProjectsModel> _projectsModel = [];
  List<String> _projectsName = [];

  XFile? picked;

  double _aboutFontSize = FontsSize.s15;
  double _resumeFontSize = FontsSize.s15;
  double _musicFontSize = FontsSize.s15;
  double _likeSize = AppSize.s20;

  double _projectsFontSize = FontsSize.s15;
  double _contactFontSize = FontsSize.s15;

  bool _isProfileVisible = true;
  bool _isProjectsVisible = true;
  bool _isContactVisible = true;
  bool _isMusicVisible = true;
  bool _isLoading = false;

  bool _isLiked = false;

  bool _textFinished = false;
  bool _isProfileContainerHovered = false;
  bool _isDropDownOpened = false;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsLiked(bool value) {
    _isLiked = value;
    notifyListeners();
  }

  void setDropDownStatus() {
    _isDropDownOpened = !_isDropDownOpened;
    notifyListeners();
  }

  void setProfileContainerHover() {
    _isProfileContainerHovered = !_isProfileContainerHovered;
    notifyListeners();
  }

  void setIsProfileVisible(bool value) {
    _isProfileVisible = value;
    notifyListeners();
  }

  void setIsPrjectsVisible(bool value) {
    _isProjectsVisible = value;
    notifyListeners();
  }

  void setIsContactVisible(bool value) {
    _isContactVisible = value;
    notifyListeners();
  }

  void setIsMusicVisible(bool value) {
    _isMusicVisible = value;
    notifyListeners();
  }

  void setTextfinished(bool value) {
    _textFinished = value;

    notifyListeners();
  }

  void setAboutFontSize() {
    _aboutFontSize =
        _aboutFontSize == FontsSize.s15 ? FontsSize.s20 : FontsSize.s15;
    notifyListeners();
  }

  void setAboutCustomFontSize(double fontsSize) {
    _aboutFontSize = fontsSize;
    notifyListeners();
  }

  void setLikeSize() {
    _likeSize = _likeSize == AppSize.s20 ? AppSize.s25 : AppSize.s20;
    notifyListeners();
  }

  void setContactFontSize() {
    _contactFontSize =
        _contactFontSize == FontsSize.s15 ? FontsSize.s20 : FontsSize.s15;
    notifyListeners();
  }

  void setCustomContactFontSize(double fontSize) {
    _contactFontSize = fontSize;
    notifyListeners();
  }

  void setCustomMusicFontSize(double fontSize) {
    _musicFontSize = fontSize;
    notifyListeners();
  }

  void setResumeFontSize() {
    _resumeFontSize =
        _resumeFontSize == FontsSize.s15 ? FontsSize.s20 : FontsSize.s15;
    notifyListeners();
  }

  void setMusicFontSize() {
    _musicFontSize =
        _musicFontSize == FontsSize.s15 ? FontsSize.s20 : FontsSize.s15;
    notifyListeners();
  }

  void setProjectsFontSize() {
    _projectsFontSize =
        _projectsFontSize == FontsSize.s15 ? FontsSize.s20 : FontsSize.s15;
    notifyListeners();
  }

  void setProjectsCustomFontSize(double fontsize) {
    _projectsFontSize = fontsize;
    notifyListeners();
  }

  Future<void> setPersonalInfo() async {
    _personalInfoModel = await PersonalInfoAPI().getPersonalInfo();
    notifyListeners();
  }

  Future<void> setContacts() async {
    _contactModel = await ContactsAPI().getContacts();
    notifyListeners();
  }

  Future<void> setProjects() async {
    _projectsModel = await ProjectsAPI().getProjects();

    for (var element in _projectsModel) {
      _projectsName.add(element.name);
    }
    notifyListeners();
  }

  Future<void> upload() async {
    try {
      ImagePicker _picker = ImagePicker();
      final picked = await _picker.pickVideo(source: ImageSource.gallery);
      if (picked != null) {
        ParseFileBase? parseFile;

        if (kIsWeb) {
          //Flutter Web
          parseFile = ParseWebFile(await picked.readAsBytes(),
              name: 'video.mp4'); //Name for file is required
        } else {
          //Flutter Mobile/Desktop
          parseFile = ParseFile(File(picked.path));
        }
        await parseFile.save();
        print(parseFile.url.toString());
      }
    } catch (e) {}
  }

  Future<void> setLike() async {
    setIsLiked(true);
    //setLoading(true);
    String macAddress;

    macAddress = await getMac();

    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Info'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      final data = apiResponse.results!.first['macs'] as List;
      if (!data.contains(macAddress)) {
        var todo = ParseObject('Info')
          ..objectId = AppStrings.infoId
          ..setAdd('macs', macAddress);
        final res = await todo.save();

        if (res.success) {
          todo = ParseObject('Info')
            ..objectId = AppStrings.infoId
            ..setIncrement('likes', 1);
          await todo.save();
          final res = await todo.save();
          if (!res.success) setIsLiked(false);
        }
      }
    }

    //setLoading(false);
  }

  Future<void> decLike() async {
    setIsLiked(false);
    //setLoading(true);
    String macAddress;

    macAddress = await getMac();

    macAddress = macAddress;
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Info'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      final data = apiResponse.results!.first['macs'] as List;
      if (data.contains(macAddress)) {
        var todo = ParseObject('Info')
          ..objectId = AppStrings.infoId
          ..setRemove('macs', macAddress);
        final res = await todo.save();

        if (res.success) {
          todo = ParseObject('Info')
            ..objectId = AppStrings.infoId
            ..setIncrement('likes', -1);
          final res = await todo.save();
          if (!res.success) setIsLiked(true);
        }
      }
    }
    //setLoading(false);
  }

  Future<void> checkLike() async {
    String macAddress;

    macAddress = await getMac();
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Info'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      final data = apiResponse.results!.first['macs'] as List;
      if (data.contains(macAddress)) {
        setIsLiked(true);
      }
    }
  }

  Future<String> getMac() async {
    String macAddress;
    try {
      macAddress =
          await PlatformDeviceId.getDeviceId ?? AppStrings.undefinedError;
    } on PlatformException {
      macAddress = 'Failed to get mac address.';
    }
    return macAddress;
  }

  PersonalInfoModel get getPersonalInfo => _personalInfoModel;
  List<ContactModel> get getContacts => _contactModel;
  List<ProjectsModel> get getProjects => _projectsModel;
  List<ProjectsModel> get getProjectsAdded => _projectsModel;
  List<String> get getProjectsName => _projectsName;

  double get getAboutFontSize => _aboutFontSize;
  double get getResumeFontSize => _resumeFontSize;
  double get getMusicFontSize => _musicFontSize;
  double get getProjectsFontSize => _projectsFontSize;
  double get getContactFontSize => _contactFontSize;
  double get getLikeSize => _likeSize;

  bool get getIsProfileVisible => _isProfileVisible;
  bool get getIsPrjectsVisible => _isProfileVisible;
  bool get getIsContactVisible => _isContactVisible;
  bool get getIsMusicVisible => _isContactVisible;
  bool get getTextFinished => _textFinished;
  bool get getIsProfileContainerHovered => _isProfileContainerHovered;
  bool get getDropDownStatus => _isDropDownOpened;
  bool get getIsLiked => _isLiked;
  bool get getLoading => _isLoading;
}
