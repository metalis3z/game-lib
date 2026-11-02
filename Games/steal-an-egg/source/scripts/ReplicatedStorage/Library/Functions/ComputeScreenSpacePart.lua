-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")

return function(p1, p2) --[[ Line: 3 | Upvalues: Workspace (copy) ]]
	local CurrentCamera = Workspace.CurrentCamera
	local ViewportSize = CurrentCamera.ViewportSize
	local v2 = math.tan(math.rad(CurrentCamera.FieldOfView) * 0.5)
	local v4 = CurrentCamera:ViewportPointToRay(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, p1 - p2 * 0.5)

	return CFrame.lookAt(Vector3.new(0, 0, 0), v4.Direction) + v4.Origin, Vector3.new(p1 * 2 * (v2 * ViewportSize.X / ViewportSize.Y), p1 * 2 * v2, p2)
end