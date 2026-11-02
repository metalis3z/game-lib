-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer

LocalPlayer:SetAttribute("Core_FOV", 70)
function t.Change_FOV_CORE(p1) --[[ Change_FOV_CORE | Line: 6 | Upvalues: LocalPlayer (copy) ]]
	if not (LocalPlayer and p1) then
		return
	end

	LocalPlayer:SetAttribute("Core_FOV", p1)
end
function t.Return_Core_FOV() --[[ Return_Core_FOV | Line: 12 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:GetAttribute("Core_FOV")
end
function t.Change_FOV(p1, p2) --[[ Change_FOV | Line: 16 | Upvalues: LocalPlayer (copy), TweenService (copy) ]]
	if not game.Workspace.CurrentCamera then
		return
	end

	if p1 == 70 then
		p1 = LocalPlayer:GetAttribute("Core_FOV")
	end

	local v4 = TweenInfo.new((p2 or 0.5) * (math.random(95, 105) * 0.01), Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
	local v5 = TweenService:Create(game.Workspace.CurrentCamera, v4, {
		FieldOfView = p1
	})

	v5:Play()
	game.Debris:AddItem(v5, v4.Time)
end

return t