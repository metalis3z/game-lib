-- GiveableTools
-- Unica definicion de "que tools se pueden regalar desde el AdminPanel".
--
-- Lo usan el picker del cliente y el server que las entrega, para que la lista
-- que ves y la lista que se puede dar no se despeguen nunca: si el picker
-- ofrece algo que el server no encuentra, el boton Give no hace nada y parece
-- roto sin motivo.
--
-- Las Tool de HD Admin quedan afuera a proposito: son internas del pack y
-- viven en ServerScriptService, no en estas carpetas.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FOLDERS = { "Items", "Tools" }

local GiveableTools = {}

function GiveableTools.list()
	local tools = {}
	for _, folderName in ipairs(FOLDERS) do
		local folder = ReplicatedStorage:FindFirstChild(folderName)
		if folder then
			for _, child in ipairs(folder:GetChildren()) do
				if child:IsA("Tool") then
					table.insert(tools, child)
				end
			end
		end
	end
	table.sort(tools, function(a, b)
		return a.Name < b.Name
	end)
	return tools
end

-- Busca sin importar mayusculas, asi tambien vale escribir el nombre a mano.
function GiveableTools.find(name)
	if type(name) ~= "string" then
		return nil
	end
	local wanted = name:gsub("^%s+", ""):gsub("%s+$", ""):lower()
	if wanted == "" then
		return nil
	end
	for _, tool in ipairs(GiveableTools.list()) do
		if tool.Name:lower() == wanted then
			return tool
		end
	end
	return nil
end

return GiveableTools
