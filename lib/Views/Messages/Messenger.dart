import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

Widget _buildWidget(String chatId, User currentUser, User talkingTo) {

  return StreamBuilder(
      stream: FirebaseDB.getMessages(chatId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: ThemeBanner(
              title: 'No Internet Connection',
              description: 'Please Check Your Network',
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kThemeOrangeFinal,
            ),
          );
        } else if (snapshot == null ||
            snapshot.data.docs.length == 0 ||
            snapshot.data == null ||
            snapshot.data.docs == null ||
            snapshot.hasError) {
          return Center(
            child: ThemeBanner(
              title: '',
              description: 'No Messages...',
            ),
          );
        } else
          return Padding(
            padding: const EdgeInsets.only(bottom: 97),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                if(talkingTo.userId == currentUser.userId)
                  if(currentUser.userId == snapshot.data.docs[index].data()['sent_to'])
                    FirebaseDB.setReadForMessage(chatId);
                var timestamp =
                    snapshot.data.docs[index].data()['time'].toDate();
                var date = DateHandler.getDifference(timestamp);
                return MessageBubble(
                  message: snapshot.data.docs[index].data()['message'],
                  isUser:
                      snapshot.data.docs[index].data()['sent_by'] == currentUser.userId
                          ? true
                          : false,
                  date: date,
                );
              },
              itemCount: snapshot.data.docs.length,
            ),
          );
      });
}

class Messenger extends StatelessWidget {
  final User talkingTo;
  final String chatId;
  final User currentUser;

  Messenger({
    this.talkingTo,
    this.chatId,
    this.currentUser,
  });

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String message;

    return Scaffold(
        appBar: ThemeAppBar(
          pageTitle: talkingTo.fullName,
          description: getRole(talkingTo.role),
          hasBackButton: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _buildWidget(chatId, currentUser, talkingTo),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ThemeTextField(
                    keyboardType: TextInputType.multiline,
                    placeholder: 'Message...',
                    maxLines: null,
                    onValueChanged: (value) {
                      message = value;
                    },
                    controller: _controller,
                    trailingIcon: IconButton(
                      icon: IconHandler.send,
                      onPressed: () async {

                        await FirebaseDB.createMessage(
                          chatId,
                          Message(
                            message: message,
                            sent_by: currentUser.userId,
                            sent_to: talkingTo.userId,
                          ),
                          MessageTracker(
                              latest_message: message,
                              sent_by: currentUser.userId,
                              sent_to: talkingTo.userId,
                              sender_name: currentUser.fullName,
                              receiver_name: talkingTo.fullName,

                              sender: currentUser.userDocument,
                              reciever: talkingTo.userDocument,

                              chat_id: chatId,
                              participants: [
                                currentUser.userId,
                                talkingTo.userId
                              ]),
                        );
                        _controller.clear();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MessengerWeb extends StatelessWidget {
  final User talkingTo;
  final String chatId;
  final User currentUser;

  MessengerWeb({this.talkingTo, this.chatId, this.currentUser});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String message;

    ScrollController _controller = ScrollController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context) - 85,
        child: Scrollbar(
          controller: _controller,
          child: Stack(
            children: [
              _buildWidget(chatId, currentUser, talkingTo),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ThemeTextField(
                    keyboardType: TextInputType.multiline,
                    placeholder: 'Message...',
                    maxLines: null,
                    onValueChanged: (value) {
                      message = value;
                    },
                    controller: _textController,
                    trailingIcon: IconButton(
                      icon: IconHandler.send,
                      onPressed: () async {
                        await FirebaseDB.createMessage(
                          chatId,
                          Message(
                            message: message,
                            sent_by: currentUser.userId,
                            sent_to: talkingTo.userId,
                          ),
                          MessageTracker(
                              latest_message: message,
                              sent_by: currentUser.userId,
                              sent_to: talkingTo.userId,
                              sender_name: currentUser.fullName,
                              receiver_name: talkingTo.fullName,

                              sender: currentUser.userDocument,
                              reciever: talkingTo.userDocument,

                              chat_id: chatId,
                              participants: [
                                currentUser.userId,
                                talkingTo.userId
                              ]),
                        );
                        _textController.clear();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
