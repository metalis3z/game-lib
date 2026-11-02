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

		if not script.Parent:GetAttribute("Durability") then
			if module[script.Parent.Name].Durability then
				script.Parent:SetAttribute("Durability", module[script.Parent.Name].Durability or Custom.Durability)
			end
		end

		if not script.Parent:GetAttribute("DurabilityMax") then
			if module[script.Parent.Name].DurabilityMax then
				script.Parent:SetAttribute("DurabilityMax", module[script.Parent.Name].DurabilityMax or Custom.DurabilityMax)
			end
		end

		if not script.Parent:GetAttribute("Interactable") then
			if module[script.Parent.Name].Interactable then
				script.Parent:SetAttribute("Interactable", module[script.Parent.Name].Interactable or Custom.Interactable)
			end
		end

		if not script.Parent:GetAttribute("ToolOffset") then
			if module[script.Parent.Name].ToolOffset then
				script.Parent:SetAttribute("ToolOffset", module[script.Parent.Name].ToolOffset or Custom.ToolOffset)
			end
		end
	end
end

repeat task.wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local Humanoid = script.Parent.Parent:WaitForChild("Humanoid")
local PlayIdle = false
local DB = false
local DB2 = true
local AnimationsFolder = script.Parent.Animations
local Hold = Humanoid:LoadAnimation(AnimationsFolder.idle)
local Open = Humanoid:LoadAnimation(AnimationsFolder.open)
local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)

Hold.Priority = Enum.AnimationPriority.Action

function open()
	game.Workspace.GameSettings.Fires.VitaminsUse:Fire(player.Name)
end

script.Parent.Activated:Connect(function(player)
	if DB == false then
		DB = true
		open()
		DB = false
	end
end)

script.Parent.Equipped:Connect(function()
	Hold:Play()
end)

script.Parent.Unequipped:Connect(function()
	Hold:Stop()
end)

script.Parent.Used.Changed:Connect(function()
	if script.Parent.Used.Value == true then
		Hold:Stop()
	end
end)
