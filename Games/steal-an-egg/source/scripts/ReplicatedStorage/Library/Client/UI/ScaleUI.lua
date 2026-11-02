-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local CurrentCamera = workspace.CurrentCamera

return function(p1) --[[ Line: 10 | Upvalues: Asserts (copy), CurrentCamera (copy) ]]
	Asserts.UIScale(p1)

	local function updateScale() --[[ updateScale | Line: 13 | Upvalues: CurrentCamera (ref), p1 (copy) ]]
		local ViewportSize = CurrentCamera.ViewportSize

		p1.Scale = math.clamp((math.min(ViewportSize.X, ViewportSize.Y) - 320) / 960 * 0.6 + 0.4, 0.4, 1) * 1
	end

	local ViewportSize = CurrentCamera.ViewportSize

	p1.Scale = math.clamp((math.min(ViewportSize.X, ViewportSize.Y) - 320) / 960 * 0.6 + 0.4, 0.4, 1) * 1

	local v2 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

	return function() --[[ Line: 25 | Upvalues: v2 (ref) ]]
		if v2 then
			v2:Disconnect()
			v2 = nil
		end
	end
end