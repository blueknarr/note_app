import 'package:flutter/material.dart';
import 'package:note_app/presentation/notes/notes_screen.dart';
import 'package:note_app/ui/colors.dart';
import 'package:provider/provider.dart';

import 'di/provider_setup.dart';

void main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장
  // 연결이 다 되는 것을 보장하게 해주는 코드
  // 화면을 그리기 이전에 세팅하는 과정들을 보장하고 화면을 그린다.
  // 카메라 세팅 라이브러리, 초기 future로 해야한다.
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await getProviders();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: darkGray,
        floatingActionButtonTheme:
            Theme.of(context).floatingActionButtonTheme.copyWith(
                  backgroundColor: lightBlue,
                  foregroundColor: darkGray,
                ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: darkGray,
            ),
      ),
      home: const NotesScreen(),
    );
  }
}
