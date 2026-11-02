-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")

if not (UserInputService.GamepadEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) and true or false) then
	return
end

local v2 = script.Parent

local function updateGamepad() --[[ updateGamepad | Line: 12 | Upvalues: v2 (copy), GamepadService (copy) ]]
	if #v2:GetChildren() == 2 then
		GamepadService:DisableGamepadCursor()
	else
		GamepadService:EnableGamepadCursor((v2:FindFirstChildWhichIsA("Frame")))
	end
end

v2.ChildAdded:Connect(function() --[[ Line: 22 | Upvalues: v2 (copy), GamepadService (copy) ]]
	if #v2:GetChildren() == 2 then
		GamepadService:DisableGamepadCursor()
	else
		GamepadService:EnableGamepadCursor((v2:FindFirstChildWhichIsA("Frame")))
	end
end)
v2.ChildRemoved:Connect(function() --[[ Line: 26 | Upvalues: v2 (copy), GamepadService (copy) ]]
	if #v2:GetChildren() == 2 then
		GamepadService:DisableGamepadCursor()
	else
		GamepadService:EnableGamepadCursor((v2:FindFirstChildWhichIsA("Frame")))
	end
end)