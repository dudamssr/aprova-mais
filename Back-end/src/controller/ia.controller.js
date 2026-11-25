
const Groq = require('groq-sdk');

const groq = new Groq({
    apiKey: process.env.GROQ_API_KEY
});

const tirarDuvida = async (req, res) => {
    try {
        const { duvida } = req.body;

        if (!duvida || typeof duvida !== 'string' || duvida.trim().length < 3) {
            return res.status(400).json({
                erro: 'Por favor, envie uma dúvida válida.'
            });
        }

        if (!process.env.GROQ_API_KEY) {
            console.error('ERRO: GROQ_API_KEY não configurada.');

            return res.status(500).json({
                erro: 'A chave da API da IA não está configurada.'
            });
        }

        console.log('Dúvida recebida:', duvida);
        console.log('Modelo enviado para Groq: openai/gpt-oss-120b');

        const completion = await groq.chat.completions.create({
            model: 'openai/gpt-oss-120b',
            messages: [
                {
                    role: 'system',
                    content: `
Você é o assistente virtual da plataforma Aprov+,
especializado em ajudar estudantes que estão se preparando
para o ENEM e vestibulares.

Suas funções são:

- Explicar conteúdos de todas as matérias escolares.
- Resolver dúvidas de forma didática e organizada.
- Explicar fórmulas e conceitos passo a passo.
- Ajudar na interpretação de questões.
- Apresentar exemplos para facilitar o aprendizado.
- Utilizar linguagem simples, clara e objetiva.
- Responder sempre em português brasileiro.

Quando necessário, organize a resposta com títulos,
listas, fórmulas e exemplos.

Não invente informações. Se não souber alguma resposta,
seja transparente.

Seu objetivo é ajudar o estudante a compreender o conteúdo,
e não apenas fornecer respostas prontas.
                    `
                },
                {
                    role: 'user',
                    content: duvida.trim()
                }
            ],
            temperature: 0.4,
            max_completion_tokens: 2500
        });

        const respostaIA =
            completion.choices?.[0]?.message?.content;

        if (!respostaIA) {
            throw new Error('A IA retornou uma resposta vazia.');
        }

        console.log('Resposta da IA gerada com sucesso.');

        return res.status(200).json({
            resposta: respostaIA
        });

    } catch (erro) {
        console.error('ERRO NA IA (DUVIDA):', erro.message);

        if (erro.status) {
            console.error('STATUS DA API:', erro.status);
        }

        return res.status(500).json({
            erro: 'Erro ao processar a resposta com a IA. Tente novamente.'
        });
    }
};

module.exports = { tirarDuvida };
