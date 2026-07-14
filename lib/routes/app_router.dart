import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/admirers/presentation/pages/admirers_page.dart';
import '../features/chat/presentation/pages/chat_detail_page.dart';
import '../features/chat/presentation/pages/chat_list_page.dart';
import '../features/date_now/presentation/pages/date_now_page.dart';
import '../features/events/presentation/pages/events_page.dart';
import '../features/filters/presentation/pages/filters_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/menu/presentation/pages/menu_drawer_page.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => _fadeTransition(
        state,
        const HomePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.dateNow,
      pageBuilder: (context, state) => _fadeTransition(
        state,
        const DateNowPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.admirers,
      pageBuilder: (context, state) => _fadeTransition(
        state,
        const AdmirersPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chatList,
      pageBuilder: (context, state) => _fadeTransition(
        state,
        const ChatListPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chatDetail,
      pageBuilder: (context, state) => _slideTransition(
        state,
        ChatDetailPage(chatData: state.extra as Map<String, dynamic>?),
      ),
    ),
    GoRoute(
      path: AppRoutes.events,
      pageBuilder: (context, state) => _fadeTransition(
        state,
        const EventsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.filters,
      pageBuilder: (context, state) => _slideTransition(
        state,
        const FiltersPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      pageBuilder: (context, state) => _slideTransition(
        state,
        const NotificationsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.menu,
      pageBuilder: (context, state) => _drawerTransition(
        state,
        const MenuDrawerPage(),
      ),
    ),
  ],
);

CustomTransitionPage<T> _fadeTransition<T>(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

CustomTransitionPage<T> _slideTransition<T>(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

CustomTransitionPage<T> _drawerTransition<T>(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
