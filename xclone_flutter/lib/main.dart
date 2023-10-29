// ignore_for_file: unused_local_variable, prefer_const_constructors_in_immutables

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xclone_client/xclone_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:xclone_flutter/repositories/post_repository.dart';
import 'package:xclone_flutter/screens/feed_screen.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
   final postRepository = PostRepository(client: client);
  runApp( MyApp(postRepository:postRepository));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;
   MyApp({Key? key, required this.postRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // return MultiRepositoryProvider(
    //   providers: [RepositoryProvider.value(value: postRepository)],
    //   child: MultiBlocProvider(providers: [BlocProvider(create: )],
    //   child:  
    return  MaterialApp(
          title: 'X Clone with Flutter and Serverpod',
          theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFe3e2e6),
            ),
            colorScheme: SeedColorScheme.fromSeeds(
              brightness: Brightness.dark,
              primaryKey: const Color(0xFF4A98E9),
              secondaryKey: const Color(0xFF000000),
              tones: FlexTones.vivid(Brightness.dark),
            ),
            useMaterial3: true,
          ),
          initialRoute: '/feed',
          routes: {
            // '/': (context) => const OnboardingScreen(),
            '/feed': (context) => const FeedScreen(),
            // '/create': (context) => const CreatePostScreen(),
            // '/profile': (context) => const ProfileScreen(),
            // '/edit-profile': (context) => const EditProfileScreen(),
            // '/follow': (context) => const FollowScreen(),
          },
    //     ),
    //  )

      );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   // These fields hold the last result or error message that we've received from
//   // the server or null if no result exists yet.
//   String? _resultMessage;
//   String? _errorMessage;

//   final _textEditingController = TextEditingController();

//   // Calls the `hello` method of the `example` endpoint. Will set either the
//   // `_resultMessage` or `_errorMessage` field, depending on if the call
//   // is successful.
//   void _callHello() async {
//     try {
//       final result = await client.example.hello(_textEditingController.text);
//       setState(() {
//         _resultMessage = result;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = '$e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 controller: _textEditingController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter your name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: ElevatedButton(
//                 onPressed: _callHello,
//                 child: const Text('Send to Server'),
//               ),
//             ),
//             _ResultDisplay(
//               resultMessage: _resultMessage,
//               errorMessage: _errorMessage,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // _ResultDisplays shows the result of the call. Either the returned result from
// // the `example.hello` endpoint method or an error message.
// class _ResultDisplay extends StatelessWidget {
//   final String? resultMessage;
//   final String? errorMessage;

//   const _ResultDisplay({
//     this.resultMessage,
//     this.errorMessage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     String text;
//     Color backgroundColor;
//     if (errorMessage != null) {
//       backgroundColor = Colors.red[300]!;
//       text = errorMessage!;
//     } else if (resultMessage != null) {
//       backgroundColor = Colors.green[300]!;
//       text = resultMessage!;
//     } else {
//       backgroundColor = Colors.grey[300]!;
//       text = 'No server response yet.';
//     }

//     return Container(
//       height: 50,
//       color: backgroundColor,
//       child: Center(
//         child: Text(text),
//       ),
//     );
//   }
// }
