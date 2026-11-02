

local _ = _G.HDAdminMain
local v1 = {
	["example2"] = {
		["Function"] = function(_, _) 
			print("HELLO (Client)")
		end,
		["UnFunction"] = function(_, _) 
			print("GOODBYE (Client)")
		end
	}
}
for v2, v3 in pairs(v1) do
	v3.Name = v2
end
return v1