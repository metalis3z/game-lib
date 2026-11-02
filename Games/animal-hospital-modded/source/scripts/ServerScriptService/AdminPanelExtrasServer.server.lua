--[[ AdminPanelExtrasServer — las dos filas nuevas del AdminPanel.
       · AdminGiveTool(targetName, toolName)  -> pone la Tool en el backpack del objetivo
       · AdminAddSanity(targetName, amount)   -> SUMA cordura al objetivo (acepta negativos)

     Mismo criterio de acceso que el resto del panel: el atributo OwnsAdminPanel,
     que pone MonetizationBuys al procesar la compra y restaura al reingresar.
     El cliente puede escribirselo localmente, pero eso no replica al server. ]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local GiveableTools = require(ReplicatedStorage.Modules.GiveableTools)
local SanityService = require(ServerScriptService:WaitForChild("SanityService"))

local MAX_SANITY = 100

local function isAdmin(player)
	return player:GetAttribute("OwnsAdminPanel") == true
end

-- Numero finito o nil (rechaza inf/nan/basura del cliente), igual que AdminActionsServer.
local function num(v)
	v = tonumber(v)
	if not v or v ~= v or v == math.huge or v == -math.huge then
		return nil
	end
	return v
end

--------------------------------------------------------------------------------
-- DAR TOOL
--------------------------------------------------------------------------------
-- Mismo criterio que MonetizationBuys.giveTool: al Backpack para usarla ya, y al
-- StarterGear para que le sobreviva al respawn. No duplica si ya la tiene.
Network:Connect("AdminGiveTool", function(player, targetName, toolName)
	if not isAdmin(player) then
		return
	end
	if typeof(targetName) ~= "string" or typeof(toolName) ~= "string" then
		return
	end

	local target = Players:FindFirstChild(targetName)
	if not target then
		return
	end

	local template = GiveableTools.find(toolName)
	if not template then
		return
	end

	local function has(container)
		return container and container:FindFirstChild(template.Name) ~= nil
	end

	local backpack = target:FindFirstChildOfClass("Backpack")
	if backpack and not has(backpack) and not has(target.Character) then
		template:Clone().Parent = backpack
	end

	local starterGear = target:FindFirstChildOfClass("StarterGear")
	if starterGear and not has(starterGear) then
		template:Clone().Parent = starterGear
	end
end)

--------------------------------------------------------------------------------
-- SUMAR CORDURA
--------------------------------------------------------------------------------
-- Va por SetSanity y no por GainSanity a proposito: GainSanity multiplica por
-- SanityImpactMultiplier (la clase Psychologist tiene x2), asi que escribir 25
-- le daria 50. Desde el panel el numero tiene que ser exacto.
-- SetSanity ya clampea 0..100 y mata al personaje si toca 0.
Network:Connect("AdminAddSanity", function(player, targetName, amount)
	if not isAdmin(player) then
		return
	end
	if typeof(targetName) ~= "string" then
		return
	end

	amount = num(amount)
	if amount == nil or amount == 0 then
		return
	end
	amount = math.clamp(amount, -MAX_SANITY, MAX_SANITY)

	local target = Players:FindFirstChild(targetName)
	if not target then
		return
	end

	local current = SanityService:GetSanity(target)
	SanityService:SetSanity(target, current + amount, "Admin")
end)
