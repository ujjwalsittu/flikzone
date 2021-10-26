class LongVideoByID {
  int canCommnet;
  String category;
  String category_name;
  String createdOn;
  String descrition;
  String fullName;
  String hasTags;
  int id;
  int isLike;
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
  String userPic;
  String username;
  String videoUrl;

  LongVideoByID(
      {required this.canCommnet,
      required this.category,
      required this.category_name,
      required this.createdOn,
      required this.descrition,
      required this.fullName,
      required this.hasTags,
      required this.id,
      required this.isLike,
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
      required this.userPic,
      required this.username,
      required this.videoUrl});

  factory LongVideoByID.fromJson(Map<String, dynamic> json) {
    return LongVideoByID(
      canCommnet: json['canCommnet'],
      category: json['category'],
      category_name: json['category_name'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      fullName: json['fullName'],
      hasTags: json['hasTags'],
      id: json['id'],
      isLike: json['isLike'],
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
      userPic: json['userPic'],
      username: json['username'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['category_name'] = this.category_name;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['fullName'] = this.fullName;
    data['hasTags'] = this.hasTags;
    data['id'] = this.id;
    data['isLike'] = this.isLike;
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
    data['userPic'] = this.userPic;
    data['username'] = this.username;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

class LongVideo {
  int canCommnet;
  String category;
  String category_name;
  String createdOn;
  String descrition;
  String fullName;
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
  String userPic;
  String username;
  String videoUrl;

  LongVideo(
      {required this.canCommnet,
      required this.category,
      required this.category_name,
      required this.createdOn,
      required this.descrition,
      required this.fullName,
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
      required this.userPic,
      required this.username,
      required this.videoUrl});

  factory LongVideo.fromJson(Map<String, dynamic> json) {
    return LongVideo(
      canCommnet: json['canCommnet'],
      category: json['category'],
      category_name: json['category_name'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      fullName: json['fullName'],
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
      userPic: json['userPic'],
      username: json['username'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['category_name'] = this.category_name;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['fullName'] = this.fullName;
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
    data['userPic'] = this.userPic;
    data['username'] = this.username;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

class LongVideoByCatModel {
  int canCommnet;
  String category;
  String createdOn;
  String descrition;
  String fullName;
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
  String profilepic;
  int status;
  String thumbnailUrl;
  String title;
  String updatedOn;
  int userId;
  String username;
  String videoUrl;

  LongVideoByCatModel(
      {required this.canCommnet,
      required this.category,
      required this.createdOn,
      required this.descrition,
      required this.fullName,
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
      required this.profilepic,
      required this.status,
      required this.thumbnailUrl,
      required this.title,
      required this.updatedOn,
      required this.userId,
      required this.username,
      required this.videoUrl});

  factory LongVideoByCatModel.fromJson(Map<String, dynamic> json) {
    return LongVideoByCatModel(
      canCommnet: json['canCommnet'],
      category: json['category'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      fullName: json['fullName'],
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
      profilepic: json['profilepic'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
      username: json['username'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['fullName'] = this.fullName;
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
    data['profilepic'] = this.profilepic;
    data['status'] = this.status;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['title'] = this.title;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

class LongVideoByUID {
  int canCommnet;
  String category;
  String createdOn;
  String descrition;
  String fullName;
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
  String profilepic;
  int status;
  String thumbnailUrl;
  String title;
  String updatedOn;
  int userId;
  String username;
  String videoUrl;

  LongVideoByUID(
      {required this.canCommnet,
      required this.category,
      required this.createdOn,
      required this.descrition,
      required this.fullName,
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
      required this.profilepic,
      required this.status,
      required this.thumbnailUrl,
      required this.title,
      required this.updatedOn,
      required this.userId,
      required this.username,
      required this.videoUrl});

  factory LongVideoByUID.fromJson(Map<String, dynamic> json) {
    return LongVideoByUID(
      canCommnet: json['canCommnet'],
      category: json['category'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      fullName: json['fullName'],
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
      profilepic: json['profilepic'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
      username: json['username'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['fullName'] = this.fullName;
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
    data['profilepic'] = this.profilepic;
    data['status'] = this.status;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['title'] = this.title;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}
