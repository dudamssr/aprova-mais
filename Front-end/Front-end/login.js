const formLogin = document.getElementById("formLogin");
const email = document.getElementById("email");
const senha = document.getElementById("senha");
const mensagem = document.getElementById("mensagem");
const mostrarSenha = document.getElementById("mostrarSenha");
const botaoGoogle = document.getElementById("botaoGoogle");
const esqueciSenha = document.getElementById("esqueciSenha");


mostrarSenha.addEventListener("click", function () {
    if (senha.type === "password") {
        senha.type = "text";
        mostrarSenha.textContent = "Ocultar";

    } else {
        senha.type = "password";
        mostrarSenha.textContent = "Mostrar";

    }

});


formLogin.addEventListener("submit", function (event) {
    event.preventDefault();

    const emailValor = email.value.trim();
    const senhaValor = senha.value;


    if (!validarEmail(emailValor)) {
        mostrarMensagem("Digite um e-mail válido.", "erro");
        email.focus();

        return;
    }


    if (senhaValor.length < 6) {
        mostrarMensagem("A senha deve ter pelo menos 6 caracteres.","erro");
        senha.focus();

        return;
    }

    mostrarMensagem("Login realizado com sucesso!","sucesso");

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
    } else if (tipo === "sucesso") {
        mensagem.style.color = "#198754";

    }

}


botaoGoogle.addEventListener("click", function () {
    mostrarMensagem("O login com Google será configurado em breve.","erro");

});


esqueciSenha.addEventListener("click", function (event) {
    event.preventDefault();

    mostrarMensagem("A recuperação de senha será configurada em breve.","erro");

});