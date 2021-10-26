class VideoCategoryModel {
  String createdOn;
  int id;
  String name;
  String updatedOn;

  VideoCategoryModel(
      {required this.createdOn,
      required this.id,
      required this.name,
      required this.updatedOn});

  factory VideoCategoryModel.fromJson(Map<String, dynamic> json) {
    return VideoCategoryModel(
      createdOn: json['createdOn'],
      id: json['id'],
      name: json['name'],
      updatedOn: json['updatedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['id'] = this.id;
    data['name'] = this.name;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
