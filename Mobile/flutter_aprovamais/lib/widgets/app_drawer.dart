import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';
import '../style/app_thema.dart';
import '../ui/placeholder_screen.dart';
import '../ui/ai_chat_screen.dart';
import '../ui/splash.dart';
import '../ui/perfil.dart';
import '../ui/redacao.dart';
import '../ui/flashcards.dart';

class AppDrawer extends StatelessWidget {
  final String selectedLabel;

  const AppDrawer({super.key, this.selectedLabel = 'Início'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardBackground,
      width: 280,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          children: [
            _DrawerHeader(),

            const Divider(height: 1, color: AppColors.progressTrack),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                itemCount: AppMenu.items.length,
                itemBuilder: (context, index) {
                  final item = AppMenu.items[index];
                  final isSelected = item.label == selectedLabel;

                  return _DrawerTile(
                    item: item,
                    isSelected: isSelected,
                    onTap: () => _onItemTap(context, item, isSelected),
                  );
                },
              ),
            ),

            const Divider(height: 1, color: AppColors.progressTrack),

            _LogoutTile(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTap(BuildContext context, MenuItemData item, bool isSelected) {
    // Fecha o Drawer.
    Navigator.of(context).pop();

    // Se já estiver nessa tela, não navega novamente.
    if (isSelected) return;

    // =========================
    // INÍCIO
    // =========================
    if (item.label == 'Início') {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    // =========================
    // IA
    // =========================
    if (item.label == 'IA') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AiChatScreen()));
      return;
    }

    // =========================
    // PERFIL
    // =========================
    if (item.label == 'Perfil') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const PerfilPage()));
      return;
    }

    // =========================
    // REDAÇÃO
    // =========================
    if (item.label == 'Redação') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const RedacaoPage()));
      return;
    }

    if (item.label == 'Flashcards') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const FlashcardsPage()));
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlaceholderScreen(title: item.label, icon: item.icon),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      child: Row(
        children: [
          // Logo do aplicativo
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.heroGradientStart,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/logo2.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 10),

          const Expanded(
            child: Text(
              AppMenu.appName,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textMedium),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final MenuItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.accentBlue],
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: isSelected ? Colors.white : AppColors.primaryBlue,
                ),

                const SizedBox(width: 14),

                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(Icons.logout, size: 20, color: Colors.redAccent),

              SizedBox(width: 14),

              Text(
                'Sair',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
