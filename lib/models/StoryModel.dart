class StoryModel {
  String createdOn;
  int id;
  int isImage;
  String storyUrl;
  String updatedOn;
  int userId;

  StoryModel(
      {required this.createdOn,
      required this.id,
      required this.isImage,
      required this.storyUrl,
      required this.updatedOn,
      required this.userId});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      createdOn: json['createdOn'],
      id: json['id'],
      isImage: json['isImage'],
      storyUrl: json['storyUrl'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['id'] = this.id;
    data['isImage'] = this.isImage;
    data['storyUrl'] = this.storyUrl;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    return data;
  }
}
