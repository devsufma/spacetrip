require "conf"
require "tela"
require "menu"
require "player"
require "combustivel"
require "meteoro"
require "alienigena"
require "mensagem"

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
				love.graphics.setBackgroundColor(0, 12, 24)
				love.graphics.print("Game Over", 150, 250)
			end
		end
	end
end

function love.keypressed(key)
   if key == "s" then
    GAME_MENU = false
		GAME_RUNNING = true
		GAME_STOPPING = false
		GAME_OVERRING = false
		mostrar_mensagem("VAI", 160, 300, 80)
   end
end
