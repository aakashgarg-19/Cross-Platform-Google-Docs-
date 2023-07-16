import 'package:docs_clone_flutter/models/error_model.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  // ProviderScope, Enabled Riverpod for the entire application
  runApp(const ProviderScope(child: MyApp()));
}

// ConsumerStatefulWidget is a StatefulWidget that uses Riverpod
// This widget is the root of the application
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  // _MyAppState is the state of the MyApp widget
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // initState is called when the widget is first created
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  ErrorModel? errorModel;

  // getUserData is a function that gets the user data from the auth repository
  void getUserData() async {
    // ref is a property of ConsumerState that allows us to access Riverpod
    errorModel = await ref.read(authRepositoryProvider).getUserData();
    // If User is logged in, update the userProvider
    if (errorModel != null && errorModel!.data != null) {
      // Update the userProvider with the user data
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Docs Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // RoutemasterDelegate is a delegate that handles separate routes for logged in and logged out users
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        // Get the user from the userProvider
        final user = ref.watch(userProvider); 
        if (user != null && user.token.isNotEmpty) {
          return loggedInRoute;
        } else {
          return loggedOutRoute;
        }
      }),
      // RoutemasterParser is a parser that parses the route
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
