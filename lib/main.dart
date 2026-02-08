
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_theme.dart';
// import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';
// import 'package:flutter_pinku_app/presentation/auth/pages/signup.dart';
// import 'package:flutter_pinku_app/presentation/auth/pages/signin.dart';
import 'package:flutter_pinku_app/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_pinku_app/presentation/splash/pages/splash.dart';
import 'package:flutter_pinku_app/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );

  await initializeDependencies();

  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit,ThemeMode>(
        builder: (context, mode) => MaterialApp(
          //title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home:  const SplashPage(),
          // routes: {
          //   '/signup_or_signin': (context) => const SignupOrSignin(),
          //   '/signup': (context) => const SignupPage(),
          //   '/signin': (context) => const SigninPage(),
          // },
        ),
      ),
    );
  }
}

