import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reabilita_social/presentation/theme__manager.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro_final.dart';
import 'package:reabilita_social/screens/auth/login.dart';
import 'package:reabilita_social/screens/home.dart';
import 'package:reabilita_social/services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService().initSupabase();

  // await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      // locale: const Locale('pt', 'BR'),
      // supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        '/': (context) => const LoginScreen(),
        '/menuPrincipal': (context) => const HomeScreen(),
        '/cadastro': (context) =>  const CadastroScreen(),
        '/cadastroFinal': (context) =>  const CadastroFinalScreen(),
      },
      initialRoute: '/',
    );
  }
}
