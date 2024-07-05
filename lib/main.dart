// ignore_for_file: prefer_const_declarations

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rexparts/controller/admin_controller.dart';
import 'package:rexparts/controller/bottom_provider.dart';
import 'package:rexparts/controller/carsoul_provider.dart';
import 'package:rexparts/controller/cart_provider.dart';
import 'package:rexparts/controller/chat_provider.dart';
import 'package:rexparts/controller/favoutare_provider.dart';
import 'package:rexparts/controller/login_provider.dart';
import 'package:rexparts/controller/noti_provider.dart';
import 'package:rexparts/controller/order_provider.dart';
import 'package:rexparts/controller/payment_provider.dart';
import 'package:rexparts/controller/product_details_provider.dart';
import 'package:rexparts/controller/user_controller.dart';
import 'package:rexparts/firebase_options.dart';
import 'package:rexparts/service/noti_service.dart';
import 'package:rexparts/view/Admin/add_product.dart';
import 'package:rexparts/view/notification/notification.dart';
import 'package:rexparts/view/splash_screen/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseApiService().initNotifications();
  await NotificationService().initNotification();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {},
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Razorpay razorpay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CaroselProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoutareProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
        routes: {
          '/notification_screen': (context) => const NotificationScreen(),
          '/add_product': (context) => const AddProductPage(),
        },
      ),
    );
  }
}
