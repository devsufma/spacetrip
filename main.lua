require "conf"
require "tela"
require "menu"
require "player"
require "combustivel"
require "meteoro"
require "alienigena"
require "mensagem"

-- Comecando o jogo
function comecar()
	GAME_MENU = false
	GAME_RUNNING = true
	GAME_STOPPING = false
	GAME_OVERRING = false
	mostrar_mensagem("VAI", 160, 300, 80)
end

-- Saindo do jogo
function sair()
	love.event.quit()
end

-- Reiniciando o jogo
function reiniciar()
	love.load()
	GAME_MENU = false
	GAME_RUNNING = true
	GAME_STOPPING = false
	GAME_OVERRING = false
	mostrar_mensagem("VAI", 160, 300, 80)
end

-- Pausando o jogo 
function pausar()
	if love.keyboard.isDown("escape") and not GAME_MENU and not GAME_OVERRING then
		GAME_MENU = false
		GAME_RUNNING = false
		GAME_STOPPING = true
		GAME_OVERRING = false

		else if love.keyboard.isDown("p") and GAME_STOPPING then
			GAME_MENU = false
			GAME_RUNNING = true
			GAME_STOPPING = false
			GAME_OVERRING = false
		end
	end
end

function love.load()
	tela.load()
	menu.load()
	player.load()
	combustivel.load()
	meteoro.load()
	alienigena.load()
	mensagem.load()
end

function love.update(dt)
	if love.keyboard.isDown("s") and GAME_MENU then
		comecar()
	end

	if love.keyboard.isDown("e") and (GAME_STOPPING or GAME_OVERRING) then
		sair()
	end

	if love.keyboard.isDown("r") and (GAME_STOPPING or GAME_OVERRING) then
		reiniciar()
	end

	pausar()

	if GAME_RUNNING then
		player.update(dt)
		combustivel.update(dt)
		meteoro.update(dt)
		alienigena.update(dt)
		mensagem.update(dt)
	end
end

function love.draw()
	if GAME_MENU then
		menu.draw()

		else if GAME_RUNNING then
			mensagem.draw()
			combustivel.draw()
			meteoro.draw()
			player.draw()
			alienigena.draw()

			else if GAME_OVERRING then
				love.graphics.setFont(fonte_titulo)
				love.graphics.print("Fim de Jogo", 50, 200)

				love.graphics.setFont(fonte_descricao)
				love.graphics.print("(R) Reiniciar", 220, 300)
				love.graphics.print("(E) Sair", 220, 350)
			
				else if GAME_STOPPING then
					love.graphics.setFont(fonte_titulo)
					love.graphics.print("Jogo", 200, 200)
					love.graphics.print("Pausado", 90, 250)

					love.graphics.setFont(fonte_descricao)
					love.graphics.print("(P) Voltar ao Jogo", 170, 350)
					love.graphics.print("(R) Reiniciar", 170, 400)
					love.graphics.print("(E) Sair", 170, 450)
					
				end
			end
		end
	end
end
