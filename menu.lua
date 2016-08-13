
menu = {}

-- Carregando as propriedades do Objeto Menu
function menu.load()
	fonte_titulo = love.graphics.newFont("/fontes/sofachro.ttf", 20)
	fonte_descricao = love.graphics.newFont("fontes/sofachro.ttf", 15)

end

-- Desenhando menu na tela
function menu.draw()
	love.graphics.setBackgroundColor(0, 12, 24)

-- Desenhando o titulo do menu
	love.graphics.setFont(fonte_titulo)
	love.graphics.print("Navegando Pelo Espaço", 30, love.window.getHeight()/2)

-- Desenhando a descricao do menu
	love.graphics.setFont(fonte_descricao)
	love.graphics.print("Apertar [S] para começar o jogo", 20, love.window.getHeight()/2 + 100)
end
