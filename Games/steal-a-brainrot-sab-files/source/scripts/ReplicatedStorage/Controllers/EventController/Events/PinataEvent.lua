local module = {
	OnStart = function(arg1)
	end;
}
local any_new_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Trove).new()
function module.OnStop(arg1)
	any_new_result1_upvr:Destroy()
end
function module.OnLoad(arg1)
end
return module