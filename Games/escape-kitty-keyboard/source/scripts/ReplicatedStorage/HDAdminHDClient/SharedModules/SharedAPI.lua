

local v1 = {}
local u2 = _G.HDAdminMain
function v1.GetRankName(_, p3) 

	return u2:GetModule("cf"):GetRankName(p3)
end
function v1.GetRankId(_, p4) 

	return u2:GetModule("cf"):GetRankId(p4)
end
function v1.Notice(_, p5, p6) 

	if u2.player then
		if p6 then
			u2:GetModule("Notices"):Notice("Notice", "Game Notice", p6)
			return
		end
	else
		u2:GetModule("cf"):Notice(p5, "Game Notice", p6)
	end
end
function v1.Error(_, p7, p8) 

	if u2.player then
		if p8 then
			u2:GetModule("Notices"):Notice("Error", "Game Notice", p8)
			return
		end
	else
		u2.signals.Error:FireClient(p7, { "Game Notice", p8 })
	end
end
return v1