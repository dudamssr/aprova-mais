import 'package:flutter/material.dart';

/// Representa um item do menu lateral (drawer).
class MenuItemData {
  final IconData icon;
  final String label;

  const MenuItemData({required this.icon, required this.label});
}

class AppMenu {
  AppMenu._();

  static const String appName = 'Aprov +';

  static const List<MenuItemData> items = [
    MenuItemData(icon: Icons.home_outlined, label: 'Início'),
    MenuItemData(icon: Icons.menu_book_outlined, label: 'Matérias'),
    MenuItemData(icon: Icons.layers_outlined, label: 'Banco de Questões'),
    MenuItemData(icon: Icons.description_outlined, label: 'Simulados'),
    MenuItemData(icon: Icons.style_outlined, label: 'Flashcards'),
    MenuItemData(icon: Icons.calendar_today_outlined, label: 'Agenda'),
    MenuItemData(icon: Icons.edit_outlined, label: 'Redação'),
    MenuItemData(icon: Icons.dashboard_outlined, label: 'TRI'),
    MenuItemData(icon: Icons.chat_bubble_outline, label: 'IA'),
    MenuItemData(icon: Icons.person_outline, label: 'Perfil'),
  ];
}
