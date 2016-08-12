
combustivel = {}

-- Gerando combustiveis na tela
function combustivel.spawn()
	vetor = {}

	vetor.imagem = love.graphics.newImage("/imagens/battery.png")
	vetor.x = love.math.random(20, love.window.getWidth() - 20)
	vetor.y = 0
	vetor.largura = vetor.imagem:getWidth()/2
	vetor.altura = vetor.imagem:getHeight()/2

	table.insert(combustivel.tabela, vetor)
end

-- Carregando propriedades do Combustivel
function combustivel.load()
	combustivel.tabela = {}
	combustivel.tempo = 0

end

-- Atualizando as propriedades do Combustivel
function combustivel.update(dt)
	combustivel.tempo = combustivel.tempo + 0.01

	if combustivel.tempo >= 2 then
		combustivel.spawn()
		combustivel.tempo = 0
	end

	for i,c in ipairs(combustivel.tabela) do
		if c.y > love.window.getHeight() + 10 then
			table.remove(combustivel.tabela, i)
		end

		c.y = c.y + 4
	end
end

-- Desenhando combustiveis na tela
function combustivel.draw()
	for _,c in pairs(combustivel.tabela) do
		love.graphics.draw(c.imagem, c.x, c.y)
	end
end
