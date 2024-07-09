import 'package:dynamic_widget_ext/extension/context_ext.dart';
import 'package:dynamic_widget_ext/extension/string_ext.dart';
import 'package:dynamic_widget_ext/extension/theme_ext.dart';
import 'package:dynamic_widget_ext/extension/widget_ext.dart';
import 'package:dynamic_widget_ext/pages/message_bank.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../shared/shared.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  String? friend;

  @override
  void initState() {
    friend =
        MessageBank.senders.where((element) => element != MessageBank.me).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.dynamicBackground1,
        appBar: AppBar(
          title: 'Chats'.text(style: context.textTheme.displayLarge),
          elevation: 0.0,
          automaticallyImplyLeading: !kIsWeb,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          iconTheme: context.theme.iconTheme,
        ),
        body: ResponsiveBreakpoints.of(context).screenWidth > 600
            ? Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    buildChat(),
                    Expanded(
                      flex: 2,
                      child: ChatPage(
                        sender: friend!,
                      ),
                    ),
                  ],
                ),
              ],
            )
            : buildChat());
  }

  Widget buildChat() {
    return SizedBox(
      width: ResponsiveBreakpoints.of(context).screenWidth > 600
          ? 320
          : double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Messenger',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Palette.textSubtitle,
                ),
                filled: true,
                fillColor: context.dynamicBackground2,
                contentPadding: const EdgeInsets.all(4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(44),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: MessageBank.senders.length,
            itemBuilder: (context, index) {
              final sender = MessageBank.senders[index];
              if (sender == MessageBank.me) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
                          friend == sender
                      ? context.dynamicBackground2
                      : context.dynamicBackground1,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      if (ResponsiveBreakpoints.of(context).screenWidth > 600) {
                        friend = sender;
                        setState(() {});
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              sender: sender,
                            ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        const FlutterLogo(size: 44)
                            .padding(0, 10)
                            .circleRect(54, color: Colors.blueGrey),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sender.text(style: context.textTheme.bodyLarge),
                            const SizedBox(
                              height: 4,
                            ),
                            'Online'.text(
                                style: context.textTheme.subtitle(context)),
                          ],
                        ).expand(),
                      ],
                    ).padding(12),
                  ),
                ),
              );
            },
          ).expand(),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String sender;

  const ChatPage({super.key, required this.sender});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    ///scroll the listview all the way to bottom
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   controller.jumpTo(controller.position.maxScrollExtent);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget user = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FlutterLogo(size: 30)
            .padding(4)
            .circleRect(30, color: Colors.blueGrey)
            .paddingOnly(right: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.sender.text(style: context.textTheme.displaySmall),
            'Online'.text(style: context.textTheme.subtitle(context)),
          ],
        ),
      ],
    );
    Widget actionBar = SizedBox(
      width: 122,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
              color: Palette.primary),
          const SizedBox(width: 16),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.video_call),
              color: Palette.primary),
        ],
      ),
    );

    Widget content = Column(
      children: [
        if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
          Row(
            children: [
              user.align(Alignment.centerLeft).expand(),
              actionBar.align(Alignment.centerLeft),
            ],
          ),
        Expanded(child: buildChatContent()),
        //chat input
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.dynamicBackground1,
          ),
          child: SizedBox(
            height: 36,
            child: Row(
              children: [
                const Icon(Icons.add, color: Palette.textSubtitle),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: context.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      filled: true,
                      fillColor: context.dynamicBackground2,
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Palette.textSubtitle,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(44),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.send, color: Palette.primary),
              ],
            ),
          ),
        ),
      ],
    );
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(child: user),
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: context.dynamicBackground1,
          iconTheme: context.theme.iconTheme,
          titleSpacing: 0,
          centerTitle: false,
          actions: [
            actionBar,
          ],
        ),
        backgroundColor: context.dynamicBackground1,
        body: SafeArea(child: content),
      );
    } else {
      return content;
    }
  }

  Widget buildChatContent() {
    List<MessageEntity> messages = List.from(MessageBank.messages.where(
        (element) =>
            (element.sender == MessageBank.me && element.to == widget.sender) ||
            (element.sender == widget.sender && element.to == MessageBank.me)));

    messages.sort((a, b) => b.timeMillis.compareTo(a.timeMillis));

    ///ListView builder for chat content, group by sender and with near timeMillis
    return ListView.builder(
      itemCount: messages.length,
      controller: controller,
      reverse: true,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message.sender == MessageBank.me;
        final nextMsg =
            index + 1 < messages.length ? messages[index + 1] : null;
        final lastMsg = index - 1 >= 0 ? messages[index - 1] : null;
        final bool startOfSection = lastMsg == null ||
            lastMsg.sender != message.sender ||
            message.timeMillis - lastMsg.timeMillis > 180000000;
        final bool endOfSection = nextMsg == null ||
            nextMsg.sender != message.sender ||
            nextMsg.timeMillis - message.timeMillis > 180000000;
        return Column(
          children: [
            if (endOfSection)
              timeAgo(message.timeMillis)
                  .text(
                      style: context.textTheme.bodySmall?.copyWith(
                    color: Palette.textSubtitle,
                  ))
                  .paddingOnly(left: 12, top: 12, bottom: 4),
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (endOfSection && !isMe)
                  const FlutterLogo(size: 20)
                      .padding(5)
                      .circleRect(30, color: Colors.blueGrey)
                      .paddingOnly(right: 12)
                else
                  const SizedBox(width: 42),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color:
                          isMe ? Palette.primary : context.dynamicBackground2,
                      borderRadius: isMe
                          ? buildMyBorder(startOfSection, endOfSection)
                          : buildOtherBorder(startOfSection, endOfSection)),
                  child: message.message.text(
                      style: context.textTheme.bodyMedium?.copyWith(
                          color:
                              isMe ? Colors.white : context.dynamicTextColor)),
                ).expand(),
                if (endOfSection && isMe)
                  const FlutterLogo(size: 20)
                      .padding(5)
                      .circleRect(30, color: Colors.blueGrey)
                      .paddingOnly(left: 12)
                else
                  const SizedBox(width: 42),
              ],
            ).padding(4, 12),
          ],
        );
      },
    );
  }

  BorderRadius buildOtherBorder(bool startOfSection, bool endOfSection) {
    if (startOfSection && endOfSection) {
      return BorderRadius.circular(12);
    } else if (startOfSection) {
      return const BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(3),
        bottomRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    } else if (endOfSection) {
      return const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
        bottomLeft: Radius.circular(3),
        topLeft: Radius.circular(12),
      );
    } else {
      return const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
        topLeft: Radius.circular(3),
        bottomLeft: Radius.circular(3),
      );
    }
  }

  BorderRadius buildMyBorder(bool startOfSection, bool endOfSection) {
    if (startOfSection && endOfSection) {
      return BorderRadius.circular(12);
    } else if (startOfSection) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(3),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      );
    } else if (endOfSection) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomRight: Radius.circular(3),
        bottomLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(3),
        bottomRight: Radius.circular(3),
        bottomLeft: Radius.circular(12),
      );
    }
  }

  String timeAgo(int timeMillis) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    final int diff = now - timeMillis;
    if (diff < 60000) {
      return 'Just now';
    } else if (diff < 3600000) {
      return '${(diff / 60000).floor()} minutes ago';
    } else if (diff < 86400000) {
      return '${(diff / 3600000).floor()} hours ago';
    } else {
      return '${(diff / 86400000).floor()} days ago';
    }
  }
}
