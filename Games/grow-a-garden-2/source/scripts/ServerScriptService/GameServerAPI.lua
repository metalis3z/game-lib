--credit to leon games studio
--[[
	GameServerAPI
	Tabla compartida entre los Scripts del servidor reconstruido.
	GameServer la llena al arrancar (economía/estado); PlantService y otros
	la consumen. Usar WaitFor para esperar a que un campo exista.
]]

local api = {}

function api.WaitFor(fieldName: string)
	while api[fieldName] == nil do
		task.wait()
	end
	return api[fieldName]
end

return api