import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';
import '../theme/app_theme.dart';
import '../screens/placeholder_screen.dart';
import '../screens/ai_chat_screen.dart';

class AppDrawer extends StatelessWidget {
  /// Label do item atualmente selecionado (ex: 'Início').
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
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                Navigator.of(context).pop();
                
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTap(BuildContext context, MenuItemData item, bool isSelected) {
    Navigator.of(context).pop(); // fecha o drawer

    if (isSelected) return; // já está nessa tela, não navega

    if (item.label == 'Início') {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    if (item.label == 'IA') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AiChatScreen()),
      );
      return;
    }

    // Enquanto a tela real não existe, abre um placeholder.
    // Troque isso por rotas nomeadas (ou push da tela real) conforme
    // cada tela for sendo criada.
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
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.heroGradientStart,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
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
                      colors: [
                        AppColors.primaryBlue,
                        AppColors.accentBlue,
                      ],
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