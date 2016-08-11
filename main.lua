require "conf"
require "tela"
require "menu"
require "player"
require "planeta"
require "combustivel"
require "meteoro"
require "alienigena"

function love.load()
	tela.load()
	menu.load()
	player.load()
	combustivel.load()
	meteoro.load()
	alienigena.load()

end

function love.update(dt)
	player.update(dt)
	combustivel.update(dt)
	meteoro.update(dt)
	alienigena.update(dt)

end


function love.draw()
	if GAME_MENU then
		menu.draw()

		else if GAME_RUNNING then
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
   end
end
