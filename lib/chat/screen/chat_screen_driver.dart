import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/chat/chat_controller.dart';
import 'package:get_smart_ride_cas/chat/models/message_model.dart';
import 'package:get_smart_ride_cas/chat/models/user_model.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';

class DriverChatScreen extends StatefulWidget {
  final User user;
  final ridingRequestId;
  DriverChatScreen({this.user, this.ridingRequestId});

  @override
  _DriverChatScreenState createState() => _DriverChatScreenState();
}

class _DriverChatScreenState extends State<DriverChatScreen> {
  TextEditingController _messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  _chatBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage("images/profile_vector.jpg"),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage("images/profile_vector.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              onSubmitted: addNewMessage(),
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              //      ChattMessages(string Str1, string Str2, string Str3, string Str4, string RideRequestId, string Message)
              chattMessages(widget.ridingRequestId);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ChatController.to.listclear();
    _messageController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    //final controller2 = Get.put(DriverChatController());
    int prevUserId;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        titleSpacing: 0,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text("Chat"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      // do min thra

      // ap ka mobile ma app install ha na?
      body: Column(
        children: <Widget>[
          GetBuilder<ChatController>(
            init: ChatController(),
            builder: (value) {
              // messagesList.add(value.message);
              // print(
              //     "Message ===================${value.message.text ?? "NO msg intilize"}");
              print("Message ===================${value.messagesList.length}");
              return Expanded(
                  child: ListView.builder(
                // reverse: true,
                controller: scrollController,
                padding: EdgeInsets.all(20),
                itemCount: value.messagesList.length,
                itemBuilder: (BuildContext context, int index) {
                  print(
                      ".........................${value.messagesList.length}");
                  final Message message = value.messagesList[index];
                  print("Message Sender =====${message.sender.name}");
                  final bool isMe =
                      message.sender.name == "From Driver" ? true : false;
                  final bool isSameUser = true;
                  prevUserId = message.sender.id;
                  return _chatBubble(message, isMe, isSameUser);
                },
              ));
            },
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

//ya tu ab thk work kr rha ha...haann aik class wala kaam theek haii
// hm agya krta ha isa
  void chattMessages(
    rideRequestId,
  ) {
    // print("Message =======================${_messageController.text}");
    Utils.checkInternetConnectivity().then((value) {
      if (value == true) {
        print(
            "====================Msg is send by Driver =====================${Commons.userType} ");

        hubConnection.invoke("ChattMessages", args: [
          "${DriverConst.str1}",
          "${DriverConst.str2}",
          "${DriverConst.str3}",
          "${DriverConst.str4}",
          "$rideRequestId",
          "${_messageController.text}"
        ]).catchError((e) {
          print(
              "------------------ Send Message to Driver Error ---------- $e");
        });
        _messageController.clear();

        //   call a gi thi ma wha busy ho gy ha
      }
    });
  }

  addNewMessage() {
    print('sddddddddddddddddddddddddd');

    Timer(
        Duration(milliseconds: 300),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
    //}
  }
}
