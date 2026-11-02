-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CurrentCamera = workspace.CurrentCamera

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 2 | Upvalues: CurrentCamera (ref) ]]
	CurrentCamera = workspace.CurrentCamera
end)

return function(p1) --[[ Line: 6 | Upvalues: CurrentCamera (ref) ]]
	if p1 then
		local v1, v2 = CurrentCamera:WorldToScreenPoint(p1)

		return UDim2.fromOffset(v1.X, v1.Y), v2
	end
end