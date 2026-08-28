    const nome=localStorage.getItem("nomeUsuario")||localStorage.getItem("nome")||"Usuário";
    document.getElementById("nomeUsuario").textContent=nome;
    document.getElementById("tituloBoasVindas").textContent=`Olá, ${nome}!`;

    const hoje=new Date();
    document.getElementById("dataAtual").textContent=hoje.toLocaleDateString("pt-BR",{day:"2-digit",month:"long",year:"numeric"});

    const dados={
    7:{labels:["Seg","Ter","Qua","Qui","Sex","Sáb","Dom"],valores:[35,48,42,60,55,72,68]},
    30:{labels:["01","05","10","15","20","25","30"],valores:[25,38,42,55,48,70,76]},
    90:{labels:["Jun","Jul","Ago"],valores:[35,58,76]}
    };

    const ctx=document.getElementById("graficoDesempenho");

    let grafico=new Chart(ctx,{
    type:"line",
    data:{labels:dados[7].labels,datasets:[{data:dados[7].valores,borderColor:"#2457c5",backgroundColor:"rgba(36,87,197,.08)",borderWidth:2,pointRadius:3,pointBackgroundColor:"#2457c5",fill:true,tension:.4}]},
    options:{
    responsive:true,
    maintainAspectRatio:false,
    plugins:{legend:{display:false},tooltip:{backgroundColor:"#102f55",displayColors:false}},
    scales:{
    x:{grid:{display:false},ticks:{color:"#9aa7b5",font:{size:9}}},
    y:{beginAtZero:true,suggestedMax:100,grid:{color:"#edf1f4"},border:{display:false},ticks:{color:"#9aa7b5",font:{size:9},callback:v=>v+"%"}}
    }
    }
    });

    document.querySelectorAll(".filtro").forEach(btn=>{
    btn.addEventListener("click",()=>{
    document.querySelectorAll(".filtro").forEach(b=>b.classList.remove("ativo"));
    btn.classList.add("ativo");
    const periodo=btn.dataset.periodo;
    grafico.data.labels=dados[periodo].labels;
    grafico.data.datasets[0].data=dados[periodo].valores;
    grafico.update();
    });
    });

    document.getElementById("botaoSair").addEventListener("click",()=>{
    localStorage.removeItem("nomeUsuario");
    localStorage.removeItem("nome");
    window.location.href="login.html";
    });

    document.querySelectorAll(".acesso button").forEach(botao=>{
    botao.addEventListener("click",()=>{
    const texto=botao.querySelector("span").textContent;
    console.log("Acesso:",texto);
    });
    });