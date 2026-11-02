


local v1 = {
	["OnStart"] = function(_) end
}
local v_u_2 = require(game:GetService("ReplicatedStorage").Packages.Trove).new()
function v1.OnStop(_)
	v_u_2:Destroy()
end
function v1.OnLoad(_) end
return v1
