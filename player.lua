
player = {}

-- Verificando colisao lateral entre a tela e Player
function verificar_colisao_lateral()
	if player.x <= 0 then
		player.x = 0
	end

	if player.x + player.largura >= love.window.getWidth() then
		player.x = love.window.getWidth() - player.largura
	end

	if player.y <= 0 then
		player.y = 0
	end

	if player.y + player.altura >= love.window.getHeight() then
		player.y = love.window.getHeight() - player.altura
	end
end

-- Verificando colisao entre combustivel e player
function verificar_colisao_entre_combustivel_e_player()
	for i,c in ipairs(combustivel.tabela) do
		-- Canto direito inferior
		if ((c.x + c.largura >= player.x and c.x + c.largura <= player.x + player.largura) and (c.y + c.altura >= player.y and c.y + c.altura <= player.y + player.altura)) then
			table.remove(combustivel.tabela, i)
			player.score = player.score + 1
			player.tempo_restante = 10

			-- Canto direito superior
			else if ((c.x + c.largura >= player.x and c.x + c.largura <= player.x + player.largura) and (c.y >= player.y and c.y <= player.y + player.altura)) then
				table.remove(combustivel.tabela, i)
				player.score = player.score + 1
				player.tempo_restante = 10

				-- Canto esquerdo superior
				else if ((c.x >= player.x and c.x <= player.x + player.largura) and (c.y >= player.y and c.y <= player.y + player.altura)) then
					table.remove(combustivel.tabela, i)
					player.score = player.score + 1
					player.tempo_restante = 10

					-- Canto esquerdo inferior
					else if ((c.x >= player.x and c.x <= player.x + player.largura) and (c.y + c.altura >= player.y and c.y + c.altura <= player.y + player.altura)) then
						table.remove(combustivel.tabela, i)
						player.score = player.score + 1
						player.tempo_restante = 10

					end
				end
			end
		end
	end
end

-- Verificando colisao entre Meteoro e Player
function verificar_colisao_entre_foguete_e_meteoro()
	for i,c in ipairs(meteoro.tabela) do
		-- Canto direito inferior
		if ((c.x + c.largura >= player.x and c.x + c.largura <= player.x + player.largura) and (c.y + c.altura >= player.y and c.y + c.altura <= player.y + player.altura)) then
			player.tempo_restante = -10

				-- Canto direito superior
				else if ((c.x + c.largura >= player.x and c.x + c.largura <= player.x + player.largura) and (c.y >= player.y and c.y <= player.y + player.altura)) then
					player.tempo_restante = -10

					-- Canto esquerdo superior
					else if ((c.x >= player.x and c.x <= player.x + player.largura) and (c.y >= player.y and c.y <= player.y + player.altura)) then
						player.tempo_restante = -10

						-- Canto esquerdo inferior
						else if ((c.x >= player.x and c.x <= player.x + player.largura) and (c.y + c.altura >= player.y and c.y + c.altura <= player.y + player.altura)) then
							player.tempo_restante = -10

						end
					end
				end
			end
		end
end

-- Movendo o Player pela tela
function mover(dt)

	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed

		else if love.keyboard.isDown("left") then
			player.x = player.x - player.speed
		end
	end

	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed

		else if love.keyboard.isDown("down") then
			player.y = player.y + player.speed
		end
	end
end

-- Verificando o fim do jogo
function verificar_gameover()
	if player.tempo_restante <= 0 then
		GAME_MENU =  false
		GAME_RUNNING = false
		GAME_STOPPING = false
		GAME_OVERRING = true
	end
end

-- Atirando
function player.atirar()

	if player.limite <= 0 then
		if player.numero_de_balas > 0 then
			player.tempo_de_recarga = 0
			love.audio.play(player.som_de_tiro)

			player.limite = 20

			vetor = {}

			vetor.imagem = love.graphics.newImage("/imagens/bullet.png")
			vetor.largura = vetor.imagem:getWidth()
			vetor.altura = vetor.imagem:getHeight()
			vetor.x = player.x + 20
			vetor.y = player.y - 25

			table.insert(player.balas, vetor)
			player.numero_de_balas = player.numero_de_balas - 1
		end
	end
end

-- Carrengando propriedades do Objeto Player
function player.load()

	player.som_de_tiro = love.audio.newSource("/sons/shoot.wav")

	player.icone_de_bateria = love.graphics.newImage("/imagens/battery-icon.png")
	player.icone_de_bala = love.graphics.newImage("/imagens/bullet-icon.png")
	player.imagem = love.graphics.newImage("/imagens/rocket.png")

	player.fonte = love.graphics.newFont("/fontes/sofachro.ttf", 30)

	player.x = love.window.getWidth()/2 - 30
	player.y = love.window.getHeight() - 100
	player.speed = 10
	player.largura = player.imagem:getWidth()
	player.altura = player.imagem:getHeight()
	player.score = 0
	player.tempo_restante = 10

	player.balas = {}
	player.limite = 20
	player.numero_de_balas = 3
	player.tempo_de_recarga = 0
end

-- Atualizando as propriedades do Objeto Player
function player.update(dt)

	player.limite = player.limite - 1
	player.tempo_de_recarga = player.tempo_de_recarga + 0.01
	player.tempo_restante = player.tempo_restante - 0.01

	if player.numero_de_balas < 3 and player.tempo_de_recarga > 3 then
		player.numero_de_balas = player.numero_de_balas + 1
		player.tempo_de_recarga = 0

	end

	for i,b in ipairs(player.balas) do
		if b.y < 0 then
			table.remove(player.balas, i)
		end

		b.y = b.y - 10
	end

	if love.keyboard.isDown(" ") then
		player.atirar()

	end

	mover(dt)

	verificar_colisao_entre_combustivel_e_player()
	verificar_colisao_lateral()
	verificar_colisao_entre_foguete_e_meteoro()
	verificar_gameover()
end

-- Desenhando o Player
function player.draw()
	love.graphics.setBackgroundColor(0, 12, 24)
	love.graphics.setFont(player.fonte)

	love.graphics.draw(player.imagem, player.x, player.y)

	love.graphics.draw(player.icone_de_bateria, 10, 25)
	love.graphics.print(player.score, 70, 25)

	love.graphics.print(string.format("%.2f", player.tempo_restante), 270, 25)

	love.graphics.draw(player.icone_de_bala, 500, 25)
	love.graphics.print(player.numero_de_balas, 550, 25)

	for _,b in pairs(player.balas) do
		love.graphics.draw(b.imagem, b.x, b.y)
	end
end
