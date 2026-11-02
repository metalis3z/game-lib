-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local CurrentCamera = workspace.CurrentCamera

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 4 | Upvalues: CurrentCamera (ref) ]]
	CurrentCamera = workspace.CurrentCamera
end)

return function(p1, p2) --[[ Line: 8 | Upvalues: UserInputService (copy), GuiService (copy), CurrentCamera (ref) ]]
	local v1 = UserInputService:GetMouseLocation()
	local v2 = GuiService:GetGuiInset()
	local v3 = CurrentCamera:ScreenPointToRay(v1.X + v2.X, v1.Y - v2.Y)

	return workspace:Raycast(v3.Origin, v3.Direction * (p2 or 1000), p1)
end