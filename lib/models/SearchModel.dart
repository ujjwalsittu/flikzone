class UserSearch {
  List<User>? user;

  UserSearch({required this.user});

  factory UserSearch.fromJson(Map<String, dynamic> json) {
    return UserSearch(
      user: json['user'] != null
          ? (json['user'] as List).map((i) => User.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String createdOn;
  String deviceIdAndriod;
  String deviceIdIos;
  String fbId;
  int fbLogin;
  String fullName;
  int id;
  int noOfLongShort;
  int noOfLongVideo;
  int noOfPost;
  int otpVerified;
  int phoneAuth;
  String phoneNo;
  String profilepic;
  int status;
  String token;
  int totalFollowers;
  int totalLikes;
  String updatedOn;
  String username;
  int verificationStatus;

  User(
      {required this.createdOn,
      required this.deviceIdAndriod,
      required this.deviceIdIos,
      required this.fbId,
      required this.fbLogin,
      required this.fullName,
      required this.id,
      required this.noOfLongShort,
      required this.noOfLongVideo,
      required this.noOfPost,
      required this.otpVerified,
      required this.phoneAuth,
      required this.phoneNo,
      required this.profilepic,
      required this.status,
      required this.token,
      required this.totalFollowers,
      required this.totalLikes,
      required this.updatedOn,
      required this.username,
      required this.verificationStatus});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdOn: json['createdOn'],
      deviceIdAndriod: json['deviceIdAndriod'],
      deviceIdIos: json['deviceIdIos'],
      fbId: json['fbId'],
      fbLogin: json['fbLogin'],
      fullName: json['fullName'],
      id: json['id'],
      noOfLongShort: json['noOfLongShort'],
      noOfLongVideo: json['noOfLongVideo'],
      noOfPost: json['noOfPost'],
      otpVerified: json['otpVerified'],
      phoneAuth: json['phoneAuth'],
      phoneNo: json['phoneNo'],
      profilepic: json['profilepic'],
      status: json['status'],
      token: json['token'],
      totalFollowers: json['totalFollowers'],
      totalLikes: json['totalLikes'],
      updatedOn: json['updatedOn'],
      username: json['username'],
      verificationStatus: json['verificationStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['deviceIdAndriod'] = this.deviceIdAndriod;
    data['deviceIdIos'] = this.deviceIdIos;
    data['fbId'] = this.fbId;
    data['fbLogin'] = this.fbLogin;
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['noOfLongShort'] = this.noOfLongShort;
    data['noOfLongVideo'] = this.noOfLongVideo;
    data['noOfPost'] = this.noOfPost;
    data['otpVerified'] = this.otpVerified;
    data['phoneAuth'] = this.phoneAuth;
    data['phoneNo'] = this.phoneNo;
    data['profilepic'] = this.profilepic;
    data['status'] = this.status;
    data['token'] = this.token;
    data['totalFollowers'] = this.totalFollowers;
    data['totalLikes'] = this.totalLikes;
    data['updatedOn'] = this.updatedOn;
    data['username'] = this.username;
    data['verificationStatus'] = this.verificationStatus;
    return data;
  }
}

class PostSearch {
  List<Post>? post;

  PostSearch({this.post});

  factory PostSearch.fromJson(Map<String, dynamic> json) {
    return PostSearch(
      post: json['post'] != null
          ? (json['post'] as List).map((i) => Post.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String categoryType;
  String createdOn;
  int hasImage;
  int id;
  String location;
  int noOfComment;
  int noOfDislikes;
  int noOfFlicks;
  int noOfLikes;
  String postContent;
  String postImage;
  int status;
  String updatedON;
  int userId;

  Post(
      {required this.categoryType,
      required this.createdOn,
      required this.hasImage,
      required this.id,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlicks,
      required this.noOfLikes,
      required this.postContent,
      required this.postImage,
      required this.status,
      required this.updatedON,
      required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      categoryType: json['categoryType'],
      createdOn: json['createdOn'],
      hasImage: json['hasImage'],
      id: json['id'],
      location: json['location'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlicks: json['noOfFlicks'],
      noOfLikes: json['noOfLikes'],
      postContent: json['postContent'],
      postImage: json['postImage'],
      status: json['status'],
      updatedON: json['updatedON'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryType'] = this.categoryType;
    data['createdOn'] = this.createdOn;
    data['hasImage'] = this.hasImage;
    data['id'] = this.id;
    data['location'] = this.location;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlicks'] = this.noOfFlicks;
    data['noOfLikes'] = this.noOfLikes;
    data['postContent'] = this.postContent;
    data['postImage'] = this.postImage;
    data['status'] = this.status;
    data['updatedON'] = this.updatedON;
    data['userId'] = this.userId;
    return data;
  }
}

class VideoSearch {
  List<Video>? video;

  VideoSearch({required this.video});

  factory VideoSearch.fromJson(Map<String, dynamic> json) {
    return VideoSearch(
      video: json['video'] != null
          ? (json['video'] as List).map((i) => Video.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int canCommnet;
  String category;
  String createdOn;
  String descrition;
  String hasTags;
  int id;
  int isLong;
  String location;
  int musicId;
  String musicThumbNailUrl;
  int noOfComment;
  int noOfDislikes;
  int noOfFlick;
  int noOfLikes;
  int noOfView;
  int status;
  String thumbnailUrl;
  String title;
  String updatedOn;
  int userId;
  String videoUrl;

  Video(
      {required this.canCommnet,
      required this.category,
      required this.createdOn,
      required this.descrition,
      required this.hasTags,
      required this.id,
      required this.isLong,
      required this.location,
      required this.musicId,
      required this.musicThumbNailUrl,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlick,
      required this.noOfLikes,
      required this.noOfView,
      required this.status,
      required this.thumbnailUrl,
      required this.title,
      required this.updatedOn,
      required this.userId,
      required this.videoUrl});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      canCommnet: json['canCommnet'],
      category: json['category'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      hasTags: json['hasTags'],
      id: json['id'],
      isLong: json['isLong'],
      location: json['location'],
      musicId: json['musicId'],
      musicThumbNailUrl: json['musicThumbNailUrl'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlick: json['noOfFlick'],
      noOfLikes: json['noOfLikes'],
      noOfView: json['noOfView'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['hasTags'] = this.hasTags;
    data['id'] = this.id;
    data['isLong'] = this.isLong;
    data['location'] = this.location;
    data['musicId'] = this.musicId;
    data['musicThumbNailUrl'] = this.musicThumbNailUrl;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlick'] = this.noOfFlick;
    data['noOfLikes'] = this.noOfLikes;
    data['noOfView'] = this.noOfView;
    data['status'] = this.status;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['title'] = this.title;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}
