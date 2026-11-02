local module = require(game.ServerScriptService.Game.Directory.ItemsAttributes)
--local v5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));

local Custom = {
	Durability = 45,
	DurabilityMax = 90,
	Interactable = true,
	ToolOffset = Vector3.new(0, 0, 0)
}

if module[script.Parent.Name] then

	if module[script.Parent.Name].CanUsing == true then
		script.Parent:SetAttribute("Enabled", false)
	end

	for v7, v8 in pairs(module) do

		if module[script.Parent.Name].Durability then
			script.Parent:SetAttribute("Durability", module[script.Parent.Name].Durability or Custom.Durability)
		end

		if module[script.Parent.Name].DurabilityMax then
			script.Parent:SetAttribute("DurabilityMax", module[script.Parent.Name].DurabilityMax or Custom.DurabilityMax)
		end

		if module[script.Parent.Name].Interactable then
			script.Parent:SetAttribute("Interactable", module[script.Parent.Name].Interactable or Custom.Interactable)
		end

		if module[script.Parent.Name].ToolOffset then
			script.Parent:SetAttribute("ToolOffset", module[script.Parent.Name].ToolOffset or Custom.ToolOffset)
		end
	end
end

repeat task.wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local Humanoid = script.Parent.Parent:WaitForChild("Humanoid")
local Idle = script.Parent.Animations.idle
local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
local IdleA = Humanoid:LoadAnimation(Idle)
local tool = script.Parent

tool.Equipped:Connect(function()
	local M6D = script.Parent.LeftHandle6D
	local M6DSPIN = Instance.new("Motor6D", script.Parent)
	M6DSPIN.Name = "M6DSPIN"
	M6DSPIN.Part0 = tool.Parent:FindFirstChild("RightHand")
	M6DSPIN.Part1 = script.Parent.Handle
	M6D.Part0 = tool.Parent:FindFirstChild("LeftHand")
	IdleA:Play()
end)

tool.Unequipped:Connect(function()
	if script.Parent:FindFirstChild("M6DSPIN") then
		script.Parent.M6DSPIN:Destroy()
	end
	if script.Parent:FindFirstChild("LeftHandleM6D") then
		script.Parent.LeftHandle6D.Part0 = nil
	end
	IdleA:Stop()
end)

script.Parent.Used.Changed:Connect(function()
	if script.Parent.Used.Value == true then
		IdleA:Stop()
	end
end)

while true do
	wait(0.5)
	if script.Parent:GetAttribute("Durability") == 0 then
		IdleA:Stop()
		game.ReplicatedStorage.Bricks.Caption:FireClient(player, 'Your lockpicks are over')
		script.Parent:Destroy()
	end
end