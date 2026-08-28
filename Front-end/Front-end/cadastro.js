
const formCadastro = document.getElementById("formCadastro");

const nome = document.getElementById("nome");
const email = document.getElementById("email");
const senha = document.getElementById("senha");
const confirmarSenha = document.getElementById("confirmarSenha");

const mensagem = document.getElementById("mensagem");


const mostrarSenha = document.getElementById("mostrarSenha");

mostrarSenha.addEventListener("click", function () {
    if (senha.type === "password") {

        senha.type = "text";
        mostrarSenha.textContent = "Ocultar";

    } else {
        senha.type = "password";
        mostrarSenha.textContent = "Mostrar";

    }

});


formCadastro.addEventListener("submit", function (event) {

    event.preventDefault();

    const nomeValor = nome.value.trim();
    const emailValor = email.value.trim();
    const senhaValor = senha.value;
    const confirmarSenhaValor = confirmarSenha.value;


    if (nomeValor.length < 3) {
        mostrarMensagem("Digite seu nome completo.","erro");
        nome.focus();

        return;
    }


    if (!validarEmail(emailValor)) {
        mostrarMensagem("Digite um e-mail válido.","erro" );
        email.focus();

        return;
    }



    if (senhaValor.length < 6) {
        mostrarMensagem("A senha deve ter pelo menos 6 caracteres.","erro");
        senha.focus();

        return;
    }



    if (senhaValor !== confirmarSenhaValor) {
        mostrarMensagem("As senhas não coincidem.","erro");
        confirmarSenha.focus();

        return;
    }


    mostrarMensagem("Cadastro realizado com sucesso!", "sucesso");

    console.log("Novo usuário:");
    console.log("Nome:", nomeValor);
    console.log("E-mail:", emailValor);


    setTimeout(function () {
        formCadastro.reset();
        mostrarSenha.textContent = "Mostrar";
        senha.type = "password";
        mensagem.textContent = "";

    }, 2500);

});


function validarEmail(email) {

    const regex =
        /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    return regex.test(email);
}


function mostrarMensagem(texto, tipo) {
    mensagem.textContent = texto;

    if (tipo === "erro") {
        mensagem.style.color = "#dc3545";
    }
    if (tipo === "sucesso") {
        mensagem.style.color = "#198754";

    }

}

const botaoGoogle =
    document.getElementById("botaoGoogle");

botaoGoogle.addEventListener("click", function () {

    mostrarMensagem(
        "O login com Google será configurado em breve.",
        "erro"
    );

});