local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

local CanopyLights = script.Parent.Parent.Parent:GetChildren()

local Panel = script.Parent.Parent.Panel
local BrokenPanel = script.Parent.Parent.BrokenPanel
local ThickRoof = script.Parent.Parent.Parent.ThickRoof
local InUse = script.Parent.InUse

local function setLights(turnOff)
	if turnOff then
		for _, lights in pairs(CanopyLights) do
			if string.find(lights.Name:lower(), "canopylight") then
				lights.Main.Material = Enum.Material.Glass
				lights.Main.SurfaceLight.Enabled = false
			end
		end
		for i,v in ThickRoof:GetChildren() do
			v.Transparency = 0
		end
	else
		for _, lights in pairs(CanopyLights) do
			if string.find(lights.Name:lower(), "canopylight") then
				lights.Main.Material = Enum.Material.Neon
				lights.Main.SurfaceLight.Enabled = true
			end
		end
		for i,v in ThickRoof:GetChildren() do
			v.Transparency = 1
		end
	end
end

local function setBrokenDoor()
	for _, child in pairs(Panel:GetDescendants()) do
		if child:IsA("Part") or child:IsA("Decal") then
			child.Transparency = 1
		end
	end
	
	Panel.DecalBlock.Emitter.Enabled = true
	
	for _, child in pairs(BrokenPanel:GetDescendants()) do
		if child:IsA("Part") or child:IsA("Decal") then
			child.Transparency = 0
		end
	end
end

local function fixDoor()
	for _, child in pairs(Panel:GetDescendants()) do
		if child:IsA("Part") or child:IsA("Decal") then
			child.Transparency = 0
		end
	end

	Panel.DecalBlock.Emitter.Enabled = false

	for _, child in pairs(BrokenPanel:GetDescendants()) do
		if child:IsA("Part") or child:IsA("Decal") then
			child.Transparency = 1
		end
	end
end

script.Parent.KnifeHit.Event:Connect(function()
	if not InUse.Value then
		InUse.Value = true
		
		BrokenPanel.Center.Zap:Play()
		BrokenPanel.Center.Hit:Play()
		
		setBrokenDoor()
		setLights(true)
		
		task.wait(35)
		
		setLights(false)
		fixDoor()
		
		wait(145)
		
		InUse.Value = false
	end
end)