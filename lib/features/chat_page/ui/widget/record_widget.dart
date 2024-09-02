import 'package:audioplayers/audioplayers.dart';
import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:chatty/features/chat_page/ui/widget/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget(
      {super.key,
      required this.index,
      required this.alignment,
      required this.docid,
      required this.messagid,
      required this.color});
  final int index;
  final String docid;
  final String messagid;
  final AlignmentGeometry alignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is audiodurationstate) {
          state.audioduration0;
        }
        if (state is timeprogrssstate) {
          state.timeprogrss0;
        }
        if (state is Playrecordstate) {}
      },
      builder: (context, state) {
        return Align(
          alignment: alignment,
          child: Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child:
                // Text("ssd")
                Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: gettimestring(
                      context.read<MessageCubit>().timeprogrss[index]!),
                  fontsize: 13,
                  fontcolor: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  width: 1,
                ),
                Container(
                  width: 160.w,
                  child: Slider.adaptive(
                    value: (context.read<MessageCubit>().timeprogrss[index]! /
                            1000)
                        .floorToDouble(),
                    min: 0,
                    max: (context.read<MessageCubit>().audiodurations[index]! /
                            1000)
                        .floorToDouble(),
                    onChanged: (value) {
                      context.read<MessageCubit>().seekto(value.toInt(), index);
                    },
                  ),
                ),
                CustomText(
                  text: // "55",
                      gettimestring(context
                          .read<MessageCubit>()
                          .messageList[index]
                          .audiotime!),
                  fontsize: 13,
                  fontcolor: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<MessageCubit>()
                          .longplay(index, docid, messagid);
                    },
                    icon: Icon(
                      context.read<MessageCubit>().playbackStates[index] ==
                              PlayerState.playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
