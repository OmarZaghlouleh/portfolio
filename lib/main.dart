import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:portfolio/Data%20Managers/api_manager.dart';
import 'package:portfolio/Data%20Managers/routes_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Data%20Managers/theme_manager.dart';
import 'package:portfolio/View%20Models/home_view_model.dart';
import 'package:portfolio/View%20Models/splash_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = APIManager.applicationId;
  const keyClientKey = APIManager.clientKey;
  const keyParseServerUrl = APIManager.baseUrl;

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel())
      ],
      child: MaterialApp(
        title: AppStrings.title,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splash,
        onGenerateRoute: RoutesGenerator.getRoute,
        theme: ThemeManager.getLightTheme(),
      ),
    );
  }
}
