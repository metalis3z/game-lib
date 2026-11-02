

local u3 = {
	["GetClientFolder"] = function(_) 
		return game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient", 30)
	end,
	["GetMain"] = function(_, p1) 

		local v2 = require(u3:GetClientFolder():WaitForChild("SharedModules", 30).MainFramework)
		if p1 ~= true then
			v2 = v2:CheckInitialized()
		end
		return v2
	end
}
return u3