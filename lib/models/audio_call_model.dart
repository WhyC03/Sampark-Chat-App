class CallModel {
  String? id;
  String? callerName;
  String? callerProfilePic;
  String? callerUid;
  String? callerEmail;
  String? receiverName;
  String? receiverProfilePic;
  String? receiverUid;
  String? receiverEmail;
  String? status;
  String? type;
  String? time;
  String? timeStamp;

  CallModel({
    this.id,
    this.callerName,
    this.callerProfilePic,
    this.callerUid,
    this.callerEmail,
    this.receiverName,
    this.receiverProfilePic,
    this.receiverUid,
    this.receiverEmail,
    this.status,
    this.type,
    this.time,
    this.timeStamp,
  });

  CallModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["callerName"] is String) {
      callerName = json["callerName"];
    }
    if (json["callerProfilePic"] is String) {
      callerProfilePic = json["callerProfilePic"];
    }
    if (json["callerUid"] is String) {
      callerUid = json["callerUid"];
    }
    if (json["callerEmail"] is String) {
      callerEmail = json["callerEmail"];
    }
    if (json["receiverName"] is String) {
      receiverName = json["receiverName"];
    }
    if (json["receiverProfilePic"] is String) {
      receiverProfilePic = json["receiverProfilePic"];
    }
    if (json["receiverUid"] is String) {
      receiverUid = json["receiverUid"];
    }
    if (json["receiverEmail"] is String) {
      receiverEmail = json["receiverEmail"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["time"] is String) {
      time = json["time"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
  }

  static List<CallModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CallModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["callerName"] = callerName;
    data["callerProfilePic"] = callerProfilePic;
    data["callerUid"] = callerUid;
    data["callerEmail"] = callerEmail;
    data["receiverName"] = receiverName;
    data["receiverProfilePic"] = receiverProfilePic;
    data["receiverUid"] = receiverUid;
    data["receiverEmail"] = receiverEmail;
    data["status"] = status;
    data["type"] = type;
    data["time"] = time;
    data["timeStamp"] = timeStamp;
    return data;
  }
}
