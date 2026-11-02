--credit to quartz games studio
--[[
	CmdrPetCommands  (server)
	Reconstrucción de la capa servidor del comando Cmdr "dar pets".

	El dump solo trae las DEFINICIONES de los comandos (cliente, para autocompletar);
	el lado servidor de Cmdr (registro + funciones Run) nunca se exportó, así que
	ningun comando se ejecutaba. En vez de revivir todo el dispatch servidor de Cmdr
	(frágil y duplicaría ReplicatedStorage.CmdrClient), los comandos givepet/givepettool
	usan ClientRun (corre en el cliente) y disparan este RemoteEvent. Aquí validamos
	que el invocador sea admin y concedemos la pet con GameServerAPI.AddPet.
]]

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")
local RunService        = game:GetService("RunService")

local GameServerAPI = require(ServerScriptService.GameServerAPI)
local PetModulesFolder = ReplicatedStorage.SharedModules:WaitForChild("PetModules")

-- Mismo allowlist que StarterPlayerScripts.Controllers.CMDRController
local ADMIN_IDS = {
	[5073759] = true, [71552399] = true,   [8095632868] = true, [1755750680] = true,
	[355661302]  = true, [9568431755] = true, [1787623041] = true, [6785965]    = true,
	[4925297398] = true, [1848784060] = true, [1836038679] = true, [7805349940] = true,
	[1833666230] = true, [2882755487] = true, [2213470865] = true, [5455502981] = true,
	[95217455]   = true,
}

local function isAllowed(player: Player): boolean
	if RunService:IsStudio() then return true end
	if ADMIN_IDS[player.UserId] then return true end
	return game.PlaceId == 1
end

-- Un nombre de pet válido es un hijo de PetModules (igual que el tipo Cmdr "pet")
local function validPet(name): boolean
	return type(name) == "string" and PetModulesFolder:FindFirstChild(name) ~= nil
end

local event = ReplicatedStorage:FindFirstChild("CmdrGivePet")
if not event then
	event = Instance.new("RemoteEvent")
	event.Name = "CmdrGivePet"
	event.Parent = ReplicatedStorage
end

event.OnServerEvent:Connect(function(caller: Player, targets, petName, amount)
	if not isAllowed(caller) then
		warn(("[CmdrPetCommands] %s no es admin; givepet rechazado"):format(caller.Name))
		return
	end
	if not validPet(petName) then
		warn(("[CmdrPetCommands] pet inválida: %s"):format(tostring(petName)))
		return
	end

	amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 1000)

	-- targets puede venir como tabla de Players o un solo Player
	if typeof(targets) == "Instance" then
		targets = { targets }
	end
	if type(targets) ~= "table" then
		return
	end

	local addPet = GameServerAPI.WaitFor("AddPet")

	for _, plr in ipairs(targets) do
		if typeof(plr) == "Instance" and plr:IsA("Player") then
			for _ = 1, amount do
				addPet(plr, petName)
			end
			print(("[CmdrPetCommands] %s dio %dx %s a %s"):format(caller.Name, amount, petName, plr.Name))
		end
	end
end)

print("[CmdrPetCommands] listo (handler de givepet/givepettool activo)")
