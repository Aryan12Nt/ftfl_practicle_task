import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';
import '../bloc/home_feed_bloc.dart';
import '../bloc/home_feed_event.dart';
import '../bloc/home_feed_state.dart';
import '../widgets/home_profile_details.dart';
import '../widgets/home_shimmer_card.dart';
import '../widgets/profile_swipe_card.dart';
import '../widgets/rose_compliment_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppTopBar(
        onMenuTap: () => context.push(AppRoutes.menu),
        onFilterTap: () => context.push(AppRoutes.filters),
        onBellTap: () => context.push(AppRoutes.notifications),
        onLightningTap: () {},
        dailyCount: 25,
        hasUnread: true,
      ),
      body: BlocBuilder<HomeFeedBloc, HomeFeedState>(
        builder: (context, state) {
          if (state is HomeFeedLoading || state is HomeFeedInitial) {
            return _LoadingView();
          }
          if (state is HomeFeedError) {
            return _ErrorView(
              state: state,
              onRetry: () =>
                  context.read<HomeFeedBloc>().add(const FetchHomeFeed()),
            );
          }
          if (state is HomeFeedEmpty) {
            return _EmptyView(
              onRefresh: () =>
                  context.read<HomeFeedBloc>().add(const RefreshHomeFeed()),
            );
          }
          if (state is HomeFeedLoaded) {
            return _LoadedView(state: state);
          }
          return _LoadingView();
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: NavTab.home,
        onTabSelected: (tab) => _navigateToTab(context, tab),
      ),
    );
  }

  void _navigateToTab(BuildContext context, NavTab tab) {
    switch (tab) {
      case NavTab.home:
        break;
      case NavTab.dateNow:
        context.go(AppRoutes.dateNow);
        break;
      case NavTab.admirers:
        context.go(AppRoutes.admirers);
        break;
      case NavTab.chat:
        context.go(AppRoutes.chatList);
        break;
      case NavTab.events:
        context.go(AppRoutes.events);
        break;
    }
  }
}

// ─── Loading ─────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: AppSpacing.lg),
          HomeShimmerCard(),
        ],
      ),
    );
  }
}

// ─── Loaded ──────────────────────────────────────────────────────────────────

class _LoadedView extends StatefulWidget {
  final HomeFeedLoaded state;
  const _LoadedView({required this.state});

  @override
  State<_LoadedView> createState() => _LoadedViewState();
}

class _LoadedViewState extends State<_LoadedView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fabCtrl;
  late Animation<double> _fabScale;
  bool _fabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fabCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _fabScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabCtrl, curve: Curves.elasticOut),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final shouldShow = _scrollController.offset > 300.0;
    if (shouldShow != _fabVisible) {
      setState(() => _fabVisible = shouldShow);
      if (shouldShow) {
        _fabCtrl.forward();
      } else {
        _fabCtrl.reverse();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.state.currentUser;
    if (user == null) return _EmptyView(onRefresh: () {});

    final screenH = MediaQuery.sizeOf(context).height;
    final safePadding = MediaQuery.paddingOf(context);
    final topBarH = 56.0;
    final bottomNavH = 60.0;
    // Calculate full available height for the hero card (top gap is AppSpacing.xs, bottom gap is 0)
    final cardHeight = screenH -
        safePadding.top -
        safePadding.bottom -
        topBarH -
        bottomNavH -
        AppSpacing.xs;

    return Stack(
      children: [
        // Scrollable Feed
        RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.cardBackground,
          onRefresh: () async {
            context.read<HomeFeedBloc>().add(const RefreshHomeFeed());
            await Future.delayed(const Duration(milliseconds: 800));
          },
          child: CustomScrollView(
            key: ValueKey(user.id),
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Top card
                        ProfileSwipeCard(
                          user: user,
                          isVerified: widget.state.currentIndex == 0,
                          onSwipeLeft: () => context.read<HomeFeedBloc>().add(
                              SwipeCard(
                                  index: widget.state.currentIndex,
                                  isLike: false)),
                          onSwipeRight: () => context.read<HomeFeedBloc>().add(
                              SwipeCard(
                                  index: widget.state.currentIndex,
                                  isLike: true)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: HomeProfileDetails(user: user),
              ),
            ],
          ),
        ),

        // Floating Rose FAB
        Positioned(
          bottom: 32,
          right: 24,
          child: ScaleTransition(
            scale: _fabScale,
            child: GestureDetector(
              onTap: () => showRoseComplimentSheet(context),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: const Center(
                  child: Text('🌹', style: TextStyle(fontSize: 26)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Error ───────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final HomeFeedError state;
  final VoidCallback onRetry;

  const _ErrorView({required this.state, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.isNetwork
                  ? Icons.wifi_off_outlined
                  : state.isTimeout
                      ? Icons.timer_off_outlined
                      : Icons.error_outline,
              size: 64,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              state.isNetwork
                  ? 'No Internet Connection'
                  : state.isTimeout
                      ? 'Request Timed Out'
                      : 'Something Went Wrong',
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              state.message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty ───────────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  final VoidCallback onRefresh;
  const _EmptyView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.people_outline,
                size: 50,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              "You've seen everyone!",
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Check back later or load a new batch to discover more people.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Load More'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
