import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'branding_assets.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.selectedIndex = 0,
    super.key,
  }) : navigationShell = null;

  const AppShell.navigation({
    required StatefulNavigationShell shell,
    this.floatingActionButton,
    super.key,
  }) : title = 'EMControle',
       selectedIndex = 0,
       child = shell,
       navigationShell = shell;

  final String title;
  final int selectedIndex;
  final Widget child;
  final Widget? floatingActionButton;
  final StatefulNavigationShell? navigationShell;

  @override
  Widget build(BuildContext context) {
    final shell = navigationShell;
    final activeIndex = shell?.currentIndex ?? selectedIndex;

    return Scaffold(
      appBar: AppBar(title: const _AppHeader()),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(24), child: child),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: activeIndex,
        onDestinationSelected: (index) => _goToIndex(context, index, shell),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          final textStyle = Theme.of(context).textTheme.labelMedium;
          return textStyle?.copyWith(
            fontSize: 11,
            height: 1.05,
            leadingDistribution: TextLeadingDistribution.even,
          );
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Histórico',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Diário',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_timeline_outlined),
            selectedIcon: Icon(Icons.view_timeline),
            label: '  Linha\ndo tempo',
            tooltip: 'Linha do tempo',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  void _goToIndex(
    BuildContext context,
    int index,
    StatefulNavigationShell? shell,
  ) {
    if (shell != null) {
      shell.goBranch(index, initialLocation: index == shell.currentIndex);
      return;
    }

    final route = switch (index) {
      0 => AppRoutes.home,
      1 => AppRoutes.history,
      2 => AppRoutes.diary,
      3 => AppRoutes.timeline,
      4 => AppRoutes.settings,
      _ => AppRoutes.home,
    };

    context.go(route);
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          BrandingAssets.appIcon(context),
          width: 30,
          height: 30,
          fit: BoxFit.contain,
          semanticLabel: 'Marca EMControle',
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'EMControle',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              'Seu cuidado, organizado',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
