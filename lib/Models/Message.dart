import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String sent_by;

  String sent_to;

  DateTime time;

  Message({
    this.message,
    this.sent_by,
    this.sent_to,
  }) {
    this.time = DateTime.now();
  }

  toMap() {
    return {
      'message': message,
      'sent_by': sent_by,
      'time': time,
      'sent_to': sent_to,
    };
  }
}

class MessageTracker {
  String latest_message;
  String sent_by;
  String sent_to;

  String chat_id;

  String first_participant;
  String second_participant;

  String sender_name;
  String receiver_name;

  bool read_by_sender = true;

  bool read_by_receiver = false;

  DocumentReference sender;
  DocumentReference reciever;


  DateTime time;

  List<String> participants;

  MessageTracker(
      {this.latest_message,
      this.sent_to,
      this.sent_by,
      this.sender_name,
      this.receiver_name,
        this.sender,
        this.reciever,

      this.chat_id,
      this.participants, }) {
    this.time = DateTime.now();
  }

  toMap() {
    return {
      'latest_message': latest_message,
      'sent_by': sent_by,
      'time': time,
      'sent_to': sent_to,
      'sender_name': sender_name,
      'sender' : sender,
      'receiver' : reciever,
      'read_by_receiver': read_by_receiver,
      'chat_id': chat_id,
      'receiver_name': receiver_name,
      'participants': participants,

    };
  }
}

class ChatId {
  String id;
  String firstParticipant;
  String secondParticipant;

  ChatId({this.firstParticipant, this.secondParticipant}) {
    if (_isGreater(firstParticipant, secondParticipant))
      this.id = firstParticipant + secondParticipant;
    else
      this.id = secondParticipant + firstParticipant;
  }
  static generateChatId(String firstParticipant, String secondParticipant) {
    return ChatId(
        firstParticipant: firstParticipant,
        secondParticipant: secondParticipant);
  }

  bool _isGreater(String first, String second) {
    return first.compareTo(second) < 1;
  }
}
