local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.FFlags)
return {
	["IsEnabled"] = function(_)
		local v3 = v2:GetInstant("StockEventMachineEndTime", nil)
		local v4 = v2:GetInstant("StockEventEnabled", true)
		if v4 then
			v4 = v3 == nil and true or DateTime.now().UnixTimestamp < v3
		end
		return v4
	end,
	["Start"] = function(_)
		for _, v5 in script.Machines:GetChildren() do
			require(v5):Start()
		end
	end
}