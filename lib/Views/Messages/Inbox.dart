import 'package:ember/Components/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InboxView extends StatefulWidget {
  final User currentUser;

  InboxView({this.currentUser});

  @override
  _InboxViewState createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  Widget webWidget = SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ThemeAppBar(
          pageTitle: 'Messages',
          hasBackButton: false,
          // trailing: NavigationButton(
          //   icon: IconHandler.newMessage,
          //   onPressed: () {},
          // ),
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: ThemeContainer(
                  width: kIsWeb
                      ? getDeviceWidth(context) / 3
                      : getDeviceWidth(context) - 6,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                          stream:
                              FirebaseDB.getAllInInbox(widget.currentUser.userId),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return Center(
                                child: ThemeBanner(
                                  title: 'No Internet Connection',
                                  description: 'Please Check Your Network',
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: Column(
                                children: [
                                  SizedBox(height: getDeviceHeight(context)/2.5,),
                                  CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
                                ],
                              ));
                            } else if (snapshot.data == null ||
                                snapshot.data.docs.length == 0) {
                              return Center(
                                child: ThemeBanner(
                                  title: 'Nothing in Inbox...',
                                  description: '',
                                ),
                              );
                            }
                            else
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 97),
                                child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: false,
                                  itemBuilder: (context, index) {
                                    String sender;
                                    bool isRead;
                                    String senderImage;
                                    String receiverImage;
                                    String displayImage;

                                    getImages() async {
                                      var senderDocument = await snapshot.data.docs[index]
                                          .data()['sender'].get();

                                      senderImage = senderDocument.data()['image'];
                                      print(senderImage);
                                      var receiverDocument= await snapshot.data.docs[index]
                                          .data()['receiver'].get();
                                      receiverImage = receiverDocument.data()['image'];
                                      print(receiverImage);
                                      displayImage = receiverImage;
                                    }

                                    getImages();

                                    if (snapshot.data.docs[index]
                                        .data()['sent_by'] ==
                                        widget.currentUser.userId) {
                                      sender = snapshot.data.docs[index]
                                          .data()['receiver_name'];
                                      isRead = true;
                                      displayImage = senderImage;
                                      print(displayImage);


                                    } else {
                                      sender = snapshot.data.docs[index]
                                          .data()['sender_name'];
                                      isRead = snapshot.data.docs[index]
                                          .data()['read_by_receiver'];
                                      displayImage = receiverImage;

                                    }

                                    var timestamp = snapshot.data.docs[index]
                                        .data()['time']
                                        .toDate();
                                    var date = DateHandler.getDifference(
                                        timestamp);
                                    return MessageBlock(
                                      image: displayImage,
                                      senderName: sender,
                                      textSample: snapshot.data.docs[index]
                                          .data()['latest_message'],
                                      isRead: isRead,
                                      date: date,
                                      onPressed: () async {
                                        await FirebaseDB.setReadForMessage(
                                            snapshot.data.docs[index]
                                                .data()['chat_id']);



                                        var first_participant = User.fromMap(await FirebaseDB.getUserInfo(snapshot
                                            .data
                                            .docs[index]
                                            .data()[
                                        'sent_by']));
                                        var second_participant = User.fromMap(await FirebaseDB.getUserInfo(snapshot
                                            .data
                                            .docs[index]
                                            .data()[
                                        'sent_to']));


                                        var talkingTo;

                                        if(widget.currentUser.userId == first_participant.userId)
                                          talkingTo = second_participant;
                                        else
                                          talkingTo = first_participant;


                                        setState(() {

                                          kIsWeb
                                              ? webWidget = MessengerWeb(
                                            talkingTo: talkingTo,
                                            chatId: snapshot
                                                .data.docs[index]
                                                .data()['chat_id'],
                                            currentUser: widget.currentUser,
                                          )
                                              : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Messenger(
                                                        talkingTo: talkingTo,
                                                        chatId: snapshot.data
                                                            .docs[index]
                                                            .data()[
                                                        'chat_id'],
                                                        currentUser: widget
                                                            .currentUser,
                                                      )));
                                        });
                                      },
                                    );
                                  },
                                  itemCount: snapshot.data.docs.length,
                                ),
                              );

                          }),
                    ],
                  ),
                ),
              ),
              kIsWeb
                  ? VerticalDivider(
                color: kThemeOrangeFinal,
                width: 0.2,
                thickness: 0.1,
                indent: 20,
                endIndent: 20,
              )
                  : SizedBox(),
              kIsWeb ? buildWebHalf() : SizedBox(),
            ],
          ),
        ));
  }

  buildWebHalf() {
    if (webWidget != SizedBox())
      return webWidget;
    else
      return SizedBox();
  }
}
