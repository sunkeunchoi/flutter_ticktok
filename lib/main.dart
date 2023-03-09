import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ticktoc/common/widgets/video_configuration/video_configuration.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:provider/provider.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoConfiguration>(
          create: (context) => VideoConfiguration(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size02,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.black,
          ),
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
            selectionColor: Color(0xFFE9435A),
          ),
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent
        ),
      ),
    );
  }
}
