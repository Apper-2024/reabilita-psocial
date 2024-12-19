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
import 'package:reabilita_social/screens/administrador/adicionarUsuario.dart';
import 'package:reabilita_social/screens/administrador/detalheAdministrador.dart';
import 'package:reabilita_social/screens/administrador/homeAdministrador.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro_final.dart';
import 'package:reabilita_social/screens/auth/login.dart';
import 'package:reabilita_social/screens/auth/login_primeiro_acesso.dart';
import 'package:reabilita_social/screens/profissional/cadastro_projeto.dart';
import 'package:reabilita_social/screens/profissional/edita_perfil_prof.dart';
import 'package:reabilita_social/screens/profissional/evolucao_paciente.dart';
import 'package:reabilita_social/screens/profissional/paciente.dart';
import 'package:reabilita_social/screens/profissional/perfil.dart';
import 'package:reabilita_social/screens/profissional/pesquisa_usuario.dart';
import 'package:reabilita_social/screens/profissional/projetos.dart';
import 'package:reabilita_social/screens/profissional/referencias.dart';
import 'package:reabilita_social/screens/profissional/suporteUsuario.dart';
import 'package:reabilita_social/services/route_service.dart';
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
        '/usuariosAdministrador': (context) => RouteGuard(child: const ProfissionaisPage()),
        '/adicionarAdministrador': (context) => RouteGuard(child: const AddUserPage()),
        '/detaheAdministrador': (context) => RouteGuard(child: const DetalheAdministrador()),
        '/homeAdministrador': (context) => RouteGuard(child: const ProfissionaisPage()),
        '/Menu': (context) => RouteGuard(child: const ProfissionaisPage()),

        //PROFISSIONAL
        '/cadastroProjeto': (context) => RouteGuard(child: const CadastroProjetoScreen()),
        '/telaPaciente': (context) => RouteGuard(child: const PacienteScreen()),
        //'/detalhePaciente': (context) => RouteGuard(child:  DetalhesPaciente()),
        '/menuProfissional': (context) => RouteGuard(child: const BottomMenuProfissional()),
        '/perfilProfissional': (context) => RouteGuard(child: const PerfilScreen()),
        '/cadastro': (context) => RouteGuard(child: const CadastroScreen()),
        '/cadastroFinal': (context) => RouteGuard(child: const CadastroFinalScreen()),
        '/loginPrimeiroAcesso': (context) => RouteGuard(child: const LoginPrimeiroAcesso()),
        '/evolucaoPaciente': (context) => RouteGuard(child: const EvolucaoPacientePage()),
        '/editarPerfil': (context) => RouteGuard(child: const EditaPerfilProf()),
        '/suporteUsuario': (context) => RouteGuard(child:  SuporteUsuario()),
        '/pesquisaUsuario': (context) => RouteGuard(child:  PesquisaUsuarioScreen()),
        '/projetoScreen': (context) => RouteGuard(child:  ProjetosScreen()),
        '/referenciasTela': (context) => RouteGuard(child:  ReferenciasPage()),

        //PACIENTE
      },
    );
  }
}
