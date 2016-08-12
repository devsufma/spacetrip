
meteoro = {}

-- Gerando meteros na tela
function meteoro.spawn()
	vetor = {}

	vetor.imagem = love.graphics.newImage("/imagens/asteroid.png")
	vetor.largura = vetor.imagem:getWidth()/2
	vetor.altura = vetor.imagem:getHeight()/2
	vetor.x = player.x
	vetor.y = 0
	vetor.angulo = 0
	vetor.numero_de_balas = 0

	table.insert(meteoro.tabela, vetor)
end

-- Verificando colisao entre balas e meteoro
function verificar_colisao_entre_balas_e_meteoro()
	for i,m in ipairs(meteoro.tabela) do
		for j,b in ipairs(player.balas) do
		-- Canto direito inferior
			if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then

				table.remove(player.balas, j)

				if m.numero_de_balas ~= 0 then
					table.remove(meteoro.tabela, i)
				else
					m.numero_de_balas = m.numero_de_balas + 1
				end

				-- Canto direito superior
				else if ((b.x + b.largura >= m.x and b.x + b.largura <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then

					table.remove(player.balas, j)

					if m.numero_de_balas ~= 0 then
						table.remove(meteoro.tabela, i)
					else
						m.numero_de_balas = m.numero_de_balas + 1
					end

					-- Canto esquerdo superior
					else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y >= m.y and b.y <= m.y + m.altura)) then

						table.remove(player.balas, j)

						if m.numero_de_balas ~= 0 then
							table.remove(meteoro.tabela, i)
						else
							m.numero_de_balas = m.numero_de_balas + 1
						end

						-- Canto esquerdo inferior
						else if ((b.x >= m.x and b.x <= m.x + m.largura) and (b.y + b.altura >= m.y and b.y + b.altura <= m.y + m.altura)) then

							table.remove(player.balas, j)

							if m.numero_de_balas ~= 0 then
								table.remove(meteoro.tabela, i)
							else
								m.numero_de_balas = m.numero_de_balas + 1
							end

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
	meteoro.tempo = meteoro.tempo + 0.1

	if meteoro.tempo >= 30.0 then
		meteoro.spawn()
		meteoro.tempo = 0
	end

	for i,m in ipairs(meteoro.tabela) do
		if m.y > love.window.getHeight() + 10 then
			table.remove(meteoro.tabela, i)
		end

		m.y = m.y + 4
		m.angulo = m.angulo + 2
	end

	verificar_colisao_entre_balas_e_meteoro()
end

-- Desenhando Objeto Meteoro na tela
function meteoro.draw()
	for _,m in pairs(meteoro.tabela) do
		love.graphics.draw(m.imagem, m.x, m.y, math.rad(m.angulo), 1, 1, m.largura, m.altura)

	end
end
