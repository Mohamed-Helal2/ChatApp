import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:chatty/features/chat_page/ui/widget/image_widget.dart';
import 'package:chatty/features/chat_page/ui/widget/record_widget.dart';
import 'package:chatty/features/chat_page/ui/widget/showimages_widget.dart';
import 'package:chatty/features/chat_page/ui/widget/text_widget.dart';
import 'package:chatty/features/chat_page/ui/widget/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessgaeScreen extends StatefulWidget {
  MessgaeScreen(
      {super.key,
      required this.profilepic,
      required this.name,
      required this.documentid});
  final String profilepic;
  final String name;
  final String documentid;

  @override
  State<MessgaeScreen> createState() => _MessgaeScreenState();
}

class _MessgaeScreenState extends State<MessgaeScreen> {
  final ScrollController listscrollcontroler = ScrollController();
  @override
  void initState() {
    //context.read<MessageCubit>().GetMessage(docid: widget.documentid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MessageCubit>(context).GetMessage(docid: widget.documentid);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Container(
              height: 45.h,
              width: 45.w,
              decoration: widget.profilepic == "null"
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/avatar.png"),
                      ),
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.profilepic),
                      ),
                    ),
            ),
            SizedBox(
              width: 10.w,
            ),
            CustomText(
                text: widget.name,
                fontsize: 25,
                fontcolor: Colors.black,
                fontWeight: FontWeight.w700),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 14, left: 10, right: 10),
        child: BlocConsumer<MessageCubit, MessageState>(
          listener: (context, state) {
            if (state is getmessagestate) {
              state.messages;
            }
            if (state is RecordingInProgressstate) {
              state.duration;
            }
            if (state is showimagesstatesucess) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider<MessageCubit>(
                    create: (_) => MessageCubit(),
                    child: showimages(
                      imagepathes: state.images,
                      docid: widget.documentid,
                      imagenames: state.imagenames,
                    )),
              ));
            }
            if (state is sendmessageloading) {}
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: context.read<MessageCubit>().messageList.isEmpty
                        ? image_name(
                            profilepic: widget.profilepic, name: widget.name)
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: ListView.builder(
                              reverse: true,
                              controller: listscrollcontroler,
                              itemCount: context
                                  .read<MessageCubit>()
                                  .messageList
                                  .length,
                              itemBuilder: (context, index) {
                                // photoUrl = [];
                                return context
                                            .read<MessageCubit>()
                                            .messageList[index]
                                            .type ==
                                        'Text'
                                    ? context
                                                .read<MessageCubit>()
                                                .messageList[index]
                                                .from_email ==
                                            FirebaseAuth
                                                .instance.currentUser!.email
                                        ? CustomChatBubble(
                                            color: const Color(0xff284162),
                                            alignment: Alignment.centerLeft,
                                            messageText: context
                                                .read<MessageCubit>()
                                                .messageList[index]
                                                .content!,
                                          )
                                        : CustomChatBubble(
                                            color: const Color.fromARGB(
                                                255, 45, 56, 2),
                                            alignment: Alignment.centerRight,
                                            messageText: context
                                                .read<MessageCubit>()
                                                .messageList[index]
                                                .content!,
                                          )
                                    : context
                                                .read<MessageCubit>()
                                                .messageList[index]
                                                .type ==
                                            'Photo'
                                        ? context
                                                    .read<MessageCubit>()
                                                    .messageList[index]
                                                    .from_email ==
                                                FirebaseAuth
                                                    .instance.currentUser!.email
                                            ? Container(
                                                child: ImageWidget(
                                                  color:
                                                      const Color(0xff284162),
                                                  index: index,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  listphotoes: context
                                                      .read<MessageCubit>()
                                                      .messageList[index]
                                                      .content,
                                                  photocaption: context
                                                      .read<MessageCubit>()
                                                      .messageList[index]
                                                      .photocaption!,
                                                ),
                                              )
                                            : Container(
                                                child: ImageWidget(
                                                  color: const Color.fromARGB(
                                                      255, 45, 56, 2),
                                                  index: index,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  listphotoes: context
                                                      .read<MessageCubit>()
                                                      .messageList[index]
                                                      .content,
                                                  photocaption: context
                                                      .read<MessageCubit>()
                                                      .messageList[index]
                                                      .photocaption!,
                                                ),
                                              )
                                        : context
                                                    .read<MessageCubit>()
                                                    .messageList[index]
                                                    .type ==
                                                'Record'
                                            ? context
                                                        .read<MessageCubit>()
                                                        .messageList[index]
                                                        .from_email ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.email
                                                ? RecordWidget(
                                                    color:
                                                        const Color(0xff284162),
                                                    index: index,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    docid: widget.documentid,
                                                    messagid: context
                                                        .read<MessageCubit>()
                                                        .messagedocs[index],
                                                  )
                                                : RecordWidget(
                                                    color: const Color.fromARGB(
                                                        255, 45, 56, 2),
                                                    index: index,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    docid: widget.documentid,
                                                    messagid: context
                                                        .read<MessageCubit>()
                                                        .messagedocs[index],
                                                  )
                                            : null;
                              },
                            ),
                          )),
                Container(
                  // height: 50.h,
                  child: Row(children: [
                    Expanded(
                        child: context.read<MessageCubit>().isrecord == false
                            ? TextField(
                                onChanged: (value) {
                                  context.read<MessageCubit>().chnageicon();
                                },
                                controller: context
                                    .read<MessageCubit>()
                                    .messagecontroller,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
// send image
                                        onPressed: () {
                                          context
                                              .read<MessageCubit>()
                                              .showimages();
                                          // .sendimages(
                                          //     docid: widget.documentid);
                                        },
                                        icon: const Icon(
                                          Icons.image,
                                          size: 35,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    hintText: "Message"),
                              )
                            : Text(
                                "recording.. ${gettimestring(context.read<MessageCubit>().dr)}")),
                    SizedBox(
                      width: 5.w,
                    ),
                    state is sendmessageloading
                        ? Container(
                            height: // 100.h,
                                context.read<MessageCubit>().cont_hieigt,
                            width: //100.w,
                                context.read<MessageCubit>().cont_width,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 200, 200, 200),
                              borderRadius: BorderRadius.circular(
                                  context.read<MessageCubit>().cont_radius),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                        : Container(
                            height: // 100.h,
                                context.read<MessageCubit>().cont_hieigt,
                            width: //100.w,
                                context.read<MessageCubit>().cont_width,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 200, 200, 200),
                                borderRadius: BorderRadius.circular(
                                    context.read<MessageCubit>().cont_radius)),
                            child: Center(
                              child: context
                                      .read<MessageCubit>()
                                      .messagecontroller
                                      .text
                                      .isEmpty
                                  ? GestureDetector(
                                      onLongPress: () {
                                        context
                                            .read<MessageCubit>()
                                            .changerecord(100, 100, 70, 50);
                                        context
                                            .read<MessageCubit>()
                                            .startRecording();
                                        print("----------- vvoo");
                                      },
                                      onLongPressEnd: (details) {
                                        context
                                            .read<MessageCubit>()
                                            .stopRecording(
                                                docid: widget.documentid);
                                        context
                                            .read<MessageCubit>()
                                            .changerecord(50, 50, 40, 30);
                                        print("------------ End");
                                      },
                                      child: Icon(
                                        (Icons.mic),
                                        size: context
                                            .read<MessageCubit>()
                                            .sizemic,
                                        color: Color.fromARGB(255, 1, 78, 8),
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        context.read<MessageCubit>().addmessage(
                                              docid: widget.documentid,
                                            );
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        size: 30,
                                        color: Color.fromARGB(255, 1, 78, 8),
                                      )),
                            ))
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // String gettimestring(int milliseconds) {
  //   String minutes =
  //       '${(milliseconds / 60000).floor() < 10 ? 0 : ''} ${(milliseconds / 60000).floor()}';
  //   String seconds =
  //       "${(milliseconds / 1000).floor() % 60 < 10 ? 0 : ''} ${(milliseconds / 1000).floor() % 60} ";
  //   return '$minutes:$seconds';
  // }
}

class image_name extends StatelessWidget {
  const image_name({
    super.key,
    required this.profilepic,
    required this.name,
  });

  final String profilepic;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 220.h,
          width: 220.w,
          decoration: profilepic == "null"
              ? const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/avatar.png")))
              : BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(profilepic),
                  ),
                ),
        ),
        CustomText(
            text: name,
            fontsize: 25,
            fontcolor: Colors.black,
            fontWeight: FontWeight.w600),
      ],
    );
  }
}
