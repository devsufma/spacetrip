
meteoro = {}

-- Inserindo Objeto Meteoro a tabela
function inserir_meteoro_na_tabela()
	vetor = {}
		
	vetor.imagem = love.graphics.newImage("/imagens/asteroid.png")
	vetor.largura = vetor.imagem:getWidth()/2
	vetor.altura = vetor.imagem:getHeight()/2
	vetor.x = player.x
	vetor.y = 0
	vetor.angulo = 0

	table.insert(meteoro.tabela, vetor)
end

function verificar_colisao_entre_balas_e_meteoro()
	for i,m in ipairs(meteoro.tabela) do
		for j,b in ipairs(player.balas) do
		-- Verificando colisoes entre Foguete e Meteoro
		-- Canto direito inferior
		if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then
			
			table.remove(meteoro.tabela, i)
			table.remove(player.balas, j)

			-- Canto direito superior
			else if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then
				
				table.remove(meteoro.tabela, i)
				table.remove(player.balas, j)

			-- Canto esquerdo superior
			else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then
				
				table.remove(meteoro.tabela, i)
				table.remove(player.balas, j)

			-- Canto esquerdo inferior
			else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then
				
				table.remove(meteoro.tabela, i)
				table.remove(player.balas, j)

			end
			end
		end
	end
end
end
end

-- Carrengando as propriedades do Objeto Meteoro
function meteoro.load() 
	meteoro.tabela = {}
	meteoro.tempo = 0
end

-- Atualizando as propriedades do Objeto Meteoro
function meteoro.update(dt)
	meteoro.tempo = meteoro.tempo + 1

	verificar_colisao_entre_balas_e_meteoro()

	if ((meteoro.tempo % 500) == 0) then 
		inserir_meteoro_na_tabela()
		meteoro.tempo = 0
	end

	for i,m in ipairs(meteoro.tabela) do
		if m.y < -10 then
			table.remove(meteoro.tabela, i)
		end

		m.y = m.y + 5
		m.angulo = m.angulo + 1
	end

end

-- Desenhando Objeto Meteoro na tela
function meteoro.draw()
	for _,m in pairs(meteoro.tabela) do
		love.graphics.draw(m.imagem, m.x, m.y, math.rad(m.angulo), 1, 1, m.largura, m.altura)

	end
end
