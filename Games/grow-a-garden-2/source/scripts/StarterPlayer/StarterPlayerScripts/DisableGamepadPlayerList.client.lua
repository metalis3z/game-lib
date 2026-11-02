--credit to quartz games studio
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local function IsConsole() --[[ IsConsole | Line: 15 | Upvalues: GuiService (copy), UserInputService (copy) ]]
	if GuiService:IsTenFootInterface() then
		return true
	end

	return UserInputService.GamepadEnabled and (not UserInputService.KeyboardEnabled and (not UserInputService.MouseEnabled and not UserInputService.TouchEnabled))
end

repeat
	local v1 = if GuiService:IsTenFootInterface() then true else UserInputService.GamepadEnabled and (not UserInputService.KeyboardEnabled and (not UserInputService.MouseEnabled and not UserInputService.TouchEnabled))

	if v1 then
		pcall(function() --[[ Line: 27 | Upvalues: StarterGui (copy) ]]
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
		end)
	end

	task.wait(0.5)
until not v1