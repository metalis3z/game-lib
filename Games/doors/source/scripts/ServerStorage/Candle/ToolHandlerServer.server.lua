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

local character = script.Parent.Parent

local humanoid = character:FindFirstChild("Humanoid")
local l__TweenService__1 = game:GetService("TweenService");

local Hold = humanoid:LoadAnimation(script.Parent.Animations.idle)

local Equipped = false
local Stop = false
local Guided = false

function Blow()
	Guided = true
	Stop = true
	script.Parent.Handle.sound_blow:Play()
	local AttachOn = script.Parent.Candle.AttachOn:GetChildren()
	for i = 1, #AttachOn do
		AttachOn[i].Enabled = false
	end
	
	local AttachOff = script.Parent.Candle.AttachOff
	AttachOff.GuidingLightStuff:Emit(1)
	AttachOff.SmokeOff:Emit(1)
end

function Light()
	Guided = false
	Stop = false
	local AttachOn = script.Parent.Candle.AttachOn:GetChildren()
	for i = 1, #AttachOn do
		AttachOn[i].Enabled = true
	end
end

script.Parent.Equipped:Connect(function()
	
	
	if Guided == true then
		Blow()
		return
	else
		Light()
	end
	
	script.Parent.Handle.sound_open:Play()
	
	Equipped = true
	
	Hold:Play()
end)

script.Parent.Unequipped:Connect(function()
	
	Equipped = false
	Stop = true
	
	Hold:Stop()
end)

script.Parent.Used.Changed:Connect(function()
	if script.Parent.Used.Value == true then
		Hold:Stop()
	end
end)

while task.wait(1) do
	
	if Equipped == true and Stop == false then
		
		script.Parent:SetAttribute("Durability", script.Parent:GetAttribute("Durability") - 1)
		
	else
		Stop = true
		Hold:Stop()
	end
	
end