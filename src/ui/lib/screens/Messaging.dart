import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/Cards/EventCard.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/Message.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:ui/screens/AddEvents.dart';

// The UI screen to view a specific event details
// Event information is populated with the eventId
// If the user is the owner of the event, there is an edit functionality

class Messaging extends StatefulWidget {
  final int receiverId;

  const Messaging(this.receiverId);
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  int senderId;
  int receiverId;
  String messageText;
  List<Message> messages = [];
  bool isThinking = true;
  var _controller = TextEditingController();

  getMessages(MessageModel messageModel, int senderId, int receiverId,
      String token) async {
    // var allEvents = await eventInfoModel.fetchUpcomingEvents(
    //     userModel.currentUser.id, userModel.token);
    var allMessages =
        await messageModel.fetchMessages(senderId, receiverId, token);
    return allMessages;
  }

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final messageModel = globalModel.messageModel;

    getMessages(messageModel, userModel.currentUser.id, widget.receiverId,
            userModel.token)
        .then((data) {
      isThinking = false;
      setState(() {
        messages.addAll(data);
      });
    });

    senderId = userModel.currentUser.id;
    receiverId = widget.receiverId;
  }

  void _changeText(value) {
    setState(() {
      messageText = value;
      print(messageText);
    });
  }

  void _sendMessage() {
    context
        .read<GlobalModel>()
        .messageModel
        .sendMessage(senderId, receiverId, DateTime.now(), messageText,
            context.read<GlobalModel>().userModel.token)
        .then((success) {
      if (success) {
        setState(() {
          final globalModel = context.read<GlobalModel>();
          final userModel = globalModel.userModel;
          final messageModel = globalModel.messageModel;

          getMessages(messageModel, userModel.currentUser.id, widget.receiverId,
                  userModel.token)
              .then((data) {
            setState(() {
              messages.addAll(data);
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Direct Message",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: isThinking
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                messages.length > 0
                    ? Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: messages.length,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          messages[index].senderId == receiverId
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Text(messages[index].text),
                                      ],
                                    )),
                              );
                            }),
                      )
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 50.0,
                  color: Palette.lightGray,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            _changeText(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Enter a message",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _sendMessage();
                                });
                                FocusScope.of(context).unfocus();
                                _controller.clear();
                              },
                              icon: Icon(Icons.send),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
