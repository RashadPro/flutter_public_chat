import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constans.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/logo.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // const ChatPage({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();

  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      //Return all data in colection.
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),

      builder: (context, snapshot) {
        //snapshot if have data build UI with data.
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              Message.fromJson(snapshot.data!.docs[i]),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              actions: const [
                Icon(
                  Iconsax.video,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Iconsax.call_calling,
                    color: Colors.white,
                  ),
                ),
              ],
              leading: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
              ),
              centerTitle: true,
              title: Row(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      klogo,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Public",
                        style: TextStyle(
                          color: Color(0xff006EF1),
                          fontFamily: "PilatExtended-Regular",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Chat",
                        style: TextStyle(
                          color: Color(0xffFEA92E),
                          fontFamily: "PilatExtended-Regular",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: kPrimaryColor,
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubbleForFriend(
                              friendMessage: messageList[index],
                            )
                          : ChatBubble(myMessage: messageList[index]);
                    },
                  ),
                ),
                // Button Type a message
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "PilatExtended-Regular",
                      fontSize: 18,
                    ),
                    controller: controller,
                    onFieldSubmitted: (data) {
                      messages.add({
                        'message': data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      // علشان ينزل للأخر
                      _controller.animateTo(
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        child: const Icon(
                          Iconsax.send_1,
                          color: Color(0xffFED36A),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Iconsax.element_equal,
                        color: Color(0xffFED36A),
                      ),
                      hintText: "  Type a message",
                      hintStyle: const TextStyle(
                        color: Color(0xff8CAAB9),
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: const Color(0xff263238),
                      contentPadding: const EdgeInsets.all(18),
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffFED36A),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          isLoding = true;
          return ModalProgressHUD(
            inAsyncCall: isLoding,
            child: const Scaffold(
              backgroundColor: kPrimaryColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
