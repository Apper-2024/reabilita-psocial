import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/firebase_options.dart';
import 'package:reabilita_social/presentation/theme__manager.dart';
import 'package:reabilita_social/provider/administrador_provider.dart';
import 'package:reabilita_social/provider/imagem_provider.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/screens/administrador/homeAdministrador.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro_final.dart';
import 'package:reabilita_social/screens/auth/login.dart';
import 'package:reabilita_social/screens/auth/login_primeiro_acesso.dart';
import 'package:reabilita_social/screens/profissional/cadastro_projeto.dart';
import 'package:reabilita_social/screens/profissional/evolucao_paciente.dart';
import 'package:reabilita_social/screens/profissional/paciente.dart';
import 'package:reabilita_social/verifica_conta.dart';
import 'package:reabilita_social/widgets/bottomMenu/botom_menu_profissional.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

//  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProfissionalProvider.instance),
        ChangeNotifierProvider.value(value: AdministradorProvider.instance),
        ChangeNotifierProvider.value(value: PacienteProvider.instance),
        ChangeNotifierProvider.value(value: ImageProviderCustom.instance),
      ],
      child: const MyApp(),
    ),
  );
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

      initialRoute: '/',
      routes: {
        //GERAL
        '/': (context) => const VerificaConta(),
        '/login': (context) => const LoginScreen(),

        //ADMINISTRADOR
        '/usuariosAdministrador': (context) => const ProfissionaisPage(),

        //PROFISSIONAL
        '/cadastroProjeto': (context) => const CadastroProjetoScreen(),
        '/telaPaciente': (context) => const PacienteScreen(),
        '/menuProfissional': (context) => const BottomMenuProfissional(),
        '/cadastro': (context) => const CadastroScreen(),
        '/cadastroFinal': (context) => const CadastroFinalScreen(),
        '/loginPrimeiroAcesso': (context) => const LoginPrimeiroAcesso(),
        '/evolucaoPaciente': (context) => const EvolucaoPacientePage(),
        //PACIENTE
      },
    );
  }
}
