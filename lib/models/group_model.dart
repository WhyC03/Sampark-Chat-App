import 'package:sampark_app/models/user_model.dart';

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createdAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  int? unReadCount;
  String? timeStamp;

  GroupModel({
    this.id,
    this.name,
    this.description,
    this.profileUrl,
    this.members,
    this.createdAt,
    this.createdBy,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageBy,
    this.unReadCount,
    this.timeStamp,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    profileUrl = json["profileUrl"];
    members = json['members'] != null
        ? List<UserModel>.from(
            (json['members'] as List).map((m) => UserModel.fromJson(m)))
        : null;
    // if (json['members'] != null) {
    //   members =
    //       json["members"].map(memberJson) ?? UserModel.fromJson(memberJson);
    // } else {
    //   members = [];
    // }
    createdAt = json["createdAt"];
    createdBy = json["createdBy"];
    status = json["status"];
    lastMessage = json["lastMessage"];
    lastMessageTime = json["lastMessageTime"];
    lastMessageBy = json["lastMessageBy"];
    unReadCount = json["unReadCount"];
    timeStamp = json["timeStamp"];
  }

  static List<GroupModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(GroupModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["profileUrl"] = profileUrl;
    if (members != null) {
      data["members"] = members;
    }
    data["createdAt"] = createdAt;
    data["createdBy"] = createdBy;
    data["status"] = status;
    data["lastMessage"] = lastMessage;
    data["lastMessageTime"] = lastMessageTime;
    data["lastMessageBy"] = lastMessageBy;
    data["unReadCount"] = unReadCount;
    data["timeStamp"] = timeStamp;
    return data;
  }
}
