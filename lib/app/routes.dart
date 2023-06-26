import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'feature/anamnese/anamnese_end_page.dart';
import 'feature/anamnese/anamnese_interview_page.dart';
import 'feature/anamnese/anamnese_questions/anamnese_questions_page.dart';
import 'feature/anamnese/anamnese_start_page.dart';
import 'feature/error/error_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigator =
//     GlobalKey(debugLabel: 'shell');

final goRouterProv = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: _rootNavigator,
      debugLogDiagnostics: true,
      initialLocation: AppPage.anamneseStart.path,
      routes: [
        GoRoute(
          path: AppPage.anamneseStart.path,
          name: AppPage.anamneseStart.name,
          builder: (context, state) {
            return AnamneseStartPage(
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: AppPage.anamneseInterview.path,
              name: AppPage.anamneseInterview.name,
              builder: (context, state) {
                return AnamneseInterviewPage(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.anamneseQuestions.path,
              name: AppPage.anamneseQuestions.name,
              builder: (context, state) {
                return AnamneseQuestionsPage(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.anamneseEnd.path,
              name: AppPage.anamneseEnd.name,
              builder: (context, state) {
                return AnamneseEndPage(
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(
        key: state.pageKey,
        errorMsg: state.error.toString(),
      ),
    );
  },
);

/*
rotas

*/

enum AppPage {
  anamneseStart('/', '/'),
  anamneseInterview('anamneseInterview', 'anamneseInterview'),
  anamneseQuestions('anamneseQuestions', 'anamneseQuestions'),
  anamneseEnd('anamneseEnd', 'anamneseEnd');

  final String path;
  final String name;
  const AppPage(this.path, this.name);
}
