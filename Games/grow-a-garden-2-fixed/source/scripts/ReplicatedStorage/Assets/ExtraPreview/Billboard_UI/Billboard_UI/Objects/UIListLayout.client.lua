--credit to leon games studio
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Device = require(ReplicatedStorage.ClientModules.Device)
local v1 = if UserInputService.GamepadEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) then true else false

local function updateSpacing() --[[ updateSpacing | Line: 13 | Upvalues: UserInputService (copy) ]]
	local UIListLayout = script.Parent:FindFirstChildOfClass("UIListLayout")

	if not UIListLayout then
		return
	end

	UIListLayout.Padding = if UserInputService.PreferredInput == Enum.PreferredInput.Touch then UDim.new(0.035, 0) else UDim.new(0, 0)
end

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateSpacing)
task.spawn(updateSpacing)

if v1 == true then
	function upd() --[[ upd | Line: 24 | Upvalues: GamepadService (copy) ]]
		if #script.Parent:GetChildren() == 2 then
			GamepadService:DisableGamepadCursor()
		else
			GamepadService:EnableGamepadCursor(script.Parent:FindFirstChildWhichIsA("Frame"))
		end
	end
	script.Parent.ChildAdded:Connect(upd)
	script.Parent.ChildRemoved:Connect(upd)
end

local function onChildAdded(p1) --[[ onChildAdded | Line: 36 | Upvalues: Device (copy), GuiService (copy) ]]
	if not p1:IsA("Frame") then
		return
	end

	local Frame = p1:FindFirstChild("Frame")

	if not (Frame and Frame:IsA("GuiObject")) then
		return
	end

	local ImageButton = Frame:FindFirstChild("ImageButton")

	if ImageButton and ImageButton:IsA("GuiButton") then
		p1.MouseEnter:Connect(function() --[[ Line: 51 | Upvalues: Device (ref), ImageButton (copy), GuiService (ref) ]]
			if Device:GetCurrentDevice() ~= "Gamepad" then
				return
			end

			if ImageButton.Parent ~= nil then
				GuiService.SelectedObject = ImageButton
			end
		end)
		ImageButton.Selectable = false
	end
end

script.Parent.ChildAdded:Connect(onChildAdded)

for v2, v3 in script.Parent:GetChildren() do
	task.spawn(onChildAdded, v3)
end