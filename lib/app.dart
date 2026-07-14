import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/bloc/home_feed_bloc.dart';
import 'features/home/presentation/bloc/home_feed_event.dart';
import 'routes/app_router.dart';

class DatingApp extends StatelessWidget {
  const DatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeFeedBloc>(
          create: (_) => sl<HomeFeedBloc>()..add(const FetchHomeFeed()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Spark — Dating App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter,
      ),
    );
  }
}
