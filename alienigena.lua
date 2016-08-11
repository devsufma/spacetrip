
alienigena = {}

-- Inserindo o Objeto Alienigena a tabela
function inserir_alienigena_na_tabela()
		vetor = {}

		vetor.imagem = love.graphics.newImage("/imagens/ufo.png")
		vetor.largura = vetor.imagem:getWidth()
		vetor.altura = vetor.imagem:getHeight()
		vetor.x = 0
		vetor.y = 20

		table.insert(alienigena.tabela, vetor)
end


function verificar_colisao_entre_balas_e_alienigena()

	for i,m in ipairs(alienigena.tabela) do
		for j,b in ipairs(player.balas) do
		-- Verificando colisoes entre Foguete e Meteoro
		-- Canto direito inferior
		if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then
			
			table.remove(alienigena.tabela, i)
			table.remove(player.balas, j)
			alienigena.existe = false
			player.score = player.score + 10
			

			-- Canto direito superior
			else if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then
				
				table.remove(alienigena.tabela, i)
				table.remove(player.balas, j)
				alienigena.existe = false
				player.score = player.score + 10

			-- Canto esquerdo superior
			else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then
				
				table.remove(alienigena.tabela, i)
				table.remove(player.balas, j)
				alienigena.existe = false
				player.score = player.score + 10

			-- Canto esquerdo inferior
			else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then
				
				table.remove(alienigena.tabela, i)
				table.remove(player.balas, j)
				alienigena.existe = false
				player.score = player.score + 10

			end
			end
		end
	end
end
end
end


-- Carregando propriedades do Objeto Alienigena
function alienigena.load()
	alienigena.existe = false
	alienigena.tabela = {}
	alienigena.tempo = 0

end



-- Atualizando propriedades do Objeto Alienigena
function alienigena.update(dt)

	alienigena.tempo = alienigena.tempo + 1

	verificar_colisao_entre_balas_e_alienigena()

	if ((alienigena.tempo % 2000) == 0 and alienigena.existe == false) then
		inserir_alienigena_na_tabela()
		alienigena.existe = true
		alienigena.tempo = 0
	end

	for i,a in ipairs(alienigena.tabela) do

		if a.x < 0 or a.x > love.window.getWidth() then
			table.remove(alienigena.tabela, i)
			alienigena.existe = false

		end

		a.x = a.x + 4
		a.y = a.y + 1
	end
end

-- Desenhando o Objeto Alienigena na tela
function alienigena.draw()
	for _,a in pairs(alienigena.tabela) do
		love.graphics.draw(a.imagem, a.x, a.y)
	end
end


