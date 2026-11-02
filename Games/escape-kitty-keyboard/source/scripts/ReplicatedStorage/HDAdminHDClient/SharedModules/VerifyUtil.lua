

local u1 = _G.HDAdminMain
local u41 = {
	["KEY_MAX_CHARACTERS"] = 32,
	["isWithinMaxSize"] = function(p2, p3) 

		local v4 = p3 or u41.KEY_MAX_CHARACTERS
		return u41.processMaxSize(p2, v4) and true or false
	end,
	["isDataStoreSafe"] = function(p5) 

		local v6 = typeof(p5)
		if v6 == "string" or v6 == "number" then
			if utf8.len(p5) then
				return u1:GetModule("Demojify").process(p5) == p5
			else
				return false
			end
		else
			return false
		end
	end,
	["isStringSafe"] = function(p7) 

		if typeof(p7) == "string" then
			return u41.isDatastoreSafe(p7)
		else
			return false
		end
	end,
	["processKey"] = function(p8) 

		local v9 = tostring(p8)
		local v10 = typeof(p8)
		if v9 ~= "nil" and (v10 == "string" or v10 == "number") and (#v9 <= u41.KEY_MAX_CHARACTERS and u41.isStringSafe(v9)) then
			return v9
		end
	end,
	["processMaxSize"] = function(u11, p12) 

		local v13 = p12 or u41.KEY_MAX_CHARACTERS * 2
		local v14, v15 = pcall(function()

			return u1.HttpService:JSONEncode(u11)
		end)
		if v14 and (v15 and #v15 <= v13) then
			return u11
		end
	end,
	["processBool"] = function(p16) 
		return p16 == true
	end,
	["processNumber"] = function(p17) 

		if tonumber(p17) then
			local v18 = tonumber(p17)
			local v19 = u1.modules.DataUtil.round(v18, 4)
			return v19 > 10000000000 and 10000000000 or v19
		end
	end,
	["processInstance"] = function(p20, p21) 
		if typeof(p20) == "Instance" then
			if p20.ClassName == p21 then
				return p20
			end
			p20:Destroy()
		end
	end,
	["processTable"] = function(p22, p23) 

		local function u28(p24) 

			if typeof(p24) ~= "table" then
				return {}
			end
			for v25, v26 in pairs(p24) do
				local v27 = u41.processKey(v25)
				p24[v25] = nil
				if v27 and u1.modules.Serializer.isValid(v26) then
					p24[v27] = v26
					if typeof(v26) == "table" then
						u28(v26)
					end
				end
			end
			return p24
		end
		local v29 = u28(p22)
		if not p23 or u41.isWithinMaxSize(v29, p23) then
			return v29
		end
	end,
	["processColorOnlyTable"] = function(p30) 

		local v31 = {}
		local function u40(p32, p33) 

			for v34, v39 in pairs(p32) do
				local v36 = u41.processKey(v34)
				local v37 = typeof(v39)
				if v36 ~= nil then
					if v37 == "table" then
						local v38 = {}
						u40(v39, v38)
						local v39 = v38
						goto l6
					end
					if v37 == "Color3" then
						::l6::
						p33[v36] = v39
					end
				end
			end
		end
		u40(p30, v31)
		return v31
	end
}
return u41