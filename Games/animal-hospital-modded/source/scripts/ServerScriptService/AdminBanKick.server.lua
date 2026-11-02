--[[ AdminBanKick — /kick y /ban en el chat, SOLO para "thehalconyt1" (mismo
     patron hardcodeado que TrollFreeAdmin: no depende de HD Admin ni de
     ninguna lista de admins compartida, exclusivo, nadie mas lo puede usar).

       /kick <nombre>  -> saca al jugador del server, NO lo banea (puede
                          volver a entrar de inmediato).
       /ban <nombre>   -> lo saca Y lo banea para siempre (persistente en
                          DataStore); si intenta reentrar, se lo rechaza
                          apenas se une.
       /unban <nombre> -> revierte un ban (por si te equivocaste; el nombre
                          no tiene que estar online).

     OJO: los DataStore no funcionan en Studio salvo que actives "Enable
     Studio Access to API Services" (Game Settings > Security) -- en el
     juego publicado esto no hace falta, siempre funciona. ]]
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local OWNER_NAME = "thehalconyt1"
local banStore = DataStoreService:GetDataStore("BannedUsers_v1")

local function findOnlineTarget(nameFragment)
	nameFragment = nameFragment:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == nameFragment then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #nameFragment) == nameFragment then return p end
	end
	return nil
end

local function isBanned(userId)
	local ok, banned = pcall(function()
		return banStore:GetAsync("u_" .. userId)
	end)
	return ok and banned == true
end

local function setBanned(userId)
	pcall(function() banStore:SetAsync("u_" .. userId, true) end)
end

local function clearBanned(userId)
	pcall(function() banStore:RemoveAsync("u_" .. userId) end)
end

local function handleChat(player, msg)
	if player.Name ~= OWNER_NAME then return end

	local cmd, arg = msg:match("^(/%a+)%s+(.+)$")
	cmd = cmd and cmd:lower()
	if cmd ~= "/kick" and cmd ~= "/ban" and cmd ~= "/unban" then return end
	arg = arg and arg:match("^%s*(.-)%s*$") -- recorta espacios
	if not arg or arg == "" then return end

	if cmd == "/unban" then
		local ok, userId = pcall(function()
			return Players:GetUserIdFromNameAsync(arg)
		end)
		if ok and userId then
			clearBanned(userId)
			print("[AdminBanKick] " .. player.Name .. " desbaneo a " .. arg)
		end
		return
	end

	local target = findOnlineTarget(arg)
	if not target or target == player then return end -- no te podes kickear/banear a vos mismo

	if cmd == "/kick" then
		target:Kick("Fuiste expulsado por " .. player.Name .. ".")
	elseif cmd == "/ban" then
		setBanned(target.UserId)
		target:Kick("Fuiste BANEADO por " .. player.Name .. ".")
	end
end

local function hookPlayer(player)
	if isBanned(player.UserId) then
		player:Kick("Estas baneado de este juego.")
		return
	end
	player.Chatted:Connect(function(msg)
		handleChat(player, msg)
	end)
end

Players.PlayerAdded:Connect(hookPlayer)
for _, p in ipairs(Players:GetPlayers()) do task.spawn(hookPlayer, p) end
