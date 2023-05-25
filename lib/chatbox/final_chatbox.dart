
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety_app/chatbox/providers/chats_provider.dart';
import 'package:women_safety_app/chatbox/providers/models_provider.dart';

import 'constants/constants.dart';
import 'package:women_safety_app/chatbox/screens/chatbox.dart';

class MyChatBox extends StatelessWidget {
  const MyChatBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ChatBOT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              color: cardColor,
            )),
        home:  ChatBot(),
      ),
    );
  }
}
