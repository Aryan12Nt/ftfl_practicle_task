import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// ─── State ───────────────────────────────────────────────────────────────────

class FiltersState extends Equatable {
  final RangeValues ageRange;
  final double maxDistance;
  final bool onlineOnly;
  final List<String> selectedIntents;
  final String gender;

  const FiltersState({
    this.ageRange = const RangeValues(20, 40),
    this.maxDistance = 25,
    this.onlineOnly = false,
    this.selectedIntents = const [],
    this.gender = 'Any',
  });

  FiltersState copyWith({
    RangeValues? ageRange,
    double? maxDistance,
    bool? onlineOnly,
    List<String>? selectedIntents,
    String? gender,
  }) {
    return FiltersState(
      ageRange: ageRange ?? this.ageRange,
      maxDistance: maxDistance ?? this.maxDistance,
      onlineOnly: onlineOnly ?? this.onlineOnly,
      selectedIntents: selectedIntents ?? this.selectedIntents,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props =>
      [ageRange, maxDistance, onlineOnly, selectedIntents, gender];
}

// ─── Cubit ───────────────────────────────────────────────────────────────────

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(const FiltersState());

  void setAgeRange(RangeValues v) => emit(state.copyWith(ageRange: v));
  void setMaxDistance(double v) => emit(state.copyWith(maxDistance: v));
  void setOnlineOnly(bool v) => emit(state.copyWith(onlineOnly: v));
  void setGender(String v) => emit(state.copyWith(gender: v));

  void toggleIntent(String intent) {
    final list = List<String>.from(state.selectedIntents);
    if (list.contains(intent)) {
      list.remove(intent);
    } else {
      list.add(intent);
    }
    emit(state.copyWith(selectedIntents: list));
  }

  void reset() => emit(const FiltersState());
}

// ─── Page ────────────────────────────────────────────────────────────────────

const List<String> _intents = [
  'Serious relationship',
  'Casual dating',
  'Friendship first',
  'Long-term',
  'Open to anything',
  'Marriage minded',
];

const List<String> _genders = ['Any', 'Women', 'Men', 'Non-binary'];

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiltersCubit(),
      child: const _FiltersView(),
    );
  }
}

class _FiltersView extends StatelessWidget {
  const _FiltersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Filters', style: AppTextStyles.sectionTitle),
        actions: [
          TextButton(
            onPressed: () => context.read<FiltersCubit>().reset(),
            child: Text(
              'Reset',
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FiltersCubit, FiltersState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Age Range
                _FilterSection(
                  title: 'Age Range',
                  trailing:
                      '${state.ageRange.start.round()} – ${state.ageRange.end.round()} yrs',
                  child: RangeSlider(
                    values: state.ageRange,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    onChanged: (v) =>
                        context.read<FiltersCubit>().setAgeRange(v),
                  ),
                ),

                const _Divider(),

                // Distance
                _FilterSection(
                  title: 'Max Distance',
                  trailing: '${state.maxDistance.round()} km',
                  child: Slider(
                    value: state.maxDistance,
                    min: 1,
                    max: 100,
                    divisions: 99,
                    onChanged: (v) =>
                        context.read<FiltersCubit>().setMaxDistance(v),
                  ),
                ),

                const _Divider(),

                // Online Only
                _FilterRow(
                  title: 'Online only',
                  subtitle: 'Show only users who are currently active',
                  trailing: Switch(
                    value: state.onlineOnly,
                    onChanged: (v) =>
                        context.read<FiltersCubit>().setOnlineOnly(v),
                  ),
                ),

                const _Divider(),

                // Gender
                _FilterSection(
                  title: 'Show me',
                  child: Wrap(
                    spacing: 8,
                    children: _genders.map((g) {
                      final selected = state.gender == g;
                      return FilterChip(
                        label: Text(g),
                        selected: selected,
                        onSelected: (_) =>
                            context.read<FiltersCubit>().setGender(g),
                        labelStyle: AppTextStyles.filterValue.copyWith(
                          color: selected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const _Divider(),

                // Relationship Intent
                _FilterSection(
                  title: 'Looking for',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _intents.map((intent) {
                      final selected = state.selectedIntents.contains(intent);
                      return FilterChip(
                        label: Text(intent),
                        selected: selected,
                        onSelected: (_) =>
                            context.read<FiltersCubit>().toggleIntent(intent),
                        labelStyle: AppTextStyles.filterValue.copyWith(
                          color: selected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 32),

                // Apply button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Apply Filters'),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget child;

  const _FilterSection(
      {required this.title, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.filterLabel),
            if (trailing != null)
              Text(trailing!,
                  style: AppTextStyles.filterValue
                      .copyWith(color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget trailing;

  const _FilterRow(
      {required this.title, this.subtitle, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.filterLabel),
              if (subtitle != null)
                Text(subtitle!, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: AppColors.divider, height: 1),
    );
  }
}
