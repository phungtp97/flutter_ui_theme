import 'dart:math';

import 'package:lorem_gen/lorem_gen.dart';

class MessageEntity {
  final String message;
  final String sender;
  final String to;
  final int timeMillis;

  MessageEntity({
    required this.message,
    required this.sender,
    required this.to,
    required this.timeMillis,
  });
}

class MessageBank {
  static List<MessageEntity> messages = generatedMessages(200);
  MessageBank._();

  static List<String> senders = ['Tom', 'Alice', 'Bob', 'Charlie', 'Dave', 'Eve'];
  static String me = 'Tom';
}

List<MessageEntity> generatedMessages(int numberOfMessages) {
  final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
  final Random random = Random();

  List<MessageEntity> messages = [];

  for (int i = 0; i < numberOfMessages; i++) {
    int randomInt = random.nextInt(4);
    String sender = MessageBank.senders[randomInt];
    int timeOffset = random.nextInt(1000 * 60 * 120);
    int messageTime = currentTimeMillis - timeOffset;
    String receiver = MessageBank.me;
    // Ensure sender is not the same as receiver
    if (sender == MessageBank.me) {
      receiver = MessageBank.senders[random.nextInt(3) + 1];
    }

    messages.add(
      MessageEntity(
        message: 'Message $i from $sender to $receiver\n${Lorem.sentence(numSentences: Random().nextInt(1) + 1)}',
        sender: sender,
        to: receiver,
        timeMillis: messageTime,
      ),
    );
    print('Message $i from $sender to $receiver');
  }

  return messages;
}
