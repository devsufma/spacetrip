mensagem = {}

function mostrar_mensagem(texto, x, y, tamanho)
  vetor = {}

  vetor.fonte = love.graphics.newFont("/fontes/sofachro.ttf", tamanho)
  vetor.tempo_inicial = os.clock("%s")
  vetor.tempo_final = 0.2
  vetor.mensagem = texto
  vetor.x = x
  vetor.y = y

  table.insert(mensagem.tabela, vetor)
end

-- Carregando propriedades do Objeto
function mensagem.load()
	mensagem.tabela = {}
end

-- Atualizando propriedades do Objeto
function mensagem.update(dt)
	for i,p in ipairs(mensagem.tabela) do
		if os.clock("%s") - p.tempo_inicial >= p.tempo_final then
		 table.remove(mensagem.tabela, i)
		end
	end
end

-- Desenhando mensagens na tela
function mensagem.draw()
	if table.getn(mensagem.tabela) >= 0 then
		for i,p in pairs(mensagem.tabela) do
      		love.graphics.setFont(p.fonte)
			love.graphics.print(p.mensagem, p.x, p.y)
		end
	end
 end
