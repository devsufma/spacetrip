
combustivel = {}

function inserir_combustivel_a_tabela()
	vetor = {}

	vetor.imagem = love.graphics.newImage("/imagens/battery.png")
	vetor.x = love.math.random(10, love.window.getWidth() - 10)
	vetor.y = 0
	vetor.largura = vetor.imagem:getWidth()/2
	vetor.altura = vetor.imagem:getHeight()/2

	table.insert(combustivel.tabela, vetor)
end

function combustivel.load()
	combustivel.tabela = {}
	combustivel.tempo = 0

end

function combustivel.update(dt)
	combustivel.tempo = combustivel.tempo + 1

	if combustivel.tempo % 200 == 0 then
		inserir_combustivel_a_tabela()
	end

	for i,c in ipairs(combustivel.tabela) do
		if c.y < -10 then
			table.remove(combustivel.tabela, i)
		end

		c.y = c.y + 3

	end
end


function combustivel.draw()
	for _,c in pairs(combustivel.tabela) do
		love.graphics.draw(c.imagem, c.x, c.y)
	end

end


