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
local PlayIdle = false
local DB = false
local DB2 = true
local AnimationsFolder = script.Parent.Animations

local HoldClose = Humanoid:LoadAnimation(AnimationsFolder.idleclosed)
local Hold = Humanoid:LoadAnimation(AnimationsFolder.idle)
local Open = Humanoid:LoadAnimation(AnimationsFolder.open)
local Close = Humanoid:LoadAnimation(AnimationsFolder.close)
local Relight = Humanoid:LoadAnimation(AnimationsFolder.relight)
local Enable = Humanoid:LoadAnimation(AnimationsFolder.quicktoggle)

Enable.Priority = Enum.AnimationPriority.Action2
Open.Priority = Enum.AnimationPriority.Action2
Hold.Priority = Enum.AnimationPriority.Action
HoldClose.Priority = Enum.AnimationPriority.Action
Close.Priority = Enum.AnimationPriority.Action2
Relight.Priority = Enum.AnimationPriority.Action3

local Opened = false
local Equipped = false
local Stop = false

local Clore

function Flick(v1)
	
	if not v1 then
		return
	end
	
	if v1 == 1 then
		for i = 1, 1 do
			script.Parent.Handle.Glass.Attachment.Flick:Emit(1)
			script.Parent.Handle.sound_flick:Play()
			Relight:Play()
		end
		wait(Relight.Length)
	elseif v1 == 2 then
		for i = 1, 2 do
			script.Parent.Handle.Glass.Attachment.Flick:Emit(1)
			script.Parent.Handle.sound_flick:Play()
			Relight:Play()
			wait(0.35)
		end
		wait(Relight.Length)
	elseif v1 == 3 then
		for i = 1, 3 do
			script.Parent.Handle.Glass.Attachment.Flick:Emit(1)
			script.Parent.Handle.sound_flick:Play()
			Relight:Play()
			wait(0.35)
		end
		wait(Relight.Length)
	end
end

function Light()
	if not DB and DB2 then

		Opened = true

		DB = true
		DB2 = false
		if script.Parent:GetAttribute("Durability") < 20 then
			Flick(2)
		else
			if script.Parent:GetAttribute("Durability") < 40 then
				Flick(1)
			end
		end

		Enable:Play()
		Hold:Play()
		script.Parent.Handle.sound_open:Play()
		script.Parent.Handle.Neon.PointLight.Enabled = true
		script.Parent.Handle.Neon.AttachmentStart.SpotLight.Enabled = true
		--script.Parent.Handle.Neon.AttachmentStart.Shiny.Enabled = true
		script.Parent.Handle.Neon.LightAttach.SurfaceLight.Enabled = true
		task.wait(Open.Length + 0.1)
		PlayIdle = true
		DB2 = true

		script.Parent:SetAttribute("Enabled", true)
		Stop = false
	elseif DB and DB2 then

		Opened = false

		DB = false
		DB2 = false
		Enable:Play()
		Hold:Play()
		script.Parent.Handle.sound_close:Play()
		script.Parent.Handle.Neon.PointLight.Enabled = false
		script.Parent.Handle.Neon.AttachmentStart.SpotLight.Enabled = false
		--script.Parent.Handle.Neon.AttachmentStart.Shiny.Enabled = false
		script.Parent.Handle.Neon.LightAttach.SurfaceLight.Enabled = false
		task.wait(Open.Length + 0.1)
		PlayIdle = false
		DB2 = true

		script.Parent:SetAttribute("Enabled", false)
		Stop = true
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
	
	Hold:Play()
	
	if Equipped == true and Opened == true then
		script.Parent:SetAttribute("Enabled", true)
		Stop = false
	end
end)

script.Parent.Unequipped:Connect(function()
	Equipped = false
	HoldClose:Stop()
	Close:Stop()
	Open:Stop()
	Enable:Stop()
	
	Opened = false

	DB = false
	DB2 = false
	Hold:Stop()
	script.Parent.Handle.Neon.PointLight.Enabled = false
	script.Parent.Handle.Neon.AttachmentStart.SpotLight.Enabled = false
	script.Parent.Handle.Neon.AttachmentStart.Shiny.Enabled = false
	script.Parent.Handle.Neon.LightAttach.SurfaceLight.Enabled = false
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
		Enable:Stop()

	end

	if script.Parent:GetAttribute("Enabled") == true then
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
					script.Parent.Handle.Neon.AttachmentStart.Shiny:Emit(1)
					script.Parent:SetAttribute("Durability", script.Parent:GetAttribute("Durability") - 1)
				end
			end
		end
	end
end