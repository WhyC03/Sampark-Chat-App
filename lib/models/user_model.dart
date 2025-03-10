class UserModel {
  String? id;
  String? name;
  String? email;
  String? profilePic;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profilePic,
    this.phoneNumber,
    this.about,
    this.createdAt,
    this.lastOnlineStatus,
    this.status,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePic = json['profilePic'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    about = json['about'];
    createdAt = json['createdAt'];
    lastOnlineStatus = json['lastOnlineStatus'];
    status = json['status'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['profilePic'] = profilePic;
    data['phoneNumber'] = phoneNumber;
    data['about'] = about;
    data['createdAt'] = createdAt;
    data['lastOnlineStatus'] = lastOnlineStatus;
    data['status'] = status;
    data['role'] = role;

    return data;
  }
}
