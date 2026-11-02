-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

function FastTween(p1, p2, p3, p4) --[[ FastTween | Line: 3 | Upvalues: TweenService (copy) ]]
	local v2 = TweenService:Create(p1, p2, p3)

	v2.Completed:Once(function() --[[ Line: 6 | Upvalues: v2 (copy) ]]
		v2:Destroy()
	end)

	if if p4 == false then false else true then
		v2:Play()
	end

	return v2
end

return FastTween