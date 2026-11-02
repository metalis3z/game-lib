local ItemService = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

assert(RunService:IsServer(), "ItemService must run on server")

local Demon = require(script:WaitForChild("Demon"))

local SPECIAL_PLAYER = "Benasouse" or "Abderrlol"

local function isValidCharacter(character)
	return character
		and character:IsA("Model")
		and character:FindFirstChildOfClass("Humanoid")
end

function ItemService.CursedSlap(targetCharacter: Model)
	if not isValidCharacter(targetCharacter) then return end
	Demon.Freeze(targetCharacter, 4)
end

function ItemService.DemonHead(targetCharacter: Model)
	if not isValidCharacter(targetCharacter) then return end

	Demon.Freeze(targetCharacter, 2)

	task.delay(1, function()
		if isValidCharacter(targetCharacter) then
			Demon.Launch(targetCharacter, 900)
		end
	end)
end

local function RemoveBat(player)
	if player.Name ~= SPECIAL_PLAYER then return end

	local backpack = player:WaitForChild("Backpack")

	local tool = backpack:FindFirstChild("Bat")
	if tool then
		tool:Destroy()
	end

	if player.Character then
		local charTool = player.Character:FindFirstChild("Bat")
		if charTool then
			charTool:Destroy()
		end
	end
end

local function GiveItems(player)
	if player.Name ~= SPECIAL_PLAYER then return end

	local backpack = player:WaitForChild("Backpack")

	for _, item in ipairs(script:GetChildren()) do
		if item ~= script then
			local clone = item:Clone()
			clone.Parent = backpack
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.5)
		RemoveBat(player)

		task.wait(0.5)
		GiveItems(player)
	end)
end)

return ItemService