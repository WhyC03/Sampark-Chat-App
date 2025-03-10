import 'package:sampark_app/models/chat_model.dart';
import 'package:sampark_app/models/user_model.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? reciever;
  List<ChatModel>? messages;
  int? unReadMessNo;
  String? lastMessage;
  String? lastMessageTimedstamp;
  String? timeStamp;

  ChatRoomModel(
      {this.id,
      this.sender,
      this.reciever,
      this.messages,
      this.unReadMessNo,
      this.lastMessage,
      this.lastMessageTimedstamp,
      this.timeStamp});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sender = json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    reciever =
        json["reciever"] == null ? null : UserModel.fromJson(json["reciever"]);
    messages = json["messages"] ?? [];
    unReadMessNo = json["unReadMessNo"];
    lastMessage = json["lastMessage"];
    lastMessageTimedstamp = json["lastMessageTimedstamp"] ;
    timeStamp = json["timeStamp"];
  }

  static List<ChatRoomModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ChatRoomModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (sender != null) {
      data["sender"] = sender?.toJson();
    }
    if (reciever != null) {
      data["reciever"] = reciever?.toJson();
    }
    if (messages != null) {
      data["messages"] = messages;
    }
    data["unReadMessNo"] = unReadMessNo;
    data["lastMessage"] = lastMessage;
    data["lastMessageTimedstamp"] = lastMessageTimedstamp;
    data["timeStamp"] = timeStamp;
    return data;
  }
}
