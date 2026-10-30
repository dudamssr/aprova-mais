import 'package:flutter/material.dart';

class AgendaDeEstudosPage extends StatelessWidget {
  const AgendaDeEstudosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 30),
            const SizedBox(width: 10),
            const Text(
              'Agenda',
              style: TextStyle(
                color: Color(0xFF1E40AF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: Color(0xFFDCE6F9),
            child: Icon(Icons.person, color: Color(0xFF1E40AF)),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organize sua rotina',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 5),
            const Text(
              'Agenda de Estudos',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Organize suas tarefas, metas e horários.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.checklist, color: Color(0xFF1E40AF)),
                            SizedBox(width: 10),
                            Text(
                              'Checklist de hoje',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '0 tarefas',
                            style: TextStyle(color: Color(0xFF1E40AF)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFF1E40AF),
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Não foi possível carregar as tarefas.\nErro na requisição (403).',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E40AF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Calendário semanal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E40AF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('Calendário mensal'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDCE6F9)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'SUA ROTINA',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Text(
              'Semana',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const Text(
              '25 a 31 de outubro de 2026',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final dias = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
                final numeros = [25, 26, 27, 28, 29, 30, 31];
                final isSelected = index == 3;
                return Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEFF6FF)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E40AF)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dias[index],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: isSelected
                            ? const Color(0xFF1E40AF)
                            : const Color(0xFFDCE6F9),
                        child: Text(
                          '${numeros[index]}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
