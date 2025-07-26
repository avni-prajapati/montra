import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/modules/force_update/cubit/force_update_cubit.dart';
import 'package:montra_clone/modules/force_update/services/firebase_remote_config_service.dart';
import 'package:montra_clone/modules/force_update/services/helper.dart';
import 'package:montra_clone/modules/force_update/services/package_info_services.dart';
import 'package:montra_clone/modules/force_update/update_alert_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SplashScreen extends StatefulWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => ForceUpdateCubit(), child: this);
    // return BlocProvider(create: (context) => ForceUpdateCubit()..fetchMinimumVersionRequired(), child: this);
  }
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  bool shouldShowText = false;
  final remoteConfig = FirebaseRemoteConfigService();
  final packageInfo = PackageInfoServices.instance;

  Future<void> _showUpdateDialogue(
      {required BuildContext dialogueContext,
      required bool isUpdateRequired}) async {
    return showDialog(
      barrierDismissible: false,
      context: dialogueContext,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: UpdateAlertDialogue(
            contextToPop: context,
            isUpdateRequired: isUpdateRequired,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) {
        fetchVersion();
      },
    );
    setAnimation();
  }

  Future<void> fetchVersion() async {
    await context.read<ForceUpdateCubit>().fetchMinimumVersionRequired();
    handleForceUpdateDialogue();
  }

  void handleForceUpdateDialogue() {
    final version =
        context.read<ForceUpdateCubit>().state.requiredMinimumVersion;
    final versionOnDevice = getVersionNumberInInteger(packageInfo.version);
    final requiredMinimumVersion = getVersionNumberInInteger(version);
    if (versionOnDevice.major < requiredMinimumVersion.major) {
      _showUpdateDialogue(
        dialogueContext: context,
        isUpdateRequired: true,
      );
    } else if (versionOnDevice.minor < requiredMinimumVersion.minor) {
      _showUpdateDialogue(
        dialogueContext: context,
        isUpdateRequired: false,
      );
    } else {
      navigateToAppropriateRoute();
    }
  }

  void setAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1.5,
    ).animate(animationController);
    animationController.forward().then(
      (_) {
        setState(() {
          shouldShowText = true;
        });
        Future.delayed(const Duration(seconds: 2));
      },
    );
  }

  Future<void> navigateToAppropriateRoute() async {
    await Future.delayed(const Duration(seconds: 4));
    final prefs = await SharedPreferences.getInstance();
    bool isOpenedFirstTime = prefs.getBool('isOpenedFirstTime') ?? true;
    if (isOpenedFirstTime) {
      prefs.setBool('isOpenedFirstTime', false);
      if (mounted) {
        context.router.replace(const OnboardingRoute());
      }
    } else {
      if (mounted) {
        context.router.replace(const BottomNavigationBarRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.violet80,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.scale(
                scale: animation.value,
                child: Image.asset(
                  appIcon,
                  height: 100,
                ),
              ),
            ),
          ),
          if (shouldShowText)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Montra',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: AppColors.instance.light100,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
