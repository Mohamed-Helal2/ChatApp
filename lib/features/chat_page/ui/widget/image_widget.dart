import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.index,
      required this.alignment,
      required this.listphotoes,
      required this.photocaption,
      required this.color
      });
  final int index;
  final AlignmentGeometry alignment;
  final List listphotoes;
  final String photocaption;
    final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(2),
        // height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.7,
        //height: 60.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: listphotoes.length == 1
            ? Container(
                padding: EdgeInsets.all(2),
                child: photocaption == ""
                    ? Image.network(
                        context
                            .read<MessageCubit>()
                            .messageList[index]
                            .content[0],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            context
                                .read<MessageCubit>()
                                .messageList[index]
                                .content[0],
                          ),
                          CustomText(
                            text: '${photocaption}',
                            fontsize: 17,
                            fontWeight: FontWeight.w600,
                            fontcolor: Colors.white,
                            fontfamily: null,
                          )
                        ],
                      ))
            : Container(
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 39, 4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: photocaption == ""
                    ? GridView.builder(
                        itemCount: listphotoes.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(listphotoes[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            itemCount: listphotoes.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(listphotoes[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          CustomText(
                            text: '${photocaption}',
                            fontsize: 17,
                            fontWeight: FontWeight.w600,
                            fontcolor: Colors.white,
                            fontfamily: null,
                          )
                        ],
                      )),
      ),
    );
  }
}
