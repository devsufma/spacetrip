
planeta = {}

-- Inserindo um planeta a tabela
function inserir_planeta_a_tabela()
	vetor = {}
		
	vetor.imagem = love.graphics.newImage("/imagens/planet-earth.png")
	vetor.largura = vetor.imagem:getWidth()/2
	vetor.altura = vetor.imagem:getHeight()/2
	vetor.x = love.math.random(10, love.window.getWidth() - 10)
	vetor.y = 0
	vetor.angulo = 0

	table.insert(planeta.tabela, vetor)
end

function planeta.load()
	planeta.tabela = {}
	planeta.tempo = 0
end

function planeta.update(dt)
	planeta.tempo = planeta.tempo + 1

	if ((planeta.tempo % 1000) == 0) then 
		inserir_planeta_a_tabela()
	end

	for i,p in ipairs(planeta.tabela) do
		if p.y < -10 then
			table.remove(planeta.tabela, i)
		end

		p.y = p.y + 2
		p.angulo = p.angulo + 1
	end

end

function planeta.draw()
	-- Desenhando o planeta na tela
	love.graphics.setBackgroundColor(0, 12, 24)

	for _,p in pairs(planeta.tabela) do
		love.graphics.draw(p.imagem, p.x, p.y, math.rad(p.angulo), 1, 1, p.largura, p.altura)
	end
end