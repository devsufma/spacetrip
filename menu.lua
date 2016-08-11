
menu = {}

-- Carregando as propriedades do Objeto Menu
function menu.load()
	fonte_titulo = love.graphics.newFont("/fontes/sofachrome/sofachro.ttf", 30)
	fonte_descricao = love.graphics.newFont("fontes/sofachrome/sofachro.ttf", 15)

end

function menu.draw()
	love.graphics.setBackgroundColor(0, 12, 24)

-- Desenhando o titulo do menu
	love.graphics.setFont(fonte_titulo)
	love.graphics.print("Naving For Spaces", 30, love.window.getHeight()/2)

-- Desenhando a descricao do menu
	love.graphics.setFont(fonte_descricao)
	love.graphics.print("Apertar [SPACE] para começar o jogo", 20, love.window.getHeight()/2 + 100)

end