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
  var _controller = TextEditingController();

  getMessages(MessageModel messageModel, int senderId, int receiverId,
      String token) async {
    // var allEvents = await eventInfoModel.fetchUpcomingEvents(
    //     userModel.currentUser.id, userModel.token);
    var allEvents =
        await messageModel.fetchMessages(senderId, receiverId, token);
    return allEvents;
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
      appBar: AppBar(),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  child: Text(messages[index].text),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 50.0,
                  color: Colors.white,
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
                              // onPressed: () => _controller.clear(),
                              icon: Icon(Icons.send),
                            ),
                          ),
                        ),
                        // TextField(
                        //   textCapitalization: TextCapitalization.sentences,
                        //   onChanged: (value) {
                        //     _changeText(value);
                        //   },
                        //   decoration: InputDecoration.collapsed(
                        //     hintText: 'Send a message...',
                        //   ),
                        // ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.send),
                      //   iconSize: 25.0,
                      //   color: Theme.of(context).primaryColor,
                      //   onPressed: () {
                      //     setState(() {
                      //       _sendMessage();
                      //     });
                      //     FocusScope.of(context).unfocus();
                      //     _changeText(" ");
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
