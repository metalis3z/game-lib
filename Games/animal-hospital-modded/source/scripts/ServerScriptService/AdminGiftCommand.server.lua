--[[
	AdminGiftCommand — regalar productos/pases a los jugadores desde el chat

	OJO con la palabra "gamepass": Roblox NO deja regalar un gamepass ni un
	DevProduct por script (no existe API para transferir compras; solo se puede
	ABRIR la ventana de compra al que paga). Lo que sí se puede — y es lo que
	hace esto — es ENTREGAR EL BENEFICIO gratis: corre exactamente el mismo
	handler que corre cuando alguien lo compra de verdad
	(GunService:GrantProduct), así el regalado queda igual que un comprador
	(atributos, rango de HD Admin, tools, persistencia en el perfil, etc.).

	COMANDOS (solo para los admins de ADMINS):
	  /give <jugador> <producto>    regala 1 producto
	  /give all <producto>          se lo regala a TODO el server
	  /gifts                        lista los productos regalables
	  /prompt <jugador> <producto>  le abre la ventana de compra real (por si
	                                querés que lo compre él, no regalarlo)

	El <jugador> acepta el nombre entero o el principio ("clara" -> Clarasigm1).
	El <producto> acepta la clave de Data.Prods (adminpanel, m4, sword...) o el
	id numérico del producto.

	Funciona con el chat nuevo (TextChatService, que es el que usa este juego) y
	deja también el fallback por Player.Chatted.
]]

-- Admin product gifting commands
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local Prods = require(ReplicatedStorage.Data.Prods)
local GunService = require(ServerScriptService:WaitForChild("GunService"))

-- Quién puede usar los comandos.
local ADMINS = {
	["goku_1565"] = true,
}

local OK_COLOR = Color3.fromRGB(120, 255, 150)
local ERR_COLOR = Color3.fromRGB(255, 120, 120)
local INFO_COLOR = Color3.fromRGB(150, 220, 255)

local function isAdmin(player)
	if ADMINS[player.Name] then return true end
	if player:GetAttribute("IsOwner") then return true end
	return false
end

local function notify(player, text, color)
	pcall(function()
		Network:FireClient(player, "Notify", text, color or INFO_COLOR)
	end)
	print(("[Gift] %s: %s"):format(player.Name, text))
end

-- "clara" -> Clarasigm1 · "all"/"todos" -> todos los jugadores
local function resolvePlayers(query)
	if not query or query == "" then return {} end
	local q = query:lower()
	if q == "all" or q == "todos" or q == "*" then
		return Players:GetPlayers()
	end
	local exact, partial
	for _, plr in ipairs(Players:GetPlayers()) do
		local name = plr.Name:lower()
		if name == q then
			exact = plr
			break
		elseif not partial and name:sub(1, #q) == q then
			partial = plr
		end
	end
	local found = exact or partial
	return found and { found } or {}
end

-- "adminpanel" / "m4" / numeric product ID -> ProductConfig entry
local function resolveProduct(query)
	if not query or query == "" then return nil end
	local asNumber = tonumber(query)
	if asNumber and Prods.ById[asNumber] then
		return Prods.ById[asNumber], tostring(asNumber)
	end
	local q = query:lower()
	for key, entry in pairs(Prods) do
		if type(key) == "string" and key:lower() == q then
			return entry, key
		end
	end
	-- por prefijo, para no tener que escribir el nombre entero
	for key, entry in pairs(Prods) do
		if type(key) == "string" and key:lower():sub(1, #q) == q then
			return entry, key
		end
	end
	return nil
end

-- Claves de Prods que TIENEN entrega registrada (las regalables de verdad).
local function grantableKeys()
	local ids = {}
	for _, id in ipairs(GunService:GetGrantableIds()) do
		ids[id] = true
	end
	local keys = {}
	for key, entry in pairs(Prods) do
		if type(key) == "string" and type(entry) == "table" and ids[entry.id] then
			keys[#keys + 1] = key
		end
	end
	table.sort(keys)
	return keys
end

--------------------------------------------------------------------------------
-- Comandos
--------------------------------------------------------------------------------
local function cmdGifts(player)
	local keys = grantableKeys()
	if #keys == 0 then
		notify(player, "No hay productos con entrega registrada todavia.", ERR_COLOR)
		return
	end
	notify(player, "Regalables: " .. table.concat(keys, ", "), INFO_COLOR)
end

local function cmdGive(player, targetQuery, productQuery)
	if not targetQuery or not productQuery then
		notify(player, "Uso: /give <jugador|all> <producto>   (/gifts para la lista)", ERR_COLOR)
		return
	end

	local targets = resolvePlayers(targetQuery)
	if #targets == 0 then
		notify(player, "No encontre al jugador '" .. targetQuery .. "'.", ERR_COLOR)
		return
	end

	local product, key = resolveProduct(productQuery)
	if not product then
		notify(player, "No existe el producto '" .. productQuery .. "'. Proba /gifts.", ERR_COLOR)
		return
	end

	local given, failed = {}, {}
	for _, target in ipairs(targets) do
		local ok = GunService:GrantProduct(target, product.id)
		if ok then
			given[#given + 1] = target.Name
			if target ~= player then
				notify(target, ("%s te regalo: %s"):format(player.Name, key), OK_COLOR)
			end
		else
			failed[#failed + 1] = target.Name
		end
	end

	if #given > 0 then
		notify(player, ("Regalado %s a: %s"):format(key, table.concat(given, ", ")), OK_COLOR)
	end
	if #failed > 0 then
		notify(player, ("No se pudo entregar %s a: %s (ese producto no tiene entrega registrada)")
			:format(key, table.concat(failed, ", ")), ERR_COLOR)
	end
end

local function cmdPrompt(player, targetQuery, productQuery)
	local targets = resolvePlayers(targetQuery)
	local product, key = resolveProduct(productQuery)
	if #targets == 0 or not product then
		notify(player, "Uso: /prompt <jugador|all> <producto>", ERR_COLOR)
		return
	end
	for _, target in ipairs(targets) do
		pcall(function()
			MarketplaceService:PromptProductPurchase(target, product.id)
		end)
	end
	notify(player, ("Ventana de compra de %s abierta a %d jugador(es)."):format(key, #targets), INFO_COLOR)
end

--------------------------------------------------------------------------------
-- Parseo del chat
--------------------------------------------------------------------------------
local function handle(player, message)
	if not player or not isAdmin(player) then return false end
	if type(message) ~= "string" or message:sub(1, 1) ~= "/" then return false end

	local args = {}
	for word in message:gmatch("%S+") do
		args[#args + 1] = word
	end

	local cmd = args[1]:lower()
	if cmd == "/give" or cmd == "/regalar" then
		cmdGive(player, args[2], args[3])
		return true
	elseif cmd == "/gifts" or cmd == "/regalos" then
		cmdGifts(player)
		return true
	elseif cmd == "/prompt" then
		cmdPrompt(player, args[2], args[3])
		return true
	end
	return false
end

-- Chat nuevo (TextChatService): comandos registrados de verdad, se disparan en
-- el server y aparecen en el autocompletado del chat.
local function makeCommand(name, alias)
	local cmd = Instance.new("TextChatCommand")
	cmd.Name = name
	cmd.PrimaryAlias = alias
	cmd.Parent = TextChatService
	cmd.Triggered:Connect(function(source, text)
		local player = source and source.UserId and Players:GetPlayerByUserId(source.UserId)
		if not player then return end
		if not isAdmin(player) then
			notify(player, "Ese comando es solo para admins.", ERR_COLOR)
			return
		end
		handle(player, text)
	end)
	return cmd
end

makeCommand("GiveProductCommand", "/give")
makeCommand("GiftListCommand", "/gifts")
makeCommand("PromptProductCommand", "/prompt")

-- Fallback por si el chat legacy sigue activo en alguna sesión.
local function hookPlayer(player)
	player.Chatted:Connect(function(message)
		handle(player, message)
	end)
end

Players.PlayerAdded:Connect(hookPlayer)
for _, player in ipairs(Players:GetPlayers()) do
	hookPlayer(player)
end

-- print("[AdminGiftCommand] listo — /give <jugador|all> <producto> · /gifts · /prompt")
