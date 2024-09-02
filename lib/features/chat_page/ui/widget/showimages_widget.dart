import 'dart:io';
import 'package:chatty/Core/widget/custom_text_form_field.dart';
import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class showimages extends StatefulWidget {
  const showimages(
      {super.key,
      required this.imagepathes,
      required this.docid,
      required this.imagenames});
  final List imagepathes;
  final List imagenames;
  final String docid;

  @override
  State<showimages> createState() => _showimagesState();
}

class _showimagesState extends State<showimages> {
  @override
  Widget build(BuildContext context) {
    //final PageController pageController = PageController();
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (BuildContext context, MessageState state) {
        if (state is showimagesstatesucess) {
          state.images;
        }
        if (state is ImageSendSucess) {
          Navigator.of(context).pop();
        }
      },
      builder: (BuildContext context, MessageState state) {
        return
            // },
            Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // Background PhotoView
                Positioned.fill(
                    child: PhotoViewGallery.builder(
                  onPageChanged: (index) {
                    print("===================>> ${index}");
                    context
                        .read<MessageCubit>()
                        .changephotonumer2(index2: index);
                  },
                  pageController: context.read<MessageCubit>().pageController,
                  itemCount: widget.imagepathes.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: FileImage(File(widget.imagepathes[index])),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(tag: index),
                    );
                  },
                )),
                // Foreground widgets
                Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      color: Colors.deepOrangeAccent,
                      height: 50.h,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.imagepathes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print(
                                    "------${context.read<MessageCubit>().lastimages1.length}");
                                context.read<MessageCubit>().photonumber ==
                                        index
                                    ? widget.imagepathes.removeAt(index)
                                    : context
                                        .read<MessageCubit>()
                                        .changephotonumer(index0: index);
                                setState(() {});
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  width: 60.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    border: context
                                                .read<MessageCubit>()
                                                .photonumber ==
                                            index
                                        ? Border.all(
                                            color: Colors.white, width: 2)
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: FileImage(
                                          File(widget.imagepathes[index]),
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: context
                                              .read<MessageCubit>()
                                              .photonumber ==
                                          index
                                      ? const Icon(
                                          Icons.delete_outline_sharp,
                                          size: 40,
                                          color: Color.fromARGB(
                                              154, 255, 255, 255),
                                        )
                                      : null),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 70.h,
                      padding: const EdgeInsets.all(10.0),
                      child: customTextFormField(
                        controller: context.read<MessageCubit>().photocaption,
                        hintText: "Add a Caption....",
                        hintStyle: const TextStyle(color: Colors.white),
                        style: const TextStyle(color: Colors.white),
                        fillColor: const Color.fromARGB(255, 58, 70, 78),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(130, 0, 168, 132),
                        ),
                        child: IconButton(
                            onPressed: () {
                              context.read<MessageCubit>().sendimages(
                                  docid: widget.docid,
                                  messagepetho: widget.imagepathes,
                                  imagenemo: widget.imagenames);
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Color.fromARGB(255, 182, 174, 174),
                              size: 30,
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
