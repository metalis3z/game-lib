--credit to prince games studio
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local v1 = script.Parent

function UPD() --[[ UPD | Line: 6 | Upvalues: StarterGui (copy), v1 (copy), UserInputService (copy) ]]
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not v1.Enabled)

	local PlayerList = Enum.CoreGuiType.PlayerList

	StarterGui:SetCoreGuiEnabled(PlayerList, not v1.Enabled and not UserInputService.GamepadEnabled)
end
UPD()
v1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 15 ]]
	UPD()
end)