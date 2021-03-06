import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/prodModel/brands_notifier.dart';
import 'package:mollet/prodModel/cart_notifier.dart';
import 'package:mollet/prodModel/products_notifier.dart';
import 'package:mollet/screens/getstarted_screens/intro_screen.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/home_screens/settings.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/reset_screen.dart';
import 'package:mollet/screens/register_screens/verification_screen.dart';
import 'package:mollet/screens/settings_screens/cards.dart';
import 'package:mollet/screens/settings_screens/changePassword.dart';
import 'package:mollet/screens/settings_screens/editProfile.dart';
import 'package:mollet/screens/settings_screens/inviteFriend.dart';
import 'package:mollet/screens/settings_screens/passwordSecurity.dart';
import 'package:mollet/screens/splash_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:mollet/widgets/tabsLayout.dart';
import 'package:provider/provider.dart';

// import 'model/services/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

final routes = {
  '/Registration': (BuildContext context) => RegistrationScreen(),
  '/Homescreen': (BuildContext context) => HomeScreen(),
  '/Verification': (BuildContext context) => VerificationScreen(),
  '/Login': (BuildContext context) => LoginScreen(),
  '/Reset': (BuildContext context) => ResetScreen(),
  '/home': (BuildContext context) => HomeController(),
  '/EditProfile': (BuildContext context) => EditProfile(),
  '/Settings': (BuildContext context) => SettingsScreen(),
  '/Security': (BuildContext context) => SecurityScreen(),
  '/ChangePassword': (BuildContext context) => ChangePasswordScreen(),
  '/Cards': (BuildContext context) => Cards(),
  '/InviteFriend': (BuildContext context) => InviteFriendScreen(),
  '/MyTabs': (BuildContext context) => TabsLayout(),
};

class HomeController extends StatefulWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      auth: AuthService(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: HomeController(),
      ),
    );
  }
}

class _HomeControllerState extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;

    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return MaterialApp(
              title: "Pet Shop",
              theme: ThemeData(
                accentColor: MColors.primaryPurple,
                primaryColor: MColors.primaryPurple,
              ),
              debugShowCheckedModeBanner: false,
              home: signedIn
                  ? MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => ProductsNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => BrandsNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => CartNotifier(),
                        ),
                      ],
                      child: TabsLayout(),
                    )
                  : IntroScreen(),
            );
          }
          return SplashScreen();
        });
  }
}
