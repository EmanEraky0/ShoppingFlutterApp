import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/features/auth/login/domain/entities/user_entity.dart';
import 'package:shopping_flutter_app/features/cart/presentation/ViewModel/cart_viewmodel.dart';
import 'package:shopping_flutter_app/features/product_details/presentation/view/product_details.dart';
import 'package:shopping_flutter_app/features/home/domain/usecases/home_use_cases.dart';
import 'package:shopping_flutter_app/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:shopping_flutter_app/features/onboarding/view/onboarding_screen.dart';
import 'package:shopping_flutter_app/features/auth/login/presentation/viewmodel/login_viewmodel.dart';
import 'package:shopping_flutter_app/features/products/presentation/view/products_screen.dart';
import 'package:shopping_flutter_app/features/auth/signup/presentation/view/signup_screen.dart';
import 'core/network/local/local_storage.dart';
import 'core/services/notification_service.dart';
import 'features/cart/presentation/view/cart_screen.dart';
import 'features/category/presentation/view/category_screen.dart';
import 'features/favorite/presentation/view/favorite_screen.dart';
import 'features/favorite/presentation/viewmodel/favorite_view_model.dart';
import 'features/home/domain/entities/product_entity.dart';
import 'features/auth/login/presentation/view/login_screen.dart';
import 'features/main_screen/main_screen.dart';
import 'features/profile/presentation/view/profile_screen.dart';
import 'features/auth/signup/presentation/viewModel/signup_view_model.dart';
import 'features/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'injections.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
}

void main() async {
  setupDI();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Hive
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  // // Register adapters
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(ProductDataAdapter()); // 👈 from generated file

  // Initialize your local storage service
  final localStorage = getIt<LocalStorage>();
  await localStorage.init(); // 👈 MUST await before using

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true, // <— saves user choice automatically
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //

    return MultiProvider(
      providers: [
        // Inject AuthViewModel from get_it into Provider
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => getIt<LoginViewModel>()),
        ChangeNotifierProvider<SignupViewModel>(
            create: (_) => getIt<SignupViewModel>()),
        ChangeNotifierProvider<HomeViewModel>(
            create: (_) => getIt<HomeViewModel>()
              ..getAllProducts()
              ..loadFavorites()),
        // this will call once when the provider is built.
        ChangeNotifierProvider<CartViewModel>(
            create: (_) => CartViewModel(getIt<LocalStorage>())),
        ChangeNotifierProvider<FavoritesViewModel>(
            create: (_) =>
                FavoritesViewModel(getIt<LocalStorage>(), getIt<HomeUseCases>())
                  ..getAllProducts()),
      ],
      child: MaterialApp(
        navigatorKey: NotificationService.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: "GetIt + Provider Demo",
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onBoarding': (context) => const WaveIntroScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/main': (context) => MainScreen(),
          '/productsScreen': (context) => ProductsScreen(),
          '/categoryScreen': (context) => CategoryScreen(),
          '/favoriteScreen': (context) => FavoriteScreen(),
          '/cartScreen': (context) => CartScreen(),
          '/profileScreen': (context) => ProfileScreen(),
          '/details': (context) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
