import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/features/call/pages/audio_call_page.dart';
import 'package:sampark_app/features/call/pages/video_call_page.dart';
import 'package:sampark_app/models/audio_call_model.dart';
import 'package:sampark_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid();

  @override
  void onInit() {
    super.onInit();
    getCallNotfication().listen(
      (List<CallModel> callList) {
        if (callList.isNotEmpty) {
          var callData = callList[0];
          if (callData.type == 'audio') {
            audioCallNotification(callData);
          } else if (callData.type == 'video') {
            videoCallNotification(callData);
          }
        }
      },
    );
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      duration: Duration(days: 1),
      onTap: (snack) {
        Get.back();
        Get.to(
          () => AudioCallPage(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profilePic: callData.callerProfilePic,
            ),
          ),
        );
      },
      barBlur: 0,
      callData.callerName!,
      'Incoming Voice Call',
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: Text(""),
      ),
      isDismissible: false,
      backgroundColor: Colors.grey,
      icon: Icon(
        Icons.call,
      ),
    );
  }

  Future<void> videoCallNotification(CallModel callData) async {
    Get.snackbar(
      duration: Duration(days: 1),
      onTap: (snack) {
        Get.back();
        Get.to(
          () => VideoCallPage(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profilePic: callData.callerProfilePic,
            ),
          ),
        );
      },
      barBlur: 0,
      callData.callerName!,
      'Incoming Video Call',
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: Text(""),
      ),
      isDismissible: false,
      backgroundColor: Colors.grey,
      icon: Icon(Icons.video_call),
    );
  }

  Future<void> callAction(
      UserModel receiver, UserModel caller, String type) async {
    String id = uuid.v4();
    DateTime timeStamp = DateTime.now();
    String currentTime = DateFormat('hh:mm a').format(timeStamp);
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerProfilePic: caller.profilePic,
      callerEmail: caller.email,
      callerUid: caller.id,
      receiverName: receiver.name,
      receiverEmail: receiver.email,
      receiverProfilePic: receiver.profilePic,
      receiverUid: receiver.id,
      status: 'calling',
      type: type,
      time: currentTime,
      timeStamp: DateTime.now().toString(),
    );
    try {
      await db
          .collection('notifications')
          .doc(receiver.id)
          .collection('call')
          .doc(id)
          .set(
            newCall.toJson(),
          );
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('calls')
          .doc(id)
          .set(
            newCall.toJson(),
          );
      await db
          .collection('users')
          .doc(receiver.id)
          .collection('calls')
          .doc(id)
          .set(
            newCall.toJson(),
          );
      log("Function Called");
      Future.delayed(
        Duration(
          // minutes: 1,
          seconds: 20,
        ),
        () {
          endCall(newCall);
          log("Call Deleted");
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<CallModel>> getCallNotfication() {
    return db
        .collection('notifications')
        .doc(auth.currentUser!.uid)
        .collection('call')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => CallModel.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection('notifications')
          .doc(call.receiverUid)
          .collection('call')
          .doc(call.id)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
