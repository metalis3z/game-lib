

local function u6(p1) 
	local v2 = {}
	for _, v3 in ipairs(p1:GetChildren()) do
		if v3:IsA("ModuleScript") then
			local v4, v5 = pcall(require, v3)
			if v4 and type(v5) == "table" then
				v2[v3.Name] = v5
			else
				warn((("[AdminAbuse] require \"%*\" \195\169choue"):format(v3.Name)))
			end
		end
	end
	return v2
end
local function u14(p7, p8) 
	local v9 = false
	local v10 = nil
	local v11 = nil
	if type(p8) == "table" then
		v9 = p8.NeedsDuration == true and true or v9
		local v12 = p8.MaxDurationSeconds
		if type(v12) == "number" and p8.MaxDurationSeconds > 0 then
			v10 = p8.MaxDurationSeconds
		end
		local v13 = p8.DefaultDurationSeconds
		if type(v13) == "number" and p8.DefaultDurationSeconds > 0 then
			v11 = p8.DefaultDurationSeconds
		end
	end
	return {
		["name"] = p7,
		["needsDuration"] = v9,
		["maxDurationSeconds"] = v10,
		["defaultDurationSeconds"] = v11
	}
end
return {
	["listModuleNames"] = function(p15) 
		local v16 = {}
		for _, v17 in ipairs(p15:GetChildren()) do
			if v17:IsA("ModuleScript") then
				local v18 = v17.Name
				table.insert(v16, v18)
			end
		end
		table.sort(v16)
		return v16
	end,
	["listModuleMetas"] = function(p19) 

		local v20 = {}
		for _, v21 in ipairs(p19:GetChildren()) do
			if v21:IsA("ModuleScript") then
				local v22, v23 = pcall(require, v21)
				if v22 then
					local v24 = u14(v21.Name, v23)
					table.insert(v20, v24)
				else
					local v25 = {
						["needsDuration"] = false,
						["name"] = v21.Name
					}
					table.insert(v20, v25)
				end
			end
		end
		table.sort(v20, function(p26, p27)
			return p26.name < p27.name
		end)
		return v20
	end,
	["buildAdminAbuseTable"] = function(p28) 

		local u29 = u6(p28)
		return setmetatable({}, {
			["__index"] = function(_, p30) 

				return u29[p30]
			end
		})
	end,
	["loadRegistry"] = function(p31) 

		return u6(p31)
	end
}