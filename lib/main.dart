import 'package:flutter/material.dart';
import 'dart:io'; // Add this import for Directory
import 'package:path/path.dart' as path; // Add this import for path operations
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:provider/provider.dart'; // Import provider package
import 'package:volufriend/core/utils/LocalStorageService.dart'; // Import your LocalStorageService
import 'package:volufriend/presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen3_eventadditionaldetails_screen/bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';
import 'package:volufriend/presentation/vf_homescreen_page/bloc/vf_homescreen_bloc.dart';
import 'package:volufriend/presentation/vf_homescreen_page/vf_homescreen_page.dart';
import 'package:volufriend/presentation/vf_notificationspage_screen/bloc/vf_notificationspage_bloc.dart';
import 'core/app_export.dart';
import 'firebase_options.dart'; // Ensure this file is created and configured
import '/crud_repository/volufriend_crud_repo.dart';
import 'core/utils/global.dart';
import '../crud/get_user/bloc/get_user_bloc.dart';
import '../crud/get_users/bloc/get_users_bloc.dart';
import '../crud/add_new_user/bloc/add_new_user_bloc.dart';
import '../crud/update_user/bloc/update_user_bloc.dart';
import '../crud/delete_user/bloc/delete_user_bloc.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';
import '../../presentation/vf_homescreen_container_screen/bloc/vf_homescreen_container_bloc.dart';
import '../../presentation/vf_createeventscreen1_eventdetails_screen/models/vf_createeventscreen1_eventdetails_model.dart';
import '../../presentation/vf_volunteerhomepage_screen/bloc/vf_volunteerhomepage_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '../../presentation/vf_homescreen_page/bloc/event_search_bloc.dart';
import '../../presentation/vf_homescreen_page/bloc/vf_lifecyclebloc.dart';
import '../../presentation/vf_eventlist_screen/bloc/vf_eventlist_bloc.dart';
import '../../presentation/vf_eventdetailspage_screen/models/vf_eventdetailspage_model.dart';
import '../../presentation/vf_eventdetailspage_screen/bloc/vf_eventdetailspage_bloc.dart';
import 'package:volufriend/core/utils/cause_cache_service.dart'; // Adjust path as needed

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

// Background handler for Firebase notifications
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure binding is initialized before using any Flutter widgets or services
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService localLocalStorageService;

  // Initialize Firebase if not already done
  await Firebase.initializeApp();

  print('Handling a background message: ${message.messageId}');

  final vflocalcrudService = VolufriendCrudService();
  try {
    await vflocalcrudService.saveNotification(message.data);
  } catch (e) {
    print('Error occurred while saving notification: $e');
  }
  ;
  /*
  // Initialize LocalStorageService with globalPrefs
  if (globalPrefs != null) {
    localLocalStorageService = LocalStorageService(prefs: globalPrefs!);
  } else {
    print('Error: globalPrefs is null. Cannot initialize LocalStorageService.');
    return; // Early return if globalPrefs is null
  }

  // Proceed with processing the notification
  if (message.data.isNotEmpty) {
    try {
      // Ensure localLocalStorageService is initialized (which it should be if globalPrefs is not null)
      print(
          'Global LocalStorageService is initialized. Saving notification...');

      // Convert the message data to NotificationModel
      NotificationModel notification = NotificationModel.fromJson(message.data);

      // Use the saveNotificationWithGlobalService method to save the notification
      await NotificationHandler.instance.saveNotificationWithGlobalService(
          message.data, localLocalStorageService);

      print(
          'Notification saved successfully as unread: ${notification.toJson()}');
    } catch (e) {
      print('Error occurred while saving notification: $e');
    }
  } else {
    print('No data found in the notification message.');
  }*/
}

void main() async {
  // Ensure binding is initialized before any async code
  WidgetsFlutterBinding.ensureInitialized();

  // Determine if the environment is production
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  print('isProduction: $isProduction');
/*
  // Try to load the correct .env file based on the environment
  try {
    final directory = Directory.current.path;
    print('Current directory: $directory');
    final envFileName = isProduction ? ".env.production" : ".env";
    print('envFileName: $envFileName');
    final envFilePath = path.join(directory, envFileName);
    print('envFilePath: $envFilePath');
    await dotenv.load(fileName: envFilePath);
    print('.env loaded: ' + dotenv.env['BASE_URL']!);
    // Load the correct .env file based on environment (dev or production)
    // await dotenv.load(fileName: isProduction ? ".env.production" : ".env");
    //print('.env loaded: ' + dotenv.env['BASE_URL']!);
  } catch (e) {
    print('Error loading .env file1: $e');
  }*/

  // Initialize global services within try-catch block
  try {
    await initGlobalServices();
  } catch (e) {
    print('Error initializing global services: $e');
  }

  // Try to initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Create the global instance of VolufriendCrudService
  final vfcrudService = VolufriendCrudService();

  // Register the background message handler for Firebase Messaging
  try {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print('Error registering Firebase background message handler: $e');
  }

  try {
    // Preload causes data into cache
    print('Preloading causes data into cache');
    final causeCacheService = CauseCacheService();
    await causeCacheService.getCauses();
  } catch (e) {
    print('Error preloading causes data: $e');
  }

  // Run the Flutter app with the initialized services
  runApp(MyApp(
    vfcrudService: vfcrudService,
    localStorageService: globalLocalStorageService!,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.vfcrudService,
    required this.localStorageService,
  }) : super(key: key);

  final VolufriendCrudService vfcrudService;
  final LocalStorageService localStorageService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalStorageService>.value(value: localStorageService),
        RepositoryProvider.value(value: vfcrudService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc(vfcrudService: vfcrudService)),
          BlocProvider(
            create: (context) => LifecycleBloc(
              vfcurdService: vfcrudService,
              localStorageService: localStorageService,
              userId: '', // Initial userId is empty, will be updated later
            ),
          ),
          BlocProvider(
            create: (context) => VfNotificationspageBloc(
              vfcurdService: vfcrudService,
              initialState: NotificationsInitial(),
              localStorageService: localStorageService,
            ),
          ),
          BlocProvider(create: (_) => orgVoluEventBloc()),
          BlocProvider(create: (_) => UserBloc(vfcrudService: vfcrudService)),
          BlocProvider(
              create: (_) => GetUserBloc(vfcrudService: vfcrudService)),
          BlocProvider(
              create: (_) => AddNewUserBloc(vfcrudService: vfcrudService)),
          BlocProvider(
              create: (_) =>
                  GetUsersBloc(vfcrudService: vfcrudService)..add(GetUsers())),
          BlocProvider(
              create: (_) => UpdateUserBloc(vfcrudService: vfcrudService)),
          BlocProvider(
              create: (_) => DeleteUserBloc(vfcrudService: vfcrudService)),
          BlocProvider(create: (_) => AppNavigationBloc(AppNavigationState())),
          BlocProvider(
              create: (_) => VfHomescreenContainerBloc()
                ..add(VfHomescreenContainerInitialEvent())),
          BlocProvider(
              create: (_) => VfHomescreenBloc(vfcrudService: vfcrudService)),
          BlocProvider<VfCreateeventscreen1EventdetailsBloc>(
            create: (context) => VfCreateeventscreen1EventdetailsBloc(
              initialState: VfCreateeventscreen1EventdetailsState(
                vfCreateeventscreen1EventdetailsModelObj:
                    VfCreateeventscreen1EventdetailsModel(),
              ),
              vfcrudService: vfcrudService,
            ),
          ),
          BlocProvider<VfCreateeventscreen2EventshiftsBloc>(
            create: (context) => VfCreateeventscreen2EventshiftsBloc(
                vfcrudService: vfcrudService),
          ),
          BlocProvider<VfCreateeventscreen3EventadditionaldetailsBloc>(
            create: (context) => VfCreateeventscreen3EventadditionaldetailsBloc(
                vfcrudService: vfcrudService),
          ),
          BlocProvider<VfVolunteerhomepageBloc>(
            create: (context) =>
                VfVolunteerhomepageBloc(vfcrudService: vfcrudService),
          ),
          BlocProvider<EventSearchBloc>(create: (context) => EventSearchBloc()),
          BlocProvider<EventListBloc>(
              create: (context) =>
                  EventListBloc(VfEventListScreenState(), vfcrudService)),
          BlocProvider<VfEventsdetailspageBloc>(
              create: (context) => VfEventsdetailspageBloc(
                    initialState: VfEventsdetailspageState(
                        vfEventdetailsModelObj:
                            const VfEventdetailspageModel()),
                    vfcrudService: vfcrudService,
                  )),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UserBloc, UserState>(
              listener: (context, userState) {
                if (userState is LoginUserWithHomeOrg) {
                  final userId =
                      userState.userId; // Get userId from logged-in state

                  // Update the LifecycleBloc with the new userId
                  final lifecycleBloc = BlocProvider.of<LifecycleBloc>(context);

                  // Check if userId has changed before updating
                  if (lifecycleBloc.userId != userId) {
                    lifecycleBloc.userId =
                        userId!; // Update userId in LifecycleBloc
                    if (userId.isNotEmpty) {
                      lifecycleBloc
                          .fetchAndStoreNotifications(); // Fetch notifications after login
                    }
                  }
                }
              },
            ),
            BlocListener<LifecycleBloc, AppLifecycleState>(
              listener: (context, lifecycleState) {
                if (lifecycleState == AppLifecycleState.resumed) {
                  // Fetch notifications when the app comes back to the foreground
                  final lifecycleBloc = BlocProvider.of<LifecycleBloc>(context);
                  lifecycleBloc
                      .fetchAndStoreNotifications(); // Fetch notifications
                }
              },
            ),
          ],
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return BlocProvider(
                create: (context) => ThemeBloc(
                  ThemeState(
                    themeType: PrefUtils().getThemeData(),
                  ),
                ),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    // Initialize Firebase Messaging
                    NotificationHandler.instance
                        .initFirebaseMessaging(context, localStorageService);

                    return MaterialApp(
                      theme: theme,
                      title: 'newvolufriend',
                      navigatorKey: NavigatorService.navigatorKey,
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: [
                        AppLocalizationDelegate(),
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [Locale('en', '')],
                      initialRoute: AppRoutes.initialRoute,
                      routes: AppRoutes.routes,
                      scaffoldMessengerKey:
                          globalMessengerKey, // Add this to show snackbars
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationHandler {
  NotificationHandler._();

  static final NotificationHandler instance = NotificationHandler._();

  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;

  bool _isInitialized = false;

  // Store the instance of LocalStorageService
  LocalStorageService? _localStorageService;

  // Initialize Firebase Messaging and pass LocalStorageService
  void initFirebaseMessaging(
      BuildContext context, LocalStorageService localStorageService) {
    print('initFirebaseMessaging');
    if (_isInitialized) {
      print("Firebase Messaging already initialized.");
      return; // Prevent re-initialization
    }

    _isInitialized = true; // Set the initialization flag
    _localStorageService = localStorageService; // Assign LocalStorageService

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Handle foreground notifications
    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a foreground notification: ${message.data}');
      if (message.notification != null) {
        // Use the same save method for both background and foreground
        print('handing foreground message and saving it');
        await saveNotification(message.data);
        // Show snackbar for the notification
        globalMessengerKey.currentState?.showSnackBar(
          SnackBar(
              content: Text(message.notification?.title ?? 'New Notification')),
        );
      }
    });

    // Handle notification taps (when app is opened from a notification)
    _onMessageOpenedAppSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A notification was opened from the background: ${message.data}');
      if (message.data['navigate'] == 'notification_center') {
        Navigator.pushNamed(context, '/notifications');
      }
    });
  }

  // Unified method to save notifications
  Future<void> saveNotification(Map<String, dynamic> notificationData) async {
    // Check if LocalStorageService is available
    if (notificationData != null && _localStorageService != null) {
      print('Notification data saving');
      NotificationModel notification =
          NotificationModel.fromJson(notificationData);

      // Use the provided LocalStorageService to save the notification
      await _localStorageService!
          .saveNotificationToPrefs(notification.toJson());
      print('Notification saved as unread: ${notification.toJson()}');
    } else {
      print('LocalStorageService is not available.');
    }
  }

/*  // You can add an overloaded saveNotification method that accepts the global instance directly
  Future<void> saveNotificationWithGlobalService(
      Map<String, dynamic> notificationData,
      LocalStorageService globalService) async {
    if (notificationData != null) {
      print('Notification data saving');
      NotificationModel notification =
          NotificationModel.fromJson(notificationData);

      // Use the passed globalService instance to save the notification
      await globalService.saveNotificationToPrefs(notification.toJson());
      print('Notification saved as unread: ${notification.toJson()}');
    } else {
      print('Notification data is null.');
    }
  }*/

  void dispose() {
    // Cancel listeners when no longer needed
    _onMessageSubscription?.cancel();
    _onMessageOpenedAppSubscription?.cancel();
    _isInitialized = false; // Reset the initialization flag
    print("NotificationHandler disposed.");
  }
}
