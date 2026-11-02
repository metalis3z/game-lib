local Tool = script.Parent

local Mouse_Icon = "rbxasset://textures/GunCursor.png"
local Reloading_Icon = "rbxasset://textures/GunWaitCursor.png"

local CurrentMouse = nil

local function UpdateIcon()
	if CurrentMouse then
		CurrentMouse.Icon = Tool.Enabled and Mouse_Icon or Reloading_Icon
	end
end

local function OnEquipped(mouse)
	CurrentMouse = mouse
	UpdateIcon()
end

local function OnChanged(property)
	if property == "Enabled" then
		UpdateIcon()
	end
end

Tool.Equipped:Connect(OnEquipped)
Tool.Changed:Connect(OnChanged)