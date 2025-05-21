import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_utils/t_utils.dart';

import '../../../../../personalization/controllers/user_controller.dart';
import '../../../../controllers/chat_controller.dart';
import '../../../../models/chat_model.dart';
import '../../../../models/participant_model.dart';
import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();
    return Column(
      spacing: TSizes().spaceBtwItems,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TTextWithIcon(text: 'Chats', icon: Iconsax.messages_35),

        /// Chats
        Obx(() {
          if (chatController.isLoading.value) return const Center(child: CircularProgressIndicator());
          if (chatController.chats.isEmpty) return const Center(child: Text('No chats available'));
          return Obx(
                () => ListView.builder(
              shrinkWrap: true,
              itemCount: chatController.chats.length,
              itemBuilder: (context, index) {
                ChatModel chat = chatController.chats[index];
                ParticipantModel otherParticipant =
                    chat.participants.where((user) => user.userId != UserController.instance.user.value.id).firstOrNull ??
                        ParticipantModel(userId: '', name: '', profileImageURL: '');

                return ChatTile(otherParticipant: otherParticipant, chat: chat);
              },
            ),
          );
        }),
      ],
    );
  }
}
