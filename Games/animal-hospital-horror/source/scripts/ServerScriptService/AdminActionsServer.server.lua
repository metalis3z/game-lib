--[[ AdminActionsServer — aplica las acciones del AdminPanel: Cash / Speed / Shift.
     Solo para dueños del panel (atributo OwnsAdminPanel). El cliente
     (StarterGui.AdminPanel.AdminPanel.AdminActionsClient) manda:
         Network:FireServer("AdminAction", action, mode, value)
       action = "cash" | "speed" | "shift"
       mode   = "add"  | "set"
       value  = number
]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local DataService = require(ServerScriptService:WaitForChild("DataService"))

local MIN_SPEED, MAX_SPEED = 0, 500
local MAX_CASH  = 1e12
local MAX_SHIFT = 9999

local function isAdmin(player)
	return player:GetAttribute("OwnsAdminPanel") == true
end

-- Convierte a número finito o devuelve nil (rechaza inf/nan/basura del cliente).
local function num(v)
	v = tonumber(v)
	if not v or v ~= v or v == math.huge or v == -math.huge then
		return nil
	end
	return v
end

--------------------------------------------------------------------------------
-- SPEED: se guarda en el atributo AdminWalkSpeed y se reaplica en cada respawn.
--------------------------------------------------------------------------------
local function applySpeed(player)
	local target = player:GetAttribute("AdminWalkSpeed")
	if typeof(target) ~= "number" then return end
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = target end
end

local function watchSpeed(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.3) -- deja que otros sistemas fijen su WalkSpeed primero
		applySpeed(player)
	end)
end
Players.PlayerAdded:Connect(watchSpeed)
for _, p in ipairs(Players:GetPlayers()) do watchSpeed(p) end

--------------------------------------------------------------------------------
-- SHIFT: usa ShiftService:GoToShift(n). La noche actual está en Players.Night.
--------------------------------------------------------------------------------
local function shiftService()
	local ok, s = pcall(require, ServerScriptService:WaitForChild("ShiftService", 5))
	return ok and s or nil
end

--------------------------------------------------------------------------------
Network:Connect("AdminAction", function(player, action, mode, value)
	if not isAdmin(player) then return end
	value = num(value)
	if value == nil then return end
	mode = (mode == "set") and "set" or "add"

	if action == "cash" then
		local stats = DataService:GetStats(player)
		local cur = (stats and stats.LocalCash) or 0
		local target = (mode == "set") and value or (cur + value)
		DataService:SetStat(player, "LocalCash", math.clamp(target, 0, MAX_CASH))

	elseif action == "speed" then
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local cur = (hum and hum.WalkSpeed) or player:GetAttribute("AdminWalkSpeed") or 16
		local target = math.clamp((mode == "set") and value or (cur + value), MIN_SPEED, MAX_SPEED)
		player:SetAttribute("AdminWalkSpeed", target)
		if hum then hum.WalkSpeed = target end

	elseif action == "shift" then
		local Shift = shiftService()
		if not (Shift and Shift.GoToShift) then return end
		local cur = Players:GetAttribute("Night") or 0
		local target = math.clamp(math.floor((mode == "set") and value or (cur + value)), 1, MAX_SHIFT)
		Shift:GoToShift(target)
	end
end)

--------------------------------------------------------------------------------
-- GIVE CASH: el admin le da Cash a un jugador OBJETIVO (por nombre exacto).
-- El cliente (GiveBrainrot) manda: Network:FireServer("AdminGiveCash", nombre, cantidad)
--------------------------------------------------------------------------------
Network:Connect("AdminGiveCash", function(player, targetName, amount)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	amount = num(amount)
	if amount == nil or amount <= 0 then return end
	local target = Players:FindFirstChild(targetName)
	if not target then return end
	local stats = DataService:GetStats(target)
	local cur = (stats and stats.LocalCash) or 0
	DataService:SetStat(target, "LocalCash", math.clamp(cur + amount, 0, MAX_CASH))
end)

print("[AdminActionsServer] listo — Cash / Speed / Shift / GiveCash enganchados")
