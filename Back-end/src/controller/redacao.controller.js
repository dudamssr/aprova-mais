
const Groq = require('groq-sdk');

const groq = new Groq({
    apiKey: process.env.GROQ_API_KEY
});

const corrigir = async (req, res) => {
    try {
        const { tema, titulo, texto } = req.body;

        if (!texto || typeof texto !== 'string' || texto.trim().length < 100) {
            return res.status(400).json({
                erro: 'A redação precisa ter no mínimo 100 caracteres para ser avaliada.'
            });
        }

        if (!process.env.GROQ_API_KEY) {
            console.error('ERRO: GROQ_API_KEY não foi configurada.');

            return res.status(500).json({
                erro: 'A chave da API da Groq não está configurada no servidor.'
            });
        }

        const prompt = `
Você é um avaliador especialista em redações do ENEM.

Avalie a redação de acordo com as cinco competências oficiais do ENEM.
Cada competência deve receber uma nota de 0 a 200, em intervalos de 40 pontos.

Tema: ${tema || 'Não informado'}
Título: ${titulo || 'Sem título'}

Texto da redação:
${texto}

Avalie as competências:

C1: domínio da modalidade escrita formal da língua portuguesa.
C2: compreensão do tema, do tipo textual e uso de repertório sociocultural.
C3: seleção, organização e desenvolvimento dos argumentos.
C4: uso de mecanismos linguísticos de coesão.
C5: proposta de intervenção detalhada e respeitosa aos direitos humanos.

Retorne exclusivamente um objeto JSON válido, neste formato:

{
    "notaTotal": 0,
    "c1": {
        "nota": 0,
        "feedback": "..."
    },
    "c2": {
        "nota": 0,
        "feedback": "..."
    },
    "c3": {
        "nota": 0,
        "feedback": "..."
    },
    "c4": {
        "nota": 0,
        "feedback": "..."
    },
    "c5": {
        "nota": 0,
        "feedback": "..."
    },
    "comentarios": "...",
    "sugestoes": "..."
}

Regras:
- Cada nota deve ser 0, 40, 80, 120, 160 ou 200.
- As notas devem ser coerentes com os comentários.
- Não invente erros que não estejam presentes no texto.
- Considere os critérios oficiais de correção do ENEM.
- A notaTotal deve corresponder à soma das cinco competências.
- Os feedbacks devem ser específicos e explicar os pontos fortes e fracos.
- As sugestões devem ser práticas e relacionadas à redação apresentada.
`;

        console.log('Iniciando correção de redação...');
        console.log('Modelo enviado para Groq: openai/gpt-oss-120b');

        const response = await groq.chat.completions.create({
            model: 'openai/gpt-oss-120b',
            messages: [
                {
                    role: 'system',
                    content: 'Você é um corretor especialista em redações do ENEM. Retorne somente um objeto JSON válido, sem Markdown.'
                },
                {
                    role: 'user',
                    content: prompt
                }
            ],
            temperature: 0.2,
            max_completion_tokens: 2500,
            response_format: {
                type: 'json_object'
            }
        });

        const conteudo = response.choices?.[0]?.message?.content;

        if (!conteudo) {
            throw new Error('A Groq retornou uma resposta vazia.');
        }

        let correcao;

        try {
            correcao = JSON.parse(conteudo);
        } catch {
            throw new Error('A IA retornou um JSON inválido.');
        }

        const competencias = ['c1', 'c2', 'c3', 'c4', 'c5'];

        const notasValidas = competencias.every((competencia) => {
            const item = correcao[competencia];

            return item &&
                Number.isInteger(item.nota) &&
                [0, 40, 80, 120, 160, 200].includes(item.nota) &&
                typeof item.feedback === 'string';
        });

        if (!notasValidas) {
            throw new Error('A IA retornou notas ou feedbacks em formato inválido.');
        }

        correcao.notaTotal = competencias.reduce(
            (total, competencia) => total + correcao[competencia].nota,
            0
        );

        if (
            typeof correcao.comentarios !== 'string' ||
            typeof correcao.sugestoes !== 'string'
        ) {
            throw new Error('A IA não retornou comentários ou sugestões válidos.');
        }

        console.log('Correção concluída. Nota total:', correcao.notaTotal);

        return res.status(200).json(correcao);

    } catch (erro) {
        console.error('ERRO NA CORREÇÃO:', erro.message);

        if (erro.status) {
            console.error('STATUS DA API:', erro.status);
        }

        return res.status(500).json({
            erro: 'Não foi possível corrigir a redação. Verifique a configuração da API e tente novamente.'
        });
    }
};

module.exports = { corrigir };
