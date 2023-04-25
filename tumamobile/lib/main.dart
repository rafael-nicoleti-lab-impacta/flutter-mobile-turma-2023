import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumamobile/view/screens/home_screen.dart';
import 'package:tumamobile/view_model/media_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MediaViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media List',
        theme: ThemeData(
          appBarTheme: AppBarTheme(),
          primarySwatch: Colors.blue,
          accentColor: Colors.black45
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => HomeScreen(),
        },
      ),
    );
  }
}
