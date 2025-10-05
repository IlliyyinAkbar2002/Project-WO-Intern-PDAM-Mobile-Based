import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_intern_pdam/config/theme/app_theme.dart';
import 'package:mobile_intern_pdam/core/utils/app_snackbar.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/bloc/work_order_bloc.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/login.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(); // ✅ Muat API Key dari file .env
    await di.init();
    print("🎉 Dependency berhasil diinisialisasi!");
  } catch (e, stacktrace) {
    print("❌ Gagal menginisialisasi dependency: $e");
    print(stacktrace);
  }

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AppStatePage<App> {
  @override
  Widget buildPage(BuildContext context) {
    AppSnackbar.setTheme(ThemeManager.theme);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<WorkOrderBloc>())],
      child: MaterialApp(
        theme: ThemeManager.theme,
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
