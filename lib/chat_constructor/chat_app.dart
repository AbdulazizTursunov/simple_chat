import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_socket/constant.dart';

class ChatApp extends StatefulWidget {
  @override
  State createState() => ChatWindow();
}

class ChatWindow extends State<ChatApp> with TickerProviderStateMixin {
  final List<Msg> message = [];
  TextEditingController controller = TextEditingController();
  bool isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caht Application"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.6,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: message.length,
                reverse: true,
                padding: const EdgeInsets.all(6.0),
                itemBuilder: (context, index) => message[index]),
          ),
          const Divider(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildCompasor(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompasor() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).focusColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 9.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.brown)))
            : null,
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                onChanged: (v) {
                  setState(() {
                    isWriting = v.isNotEmpty;
                  });
                },
                onSubmitted: submitMsg,
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter some text to send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      onPressed:
                          isWriting ? () => submitMsg(controller.text) : null,
                      child: const Text("Submit"))
                  : IconButton(
                      onPressed:
                          isWriting ? () => submitMsg(controller.text) : null,
                      icon: const Icon(Icons.message)),
            )
          ],
        ),
      ),
    );
  }

  submitMsg(String title) {
    controller.clear();
    setState(() {
      isWriting == false;
    });
    Msg msg = Msg(
      title: title,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    setState(() {
      message.insert(0, msg);
    });
    msg.animationController.forward();

  }
}

class Msg extends StatelessWidget {
  const Msg(
      {super.key, required this.title, required this.animationController});

  final String title;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                child: Text(userName[0]),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6.0),
                  child: Text(title),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
