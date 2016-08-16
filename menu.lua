
menu = {}

-- Carregando as propriedades do Objeto Menu
function menu.load()
	fonte_titulo = love.graphics.newFont("/fontes/sofachro.ttf", 50)
	fonte_descricao = love.graphics.newFont("fontes/sofachro.ttf", 15)

end

-- Desenhando menu na tela
function menu.draw()
	love.graphics.setBackgroundColor(0, 12, 24)

-- Desenhando o titulo do menu
	love.graphics.setFont(fonte_titulo)
	love.graphics.print("Space Trip", 55, 250)

-- Desenhando a descricao do menu
	love.graphics.setFont(fonte_descricao)
	love.graphics.print("(S) Começar", 220, 350)
end
