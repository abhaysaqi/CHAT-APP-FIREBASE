// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.timestamp,
  });

  Message copyWith({
    String? senderId,
    String? senderEmail,
    String? recieverId,
    String? message,
    Timestamp? timestamp,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      senderEmail: senderEmail ?? this.senderEmail,
      recieverId: recieverId ?? this.recieverId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       senderId: map['senderId'] as String,
//       senderEmail: map['senderEmail'] as String,
//       recieverId: map['recieverId'] as String,
//       message: map['message'] as String,
//       timestamp: Timestamp.fromMap(map['timestamp'] as Map<String,dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Message(senderId: $senderId, senderEmail: $senderEmail, recieverId: $recieverId, message: $message, timestamp: $timestamp)';
//   }

//   @override
//   bool operator ==(covariant Message other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.senderId == senderId &&
//       other.senderEmail == senderEmail &&
//       other.recieverId == recieverId &&
//       other.message == message &&
//       other.timestamp == timestamp;
//   }

//   @override
//   int get hashCode {
//     return senderId.hashCode ^
//       senderEmail.hashCode ^
//       recieverId.hashCode ^
//       message.hashCode ^
//       timestamp.hashCode;
//   }
}
