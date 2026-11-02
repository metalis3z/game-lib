

local u1 = game:GetService("ReplicatedStorage")
local u3 = {
	["objectName"] = "TopbarPlusReference",
	["addToReplicatedStorage"] = function() 

		if u1:FindFirstChild(u3.objectName) then
			return false
		end
		local v2 = Instance.new("ObjectValue")
		v2.Name = u3.objectName
		v2.Value = script.Parent
		v2.Parent = u1
		return v2
	end,
	["getObject"] = function() 

		return u1:FindFirstChild(u3.objectName) or false
	end
}
return u3