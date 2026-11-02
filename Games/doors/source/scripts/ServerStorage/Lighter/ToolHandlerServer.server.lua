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
local HoldClose = Humanoid:LoadAnimation(AnimationsFolder.idleclosed)
local Hold = Humanoid:LoadAnimation(AnimationsFolder.idle)
local Open = Humanoid:LoadAnimation(AnimationsFolder.open)
local Close = Humanoid:LoadAnimation(AnimationsFolder.close)
local Relight = Humanoid:LoadAnimation(AnimationsFolder.relight)

Open.Priority = Enum.AnimationPriority.Action2
Hold.Priority = Enum.AnimationPriority.Action
HoldClose.Priority = Enum.AnimationPriority.Action
Close.Priority = Enum.AnimationPriority.Action2
Relight.Priority = Enum.AnimationPriority.Action3

local Opened = false
local Equipped = false
local Stop = false

function Flick(v1)
	
	if not v1 then
		return
	end
	
	if v1 == 1 then
		for i = 1, 1 do
			script.Parent.EffectsHolder.AttachOff.Flick:Emit(1)
			script.Parent.Handle.sound_flick:Play()
			Relight:Play()
		end
		wait(Relight.Length)
	elseif v1 == 2 then
		for i = 1, 2 do
			script.Parent.EffectsHolder.AttachOff.Flick:Emit(1)
			script.Parent.Handle.sound_flick:Play()
			Relight:Play()
			wait(Relight.Length - 0.1)
		end
		wait(Relight.Length - 0.35)
	end
	
end

function Light()
	if not DB and DB2 then
		Opened = true

		DB = true
		DB2 = false
		
		script.Parent:SetAttribute("Enabled", true)
		Stop = false
		
		if script.Parent:GetAttribute("Durability") < 20 then
			Flick(2)
		else
			if script.Parent:GetAttribute("Durability") < 40 then
				Flick(1)
			end
		end
		
		Open:Play()
		script.Parent.Handle.sound_open:Play()
		script.Parent.EffectsHolder.AttachOn.SparkParticles.Enabled = true
		script.Parent.EffectsHolder.AttachOn.SparkParticles.Enabled = false
		script.Parent.EffectsHolder.AttachOn.MainLight.Enabled = true
		script.Parent.EffectsHolder.AttachOn.SmallLight.Enabled = true
		script.Parent.EffectsHolder.AttachOn.SmallLight2.Enabled = true
		script.Parent.EffectsHolder.AttachOn.SmallLight3.Enabled = true
		--script.Parent.EffectsHolder.AttachOn.FireParticles.Enabled = true
		task.wait(Open.Length)
		Hold:Play()
		HoldClose:Stop()
		PlayIdle = true
		task.wait(1.1)
		DB2 = true
	elseif DB and DB2 then
		Opened = false
		
		script.Parent:SetAttribute("Enabled", false)
		Stop = true
		
		DB = false
		DB2 = false
		Close:Play()
		script.Parent.Handle.sound_close:Play()
		script.Parent.EffectsHolder.AttachOff.Flick.Enabled = true
		script.Parent.EffectsHolder.AttachOff.SmokeOff.Enabled = true
		script.Parent.EffectsHolder.AttachOff.Flick.Enabled = false
		script.Parent.EffectsHolder.AttachOff.SmokeOff.Enabled = false
		script.Parent.EffectsHolder.AttachOn.MainLight.Enabled = false
		script.Parent.EffectsHolder.AttachOn.SmallLight.Enabled = false
		script.Parent.EffectsHolder.AttachOn.SmallLight2.Enabled = false
		script.Parent.EffectsHolder.AttachOn.SmallLight3.Enabled = false
		--script.Parent.EffectsHolder.AttachOn.FireParticles.Enabled = false
		task.wait(Close.Length)
		Hold:Stop()
		HoldClose:Play()
		PlayIdle = false
		task.wait(1.1)
		DB2 = true
	end
end

script.Parent.Activated:Connect(function()
	Light()
end)

script.Parent.Remote.OnServerEvent:Connect(function()
	Light()
end)

script.Parent.Equipped:Connect(function()
	Equipped = true
	
	Hold:Stop()
	HoldClose:Play()
	
	if Equipped == true and Opened == true then
		script.Parent:SetAttribute("Enabled", true)
		Stop = false
	end
end)

script.Parent.Unequipped:Connect(function()
	Equipped = false
	
	Open:Stop()
	Close:Stop()
	Hold:Stop()
	HoldClose:Stop()
	
	Opened = false

	DB = false
	DB2 = false
	script.Parent.EffectsHolder.AttachOff.Flick.Enabled = true
	script.Parent.EffectsHolder.AttachOff.SmokeOff.Enabled = true
	script.Parent.EffectsHolder.AttachOff.Flick.Enabled = false
	script.Parent.EffectsHolder.AttachOff.SmokeOff.Enabled = false
	script.Parent.EffectsHolder.AttachOn.MainLight.Enabled = false
	script.Parent.EffectsHolder.AttachOn.SmallLight.Enabled = false
	script.Parent.EffectsHolder.AttachOn.SmallLight2.Enabled = false
	script.Parent.EffectsHolder.AttachOn.SmallLight3.Enabled = false
	--script.Parent.EffectsHolder.AttachOn.FireParticles.Enabled = false
	PlayIdle = false
	DB2 = true

	script.Parent:SetAttribute("Enabled", false)
	Stop = true
end)

script.Parent.Used.Changed:Connect(function()
	if script.Parent.Used.Value == true then
		Open:Stop()
		Close:Stop()
		Hold:Stop()
		HoldClose:Stop()
	end
end)

while task.wait(1) do

	if Equipped == false then

		Open:Stop()
		Close:Stop()
		Hold:Stop()
		HoldClose:Stop()

	end

	if script.Parent:GetAttribute("Enabled", true) then
		if Stop == false then
			if Stop == true then

			else
				if script.Parent:GetAttribute("Durability") < 2 then
					Hold:Stop()
					HoldClose:Stop()
					Close:Stop()
					Open:Stop()
					script.Parent:Destroy()

				else
					script.Parent.EffectsHolder.AttachOn.FireParticles:Emit(2)
					script.Parent:SetAttribute("Durability", script.Parent:GetAttribute("Durability") - 1)
				end
			end
		end
	end
end