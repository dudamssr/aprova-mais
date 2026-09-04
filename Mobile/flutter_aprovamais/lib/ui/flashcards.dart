import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/flashcard.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  String filtro = 'Todas';
  String materiaSelecionada = 'Todas as matérias';

  final List<Map<String, dynamic>> flashcards = [
    {
      'subject': 'Matemática',
      'question': 'O que é uma função?',
      'answer':
          'É uma relação que associa cada elemento de um conjunto a exatamente um elemento de outro conjunto.',
      'explanation':
          'No ENEM, funções aparecem bastante em situações do cotidiano, como gráficos, preços, tarifas e crescimento.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Matemática',
      'question': 'Como calcular porcentagem?',
      'answer':
          'Multiplique o valor pela porcentagem e divida o resultado por 100.',
      'explanation':
          'Porcentagem é muito cobrada no ENEM em descontos, aumentos, juros, pesquisas e interpretação de gráficos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Matemática',
      'question': 'O que é média aritmética?',
      'answer': 'É a soma dos valores dividida pela quantidade de valores.',
      'explanation':
          'A média é um dos principais conceitos de estatística cobrados no ENEM.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Matemática',
      'question': 'Qual é a fórmula da área de um triângulo?',
      'answer': 'Área = base × altura ÷ 2.',
      'explanation':
          'Geometria aparece frequentemente em problemas envolvendo áreas, terrenos, construções e objetos do cotidiano.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Português',
      'question': 'O que é interpretação de texto?',
      'answer':
          'É a capacidade de compreender, analisar e relacionar as informações presentes em um texto.',
      'explanation':
          'Interpretação é um dos conteúdos mais importantes de Português no ENEM.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Português',
      'question': 'O que são gêneros discursivos?',
      'answer':
          'São diferentes formas de comunicação utilizadas de acordo com a situação e finalidade.',
      'explanation':
          'Notícias, propagandas, poemas, charges e artigos são exemplos de gêneros discursivos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Português',
      'question': 'O que é linguagem verbal?',
      'answer': 'É aquela que utiliza palavras para transmitir uma mensagem.',
      'explanation': 'Pode aparecer tanto na forma escrita quanto na fala.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Português',
      'question': 'O que é linguagem não verbal?',
      'answer':
          'É aquela que utiliza imagens, símbolos, gestos, cores ou outros elementos sem palavras.',
      'explanation':
          'O ENEM costuma misturar linguagem verbal e não verbal em charges, anúncios e tirinhas.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'História',
      'question': 'O que foi o Brasil Colônia?',
      'answer':
          'Foi o período em que o Brasil esteve sob domínio de Portugal, de 1500 a 1822.',
      'explanation':
          'Nesse período ocorreram a exploração econômica, a escravidão e a formação da sociedade colonial.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'História',
      'question': 'O que foi a Ditadura Militar no Brasil?',
      'answer':
          'Foi o período de governo militar que ocorreu entre 1964 e 1985.',
      'explanation':
          'O período foi marcado por censura, repressão política e restrições às liberdades democráticas.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'História',
      'question': 'O que são movimentos sociais?',
      'answer':
          'São ações coletivas organizadas para defender direitos e promover mudanças sociais.',
      'explanation':
          'O ENEM relaciona movimentos sociais a questões políticas, econômicas e culturais.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'História',
      'question': 'O que foi a Revolução Industrial?',
      'answer':
          'Foi um processo de transformação econômica e tecnológica iniciado na Inglaterra no século XVIII.',
      'explanation':
          'A Revolução Industrial modificou a produção, o trabalho, as cidades e as relações sociais.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Geografia',
      'question': 'O que é globalização?',
      'answer':
          'É o processo de integração econômica, política, cultural e tecnológica entre diferentes partes do mundo.',
      'explanation':
          'A globalização influencia o comércio, as empresas, a tecnologia e os hábitos culturais.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Geografia',
      'question': 'O que é geopolítica?',
      'answer': 'É o estudo das relações de poder entre países e territórios.',
      'explanation':
          'O ENEM aborda conflitos, alianças, disputas territoriais e relações internacionais.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Geografia',
      'question': 'O que são fontes de energia renováveis?',
      'answer':
          'São fontes de energia que se renovam naturalmente, como solar, eólica e hidráulica.',
      'explanation':
          'O tema está relacionado à sustentabilidade e aos impactos ambientais da produção de energia.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Geografia',
      'question': 'O que são mudanças climáticas?',
      'answer':
          'São alterações de longo prazo nos padrões de temperatura e clima da Terra.',
      'explanation':
          'O ENEM relaciona mudanças climáticas a questões ambientais, econômicas e sociais.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Biologia',
      'question': 'O que é ecologia?',
      'answer':
          'É o estudo das relações entre os seres vivos e o ambiente em que vivem.',
      'explanation':
          'Ecologia é um dos assuntos mais frequentes de Biologia no ENEM.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Biologia',
      'question': 'O que é genética?',
      'answer':
          'É a área da Biologia que estuda a hereditariedade e a transmissão das características.',
      'explanation':
          'Genética envolve conceitos como DNA, genes, cromossomos, hereditariedade e mutações.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Biologia',
      'question': 'Qual é a função do sistema respiratório?',
      'answer': 'Realizar as trocas gasosas entre o organismo e o ambiente.',
      'explanation':
          'O sistema respiratório permite a entrada de oxigênio e a eliminação de gás carbônico.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Biologia',
      'question': 'O que é uma cadeia alimentar?',
      'answer':
          'É a sequência de organismos em que ocorre transferência de energia por meio da alimentação.',
      'explanation':
          'As cadeias alimentares ajudam a entender as relações entre produtores e consumidores.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Física',
      'question': 'O que diz a primeira Lei de Newton?',
      'answer':
          'Um corpo tende a permanecer em repouso ou em movimento uniforme se nenhuma força resultante atuar sobre ele.',
      'explanation': 'Essa lei é conhecida como princípio da inércia.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Física',
      'question': 'O que é energia?',
      'answer':
          'É a capacidade de realizar trabalho ou provocar transformações.',
      'explanation':
          'O ENEM aborda diferentes formas de energia, como elétrica, térmica, cinética e potencial.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Física',
      'question': 'O que é corrente elétrica?',
      'answer': 'É o movimento ordenado de cargas elétricas em um condutor.',
      'explanation':
          'Corrente elétrica é um conceito fundamental para compreender circuitos e aparelhos elétricos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Física',
      'question': 'O que é velocidade média?',
      'answer': 'É a razão entre a distância percorrida e o tempo gasto.',
      'explanation':
          'A velocidade média aparece em situações envolvendo viagens, deslocamentos e movimentos.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Química',
      'question': 'O que é uma reação química?',
      'answer':
          'É uma transformação em que substâncias são convertidas em novas substâncias.',
      'explanation':
          'Reações químicas podem ser observadas em fenômenos do cotidiano, como combustão e oxidação.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Química',
      'question': 'O que é estequiometria?',
      'answer':
          'É o estudo das relações quantitativas entre reagentes e produtos de uma reação química.',
      'explanation':
          'A estequiometria é utilizada para calcular massas, quantidades de matéria e proporções em reações.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Química',
      'question': 'O que é pH?',
      'answer':
          'É uma escala utilizada para indicar a acidez ou basicidade de uma solução.',
      'explanation':
          'Valores menores indicam maior acidez e valores maiores indicam maior basicidade.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Química',
      'question': 'O que é química ambiental?',
      'answer':
          'É a área que estuda as transformações químicas relacionadas ao meio ambiente.',
      'explanation':
          'Envolve temas como poluição, tratamento da água, efeito estufa e impactos ambientais.',
      'aprendido': false,
      'favorito': false,
    },

    {
      'subject': 'Literatura',
      'question': 'O que foi o Modernismo brasileiro?',
      'answer':
          'Foi um movimento literário e artístico que buscou romper com padrões tradicionais e valorizar uma identidade brasileira.',
      'explanation':
          'O Modernismo teve grande importância na literatura brasileira e é bastante cobrado no ENEM.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Literatura',
      'question': 'O que é uma obra literária?',
      'answer':
          'É uma produção artística que utiliza a linguagem para expressar ideias, sentimentos e experiências.',
      'explanation':
          'A análise de obras no ENEM considera linguagem, contexto histórico e características do autor.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Literatura',
      'question': 'O que é linguagem literária?',
      'answer':
          'É o uso artístico e expressivo da linguagem, muitas vezes utilizando sentidos figurados.',
      'explanation':
          'A linguagem literária pode explorar metáforas, símbolos, ambiguidades e diferentes interpretações.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Literatura',
      'question': 'O que são escolas literárias?',
      'answer':
          'São períodos ou movimentos literários que possuem características, estilos e ideias em comum.',
      'explanation':
          'Exemplos são Romantismo, Realismo, Modernismo e outros movimentos da literatura brasileira.',
      'aprendido': false,
      'favorito': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtrados = flashcards
        .where((card) {
          if (filtro == 'Revisões pendentes') return !card['aprendido'];
          if (filtro == 'Favoritas') return card['favorito'];
          return true;
        })
        .where((card) {
          if (materiaSelecionada == 'Todas as matérias') return true;
          return card['subject'] == materiaSelecionada;
        })
        .toList();

    return Scaffold(
      backgroundColor: paleBlue,
      drawer: const AppDrawer(selectedLabel: 'Flashcards'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopBar(),
            const SizedBox(height: 16),

            const Text(
              'Sistema de revisão inteligente com flashcards',
              style: TextStyle(color: textDark, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Estatísticas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatCard(
                  label: 'Total',
                  value: '${flashcards.length}',
                  icon: Icons.layers,
                ),
                _StatCard(
                  label: 'Aprendidos',
                  value: '${flashcards.where((c) => c['aprendido']).length}',
                  icon: Icons.check_circle,
                ),
                _StatCard(
                  label: 'Pendentes',
                  value: '${flashcards.where((c) => !c['aprendido']).length}',
                  icon: Icons.refresh,
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Filtros
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _FilterChip(
                  label: 'Todas',
                  selected: filtro == 'Todas',
                  onTap: () => setState(() => filtro = 'Todas'),
                ),
                _FilterChip(
                  label: 'Revisões pendentes',
                  selected: filtro == 'Revisões pendentes',
                  onTap: () => setState(() => filtro = 'Revisões pendentes'),
                ),
                _FilterChip(
                  label: 'Favoritas',
                  selected: filtro == 'Favoritas',
                  onTap: () => setState(() => filtro = 'Favoritas'),
                ),
                _DropdownFilter(
                  value: materiaSelecionada,
                  onChanged: (v) => setState(() => materiaSelecionada = v!),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Lista de flashcards filtrados
            if (filtrados.isEmpty)
              const Center(
                child: Text(
                  'Nenhum flashcard neste filtro.',
                  style: TextStyle(color: textDark, fontSize: 16),
                ),
              )
            else
              for (final card in filtrados) ...[
                Flashcard(
                  subject: card['subject'],
                  question: card['question'],
                  answer: card['answer'],
                  explanation: card['explanation'],
                  favorito: card['favorito'],
                  textColor: textDark,
                  onFavoritar: () =>
                      setState(() => card['favorito'] = !card['favorito']),
                ),
                const SizedBox(height: 10),
                if (!card['aprendido'])
                  ElevatedButton.icon(
                    onPressed: () => setState(() => card['aprendido'] = true),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Marcar como aprendido'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: textDark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Aprendido',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
          ],
        ),
      ),
    );
  }
}

// TOPO DA TELA
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo2.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Flashcards',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: primaryColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }
}

// COMPONENTES DE UI
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 13, color: textMedium)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: primaryColor,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : textDark,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const _DropdownFilter({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: const [
            DropdownMenuItem(
              value: 'Todas as matérias',
              child: Text('Todas as matérias'),
            ),
            DropdownMenuItem(value: 'Matemática', child: Text('Matemática')),
            DropdownMenuItem(value: 'Português', child: Text('Português')),
            DropdownMenuItem(value: 'História', child: Text('História')),
            DropdownMenuItem(value: 'Geografia', child: Text('Geografia')),
            DropdownMenuItem(value: 'Biologia', child: Text('Biologia')),
            DropdownMenuItem(value: 'Física', child: Text('Física')),
            DropdownMenuItem(value: 'Química', child: Text('Química')),
            DropdownMenuItem(value: 'Literatura', child: Text('Literatura')),
            DropdownMenuItem(value: 'Redação', child: Text('Redação')),
            DropdownMenuItem(value: 'Filosofia', child: Text('Filosofia')),
            DropdownMenuItem(value: 'Sociologia', child: Text('Sociologia')),
          ],
          onChanged: onChanged,
          style: const TextStyle(color: textDark, fontSize: 15),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
