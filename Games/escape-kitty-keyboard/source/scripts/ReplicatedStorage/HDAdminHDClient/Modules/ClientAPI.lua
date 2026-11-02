

local v1 = {}
local u2 = _G.HDAdminMain
function v1.SetTopbarTransparency(_, p3) 
	local _ = tonumber(p3) or 0.5
end
function v1.SetTopbarEnabled(_, p4) 

	local v5 = type(p4) ~= "boolean" and true or p4
	local v6 = u2:GetModule("TopbarIcons").Dashboard
	if v6 then
		v6:setEnabled(v5)
	end
end
function v1.GetDashboardIcon(_) 

	return u2:GetModule("TopbarIcons").Dashboard
end
return v1