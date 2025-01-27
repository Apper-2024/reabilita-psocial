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
import 'package:reabilita_social/screens/Mapa.dart';
import 'package:reabilita_social/screens/administrador/adicionarUsuario.dart';
import 'package:reabilita_social/screens/administrador/detalheAdministrador.dart';
import 'package:reabilita_social/screens/administrador/homeAdministrador.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro.dart';
import 'package:reabilita_social/screens/auth/cadastros/cadastro_final.dart';
import 'package:reabilita_social/screens/auth/login.dart';
import 'package:reabilita_social/screens/auth/login_primeiro_acesso.dart';
import 'package:reabilita_social/screens/profissional/agradecimento.dart';
import 'package:reabilita_social/screens/profissional/cadastro_projeto.dart';
import 'package:reabilita_social/screens/profissional/desenvolvedores.dart';
import 'package:reabilita_social/screens/profissional/edita_perfil_prof.dart';
import 'package:reabilita_social/screens/profissional/evolucao_paciente.dart';
import 'package:reabilita_social/screens/profissional/informacao_tecnica.dart';
import 'package:reabilita_social/screens/profissional/paciente.dart';
import 'package:reabilita_social/screens/profissional/pagina_espera.dart';
import 'package:reabilita_social/screens/profissional/recursos.dart';
import 'package:reabilita_social/screens/profissional/pesquisa_usuario.dart';
import 'package:reabilita_social/screens/profissional/projetos.dart';
import 'package:reabilita_social/screens/profissional/referencias.dart';
import 'package:reabilita_social/screens/profissional/registroProdutividade.dart';
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
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        //GERAL
        '/': (context) => const VerificaConta(),
        '/login': (context) => const LoginScreen(),
        '/PesquisaMapa': (context) => const SearchPage(),
        '/cadastro': (context) => const CadastroScreen(),
        '/loginPrimeiroAcesso': (context) => const LoginPrimeiroAcesso(),
        '/cadastroFinal': (context) => const CadastroFinalScreen(),

        //ADMINISTRADOR
        '/usuariosAdministrador': (context) => const RouteGuard(child: ProfissionaisPage()),
        '/adicionarAdministrador': (context) => const RouteGuard(child: AddUserPage()),
        '/detaheAdministrador': (context) => const RouteGuard(child: DetalheAdministrador()),
        '/homeAdministrador': (context) => const RouteGuard(child: ProfissionaisPage()),
        '/Menu': (context) => const RouteGuard(child: ProfissionaisPage()),

        //PROFISSIONAL
        '/cadastroProjeto': (context) => const RouteGuard(child: CadastroProjetoScreen()),
        '/telaPaciente': (context) => const RouteGuard(child: PacienteScreen()),
        //'/detalhePaciente': (context) => RouteGuard(child:  DetalhesPaciente()),
        '/menuProfissional': (context) => const RouteGuard(child: BottomMenuProfissional()),
        '/recursosProfissional': (context) => const RouteGuard(child: RecursosScreen()),
        '/evolucaoPaciente': (context) => const RouteGuard(child: EvolucaoPacientePage()),
        '/editarPerfil': (context) => const RouteGuard(child: EditaPerfilProf()),
        '/suporteUsuario': (context) => const RouteGuard(child: SuporteUsuario()),
        '/pesquisaUsuario': (context) => const RouteGuard(child: PesquisaUsuarioScreen()),
        '/projetoScreen': (context) => const RouteGuard(child: ProjetosScreen()),
        '/referenciasTela': (context) => const RouteGuard(child: ReferenciasPage()),
        '/paginaEspera': (context) => const RouteGuard(child: PaginaEsperaScreen()),
        '/informacaoTecnica': (context) => const RouteGuard(child: InformacaoTecnica()),
        '/desenvolvedores': (context) => const RouteGuard(child: Desenvolvedores()),
        '/agradecimentos': (context) => const RouteGuard(child: Agradecimentos()),
        '/registroProdutividade': (context) => const RouteGuard(child: RegistroProdutividade()),
        //PACIENTE
      },
    );
  }
}
