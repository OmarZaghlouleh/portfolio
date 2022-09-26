class ContactModel {
  String name = "";
  String url = "";
  String assetPath = "";

  ContactModel();
  ContactModel.fromJson(Map json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
    assetPath = "/icons/$name.svg";
  }
}
