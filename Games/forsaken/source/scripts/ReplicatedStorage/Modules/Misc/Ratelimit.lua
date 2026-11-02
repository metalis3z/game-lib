-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = setmetatable({}, {
	["__mode"] = "k"
})
local v_u_6 = setmetatable({}, {
	["__len"] = function(p4)
		local v5 = 0
		for _ in p4 do
			v5 = v5 + 1
		end
		return v5
	end
})
local v_u_7 = math.min
local v_u_8 = math.max
local v_u_9 = table.insert
local v_u_10 = table.remove
local v_u_11 = os.clock
local function v_u_12() end
local v_u_13 = {
	["RATE"] = 0.02857142857142857,
	["FILL_RATE"] = 2,
	["CONSUME"] = 1,
	["MAX_TOKENS"] = 10,
	["LEAK_RATE"] = 1,
	["CAPACITY"] = 10,
	["WINDOW_SIZE"] = 5,
	["MAX_EVENTS"] = 10
}
local v_u_52 = {
	["DEFAULT"] = function(p14, p15, _)
		-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_12
		local v16 = p14.__playerSources
		local v17 = p14.__algorithmSettings
		local v18 = v_u_11()
		local v19 = v16[p15]
		local v20 = v17.rate
		if v19 then
			local v21 = v_u_8(v18, v19 + v20)
			if v21 - v18 < 1 then
				v16[p15] = v21
				return "OK"
			else
				v_u_12((("[%*]: Ratelimiting user: %*!"):format(script, p15)))
				return "BAD"
			end
		else
			v16[p15] = v18 + v20
			return "OK"
		end
	end,
	["TOKEN"] = function(p22, p23, p24)
		-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_7, (copy) v_u_12
		local v25 = p22.__playerSources
		local v26 = p22.__internalState
		local v27 = p22.__algorithmSettings
		local v28 = v_u_11()
		local v29 = v25[p23]
		if not v26.tokens[p23] then
			v26.tokens[p23] = v27.maxTokens
		end
		local v30 = v29 and (v28 - v29 or 0) or 0
		local v31 = p24 and p24.consume or v_u_13.CONSUME
		v26.tokens[p23] = v_u_7((v26.tokens[p23] or 0) + v30 * v27.fillRate, v27.maxTokens)
		v25[p23] = v28
		if v31 > v26.tokens[p23] then
			v_u_12((("[%*]: Ratelimiting user: %*!"):format(script, p23)))
			return "BAD"
		end
		local v32 = v26.tokens
		v32[p23] = v32[p23] - v31
		return "OK"
	end,
	["LEAKY"] = function(p33, p34, _)
		-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_12
		local v35 = p33.__playerSources
		local v36 = p33.__internalState
		local v37 = p33.__algorithmSettings
		local v38 = v_u_11()
		local v39 = v35[p34]
		local v40 = (v39 and (v38 - v39 or 0) or 0) * v37.leakRate
		local v41 = v37.capacity
		v36.queue[p34] = v_u_8(0, (v36.queue[p34] or 0) - v40)
		v35[p34] = v38
		if v36.queue[p34] >= v41 then
			v_u_12((("[%*]: Ratelimiting user: %*!"):format(script, p34)))
			return "BAD"
		end
		local v42 = v36.queue
		v42[p34] = v42[p34] + 1
		return "OK"
	end,
	["SLIDING_WINDOW"] = function(p43, p44, _)
		-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) v_u_9, (copy) v_u_12
		local v45 = p43.__playerSources
		local v46 = p43.__internalState
		local v47 = p43.__algorithmSettings
		local v48 = v_u_11()
		if not v46.events[p44] then
			v46.events[p44] = {}
		end
		local v49 = v46.events[p44]
		local v50 = v47.windowSize
		local v51 = v47.maxEvents
		while #v49 > 0 and v50 < v48 - v49[1] do
			v_u_10(v49, 1)
		end
		if #v49 >= v51 then
			v_u_12((("[%*]: Ratelimiting user: %*!"):format(script, p44)))
			return "BAD"
		end
		v_u_9(v49, v48)
		v45[p44] = v48
		return "OK"
	end
}
local v_u_53 = {}
v_u_53.__index = v_u_53
function v_u_53.Check(p54, p55, p56)
	-- upvalues: (copy) v_u_6, (copy) v_u_52
	return not (p55 and (p55:IsA("Player") and v_u_6[p55])) and "BAD" or v_u_52[p54.__algorithm](p54, p55, p56)
end
function v_u_53.GetState(p57, _)
	-- upvalues: (copy) v_u_2
	warn(("\n[%s] State:\nAlgorithm: %s\nSettings: %s\nSources: %s\nInternal: %s"):format(script.Name, p57.__algorithm, v_u_2:JSONEncode(p57.__algorithmSettings), v_u_2:JSONEncode(p57.__playerSources), v_u_2:JSONEncode(p57.__internalState)))
end
function v_u_53.Remove(p58, p59)
	local v60 = p58.__playerSources[p59]
	p58.__playerSources[p59] = nil
	local v61 = p58.__algorithm
	if v61 == "TOKEN" then
		p58.__internalState.tokens[p59] = nil
		return v60
	elseif v61 == "SLIDING_WINDOW" then
		p58.__internalState.events[p59] = nil
		return v60
	else
		if v61 == "LEAKY" then
			p58.__internalState.queue[p59] = nil
		end
		return v60
	end
end
function v_u_53.Cleanup(p62)
	p62.__playerSources = {}
	local v63 = p62.__algorithm
	if v63 == "TOKEN" then
		p62.__internalState.tokens = {}
		return
	elseif v63 == "SLIDING_WINDOW" then
		p62.__internalState.events = {}
	elseif v63 == "LEAKY" then
		p62.__internalState.queue = {}
	end
end
function v_u_53.Destroy(p64)
	-- upvalues: (copy) v_u_3
	p64:Cleanup()
	v_u_3[p64] = nil
	setmetatable(p64, nil)
end
local v83 = {
	["new"] = function(p65, p66)
		-- upvalues: (copy) v_u_53, (copy) v_u_13, (copy) v_u_3
		local v67 = {
			["__playerSources"] = {},
			["__algorithm"] = p65 or "DEFAULT",
			["__algorithmSettings"] = p66 or {},
			["__internalState"] = {}
		}
		local v68 = v_u_53
		setmetatable(v67, v68)
		if p65 == nil or p65 == "DEFAULT" then
			local v69 = v_u_13.RATE
			local v70 = v67.__internalState
			if p66 then
				v69 = p66.rate or v69
			end
			v70.rate = v69
		elseif p65 == "TOKEN" then
			local v71 = v_u_13.MAX_TOKENS
			local v72 = v67.__internalState
			if p66 then
				v71 = p66.maxTokens or v71
			end
			v72.maxTokens = v71
			local v73 = v_u_13.FILL_RATE
			local v74 = v67.__internalState
			if p66 then
				v73 = p66.fillRate or v73
			end
			v74.fillRate = v73
			v67.__internalState.tokens = {}
		elseif p65 == "LEAKY" then
			local v75 = v_u_13.CAPACITY
			local v76 = v67.__internalState
			if p66 then
				v75 = p66.capacity or v75
			end
			v76.capacity = v75
			local v77 = v_u_13.LEAK_RATE
			local v78 = v67.__internalState
			if p66 then
				v77 = p66.leakRate or v77
			end
			v78.leakRate = v77
			v67.__internalState.queue = {}
		elseif p65 == "SLIDING_WINDOW" then
			local v79 = v_u_13.WINDOW_SIZE
			local v80 = v67.__internalState
			if p66 then
				v79 = p66.windowSize or v79
			end
			v80.windowSize = v79
			local v81 = v_u_13.MAX_EVENTS
			local v82 = v67.__internalState
			if p66 then
				v81 = p66.maxEvents or v81
			end
			v82.maxEvents = v81
			v67.__internalState.events = {}
		end
		v_u_3[v67] = true
		return v67
	end
}
for _, v84 in v1:GetPlayers() do
	v_u_6[v84] = true
end
v1.PlayerAdded:Connect(function(p85)
	-- upvalues: (copy) v_u_6
	v_u_6[p85] = true
end)
v1.PlayerRemoving:Connect(function(p86)
	-- upvalues: (copy) v_u_6, (copy) v_u_3
	v_u_6[p86] = nil
	for v87 in v_u_3 do
		v87:Remove(p86)
	end
end)
return v83
