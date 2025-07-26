import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra_clone/app/routes/router/router.dart';
import 'package:montra_clone/app_ui/theme/responsive_theme.dart';
import 'package:montra_clone/app_ui/theme/theme_bloc.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/firebase_options.dart';
import 'package:montra_clone/modules/force_update/services/firebase_remote_config_service.dart';
import 'package:montra_clone/modules/force_update/services/package_info_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'Updated');
  await PackageInfoServices.instance.initialize();
  await FirebaseRemoteConfigService().initialize();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppResponsiveTheme(
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, AppThemeColorMode>(
          builder: (BuildContext context, AppThemeColorMode themeMode) {
            return RepositoryProvider(
              create: (context) => AuthenticationRepository(),
              child: MaterialApp.router(
                routerConfig: _router.config(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: GoogleFonts.inter().fontFamily,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
