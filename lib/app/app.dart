import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes.dart';
import 'theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouterProvIW = ref.watch(goRouterProv);
    return MaterialApp.router(
      routeInformationParser: goRouterProvIW.routeInformationParser,
      routeInformationProvider: goRouterProvIW.routeInformationProvider,
      routerDelegate: goRouterProvIW.routerDelegate,
      title: 'proKids - Anamnese',
      // theme: ThemeData.dark(useMaterial3: true),
      theme: AppTheme.theme01,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
