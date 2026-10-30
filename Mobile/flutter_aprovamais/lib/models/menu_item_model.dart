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
    MenuItemData(icon: Icons.chat_bubble_outline, label: 'Chat IA'),
    MenuItemData(icon: Icons.calendar_today_outlined, label: 'Agenda'),
    MenuItemData(icon: Icons.menu_book_outlined, label: 'Matérias'),
    MenuItemData(
      icon: Icons.library_books_outlined,
      label: 'Banco de Questões',
    ),
    MenuItemData(icon: Icons.assignment_outlined, label: 'Simulado'),
    MenuItemData(icon: Icons.style_outlined, label: 'Flashcards'),
    MenuItemData(icon: Icons.person_outline, label: 'Perfil'),
    MenuItemData(icon: Icons.trending_up_outlined, label: 'TRI'),
  ];
}
