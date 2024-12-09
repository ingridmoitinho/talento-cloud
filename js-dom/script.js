// Criando um novo elemento de título h1 e definindo seu conteúdo e id
let titulo = document.createElement("h1");
titulo.id = "titulo";
titulo.innerText = "Livraria";

// Capturando o elemento pai (body) e adicionando o elemento titulo no DOM
let body = document.querySelector("body");
body.appendChild(titulo);

// Criando um novo elemento div para representar um produto (livro)
let livro = document.createElement("div");
livro.innerHTML = `
  <div>
    <h2>Dom Casmurro</h2>
    <img src="https://m.media-amazon.com/images/I/81XpG2iKTlL._AC_UF1000,1000_QL80_.jpg" alt="Dom Casmurro">
    <p>Dom Casmurro é um livro escrito por Machado de Assis em 1899.</p>
    <p id="preco-dom-casmurro">R$ 29.90</p>
  </div>
`;

// Adicionando o elemento de livro (div) ao DOM, dentro do (body)
body.appendChild(livro)

