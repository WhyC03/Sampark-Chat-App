
class ChatModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? recieverId;
  String? timeStamp;
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;
  List<String>? reactions;
  List<dynamic>? replies;

   ChatModel({this.id, this.message, this.senderName, this.senderId, this.recieverId, this.timeStamp, this.readStatus, this.imageUrl, this.videoUrl, this.audioUrl, this.documentUrl, this.reactions, this.replies});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    message = json["message"];
    senderName = json["senderName"];
    senderId = json["senderId"];
    recieverId = json["recieverId"];
    timeStamp = json["timeStamp"];
    readStatus = json["readStatus"];
    imageUrl = json["imageUrl"];
    videoUrl = json["videoUrl"];
    audioUrl = json["audioUrl"];
    documentUrl = json["documentUrl"];
    reactions = json["reactions"] == null ? null : List<String>.from(json["reactions"]);
    replies = json["replies"] ?? [];
  }

  static List<ChatModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ChatModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["message"] = message;
    data["senderName"] = senderName;
    data["senderId"] = senderId;
    data["recieverId"] = recieverId;
    data["timeStamp"] = timeStamp;
    data["readStatus"] = readStatus;
    data["imageUrl"] = imageUrl;
    data["videoUrl"] = videoUrl;
    data["audioUrl"] = audioUrl;
    data["documentUrl"] = documentUrl;
    if(reactions != null) {
      data["reactions"] = reactions;
    }
    if(replies != null) {
      data["replies"] = replies;
    }
    return data;
  }
}