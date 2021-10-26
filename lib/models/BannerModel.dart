class BannerModel {
  String imgUrl;

  BannerModel({required this.imgUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
