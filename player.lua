
player = {}

-- Carrengando propriedades do Objeto Player
function player.load()
	player.tiro = love.audio.newSource("/sons/shoot.wav")
	player.musica = love.audio.newSource("/sons/music.mp3")
	player.battery_icon = love.graphics.newImage("/imagens/battery-icon.png")
	player.bullet_icon = love.graphics.newImage("/imagens/bullet-icon.png")
	player.imagem = love.graphics.newImage("/imagens/rocket.png")
	player.x = love.window.getWidth()/2 - 30
	player.y = love.window.getHeight() - 100
	player.speed = 5
	player.largura = player.imagem:getWidth()
	player.altura = player.imagem:getHeight()
	player.score = 0
	player.fonte = love.graphics.newFont("/fontes/sofachro.ttf", 30)
	player.tempo_restante = 10

	player.balas = {}
	player.limite = 20
	player.numero_de_balas = 3
	player.tempo_de_recarga = 0

	love.audio.play(player.musica)

end

-- Verificando colisao laterais
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

-- Verificando se o tempo está acabando
function verificar_tempo()
	if player.tempo_restante <= 5 then
		return true
	else
		return false
	end
end

function verificar_colisao()
	for i,c in ipairs(combustivel.tabela) do
		-- Verificando colisoes entre Foguete e Combustivel
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


-- Verificando se o tempo está acabando
function verificar_tempo()
	if player.tempo_restante <= 5 then
		return true
	else
		return false
	end
end

function verificar_colisao_entre_foguete_e_meteoro()
	for i,c in ipairs(meteoro.tabela) do
		-- Verificando colisoes entre Foguete e Meteoro
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




function player.move(dt)

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

function verificar_gameover()
	if player.tempo_restante <= 0 then
		GAME_MENU =  false
		GAME_RUNNING = false
		GAME_STOPPING = false
		GAME_OVERRING = true
	end
end

function inserir_bala_na_tabela()

	if player.limite <= 0 then
		if player.numero_de_balas > 0 then
			love.audio.play(player.tiro)
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

function player.update(dt)
	player.limite = player.limite - 1
	player.tempo_de_recarga = player.tempo_de_recarga + 0.01

	if player.numero_de_balas < 3 and player.tempo_de_recarga >= 5.00 then
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
		inserir_bala_na_tabela()
	end



	verificar_colisao_lateral()
	verificar_colisao_entre_foguete_e_meteoro()

	player.tempo_restante = player.tempo_restante - 0.01

	verificar_colisao()
	player.move(dt)

	verificar_gameover()
end

function player.draw()
	love.graphics.setBackgroundColor(0, 12, 24)

	love.graphics.draw(player.battery_icon, 10, 25)

	love.graphics.setFont(player.fonte)

	love.graphics.print(player.score, 70, 25)

	love.graphics.draw(player.imagem, player.x, player.y)

	love.graphics.print(string.format("%.2f", player.tempo_restante), 270, 25)

	love.graphics.print(player.numero_de_balas, 550, 25)
	love.graphics.draw(player.bullet_icon, 500, 25)

	for _,b in pairs(player.balas) do
		love.graphics.draw(b.imagem, b.x, b.y)
	end
end
