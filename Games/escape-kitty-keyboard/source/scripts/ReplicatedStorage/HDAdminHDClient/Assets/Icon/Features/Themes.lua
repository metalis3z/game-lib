

local u1 = {}
local u2 = require(script.Parent.Parent.Utility)
local u3 = require(script.Default)
function u1.getThemeValue(p4, p5, p6, _) 
	if p4 then
		for _, v7 in pairs(p4) do
			local v8, v9, v10 = unpack(v7)
			if p5 == v8 and p6 == v9 then
				return v10
			end
		end
	end
	return nil
end
function u1.getInstanceValue(u11, u12) 
	local v13, v14 = pcall(function()

		return u11[u12]
	end)
	if not v13 then
		v14 = u11:GetAttribute(u12)
	end
	return v14
end
function u1.getRealInstance(p15) 
	if p15:GetAttribute("IsAClippedClone") then
		local v16 = p15:FindFirstChild("OriginalInstance")
		if v16 then
			return v16.Value
		end
	end
end
function u1.getClippedClone(p17) 
	if p17:GetAttribute("HasAClippedClone") then
		local v18 = p17:FindFirstChild("ClippedClone")
		if v18 then
			return v18.Value
		end
	end
end
function u1.refresh(p19, p20, p21) 

	if p21 then
		local v22 = p19:getStateGroup()
		local v23 = u1.getThemeValue(v22, p20.Name, p21) or u1.getInstanceValue(p20, p21)
		u1.apply(p19, p20, p21, v23, true)
		return
	else
		local v24 = p19:getStateGroup()
		if v24 then
			local v25 = {
				[p20.Name] = p20
			}
			for _, v26 in pairs(p20:GetDescendants()) do
				local v27 = v26:GetAttribute("Collective")
				if v27 then
					v25[v27] = v26
				end
				v25[v26.Name] = v26
			end
			for _, v28 in pairs(v24) do
				local v29, v30, v31 = unpack(v28)
				local v32 = v25[v29]
				if v32 then
					u1.apply(p19, v32.Name, v30, v31, true)
				end
			end
		end
	end
end
function u1.apply(p33, p34, u35, p36, p37) 

	if not p33.isDestroyed then
		local v38
		if typeof(p34) == "Instance" then
			local v39 = p34.Name
			p34 = v39
			v38 = { p34 }
		else
			v38 = p33:getInstanceOrCollective(p34)
		end
		local v40 = p34 .. "-" .. u35
		local v41 = p33.customBehaviours[v40]
		for _, v42 in pairs(v38) do
			local v43 = u1.getClippedClone(v42)
			if v43 then
				table.insert(v38, v43)
			end
		end
		for _, u44 in pairs(v38) do
			if u35 ~= "Position" or not u1.getClippedClone(u44) then
				if (u35 ~= "Size" or not u1.getRealInstance(u44)) and (p37 or p36 ~= u1.getInstanceValue(u44, u35)) then
					local u45
					if v41 then
						u45 = v41(p36, u44, u35)
						if u45 == nil then
							u45 = p36
						end
					else
						u45 = p36
					end
					if not pcall(function()

						u44[u35] = u45
					end) then
						u44:SetAttribute(u35, u45)
					end
				end
			end
		end
	end
end
function u1.getModifications(p46) 
	local v47 = p46[1]
	return typeof(v47) ~= "table" and { p46 } or p46
end
function u1.merge(p48, p49, p50) 

	local v51, v52, v53, v54 = table.unpack(p49)
	local v55, v56, _, v57 = table.unpack(p48)
	if v51 ~= v55 or (v52 ~= v56 or not u1.statesMatch(v54, v57)) then
		return false
	end
	p48[3] = v53
	if p50 then
		p50(p48)
	end
	return true
end
function u1.modify(u58, u59, u60) 

	task.spawn(function()

		u60 = u60 or u2.generateUID()
		u59 = u1.getModifications(u59)
		for _, u61 in pairs(u59) do
			local u62, u63, u64, v65 = table.unpack(u61)
			if v65 == nil then
				u1.modify(u58, {
					u62,
					u63,
					u64,
					"Selected"
				}, u60)
				u1.modify(u58, {
					u62,
					u63,
					u64,
					"Viewing"
				}, u60)
			end
			local u66 = u2.formatStateName(v65 or "Deselected")
			local u67 = u58:getStateGroup(u66);
			(function() 

				for _, v68 in pairs(u67) do
					if u1.merge(v68, u61, function(p69)

						p69[5] = u60
						if u66 == u58.activeState then
							u1.apply(u58, u62, u63, u64)
						end
					end) then
						return
					end
				end
				local v70 = {
					u62,
					u63,
					u64,
					u66,
					u60
				}
				local v71 = u67
				table.insert(v71, v70)
				if u66 == u58.activeState then
					u1.apply(u58, u62, u63, u64)
				end
			end)()
		end
	end)
	return u60
end
function u1.remove(p72, p73) 

	for _, v74 in pairs(p72.appearance) do
		for v75 = #v74, 1, -1 do
			if v74[v75][5] == p73 then
				table.remove(v74, v75)
			end
		end
	end
	u1.rebuild(p72)
end
function u1.removeWith(p76, p77, p78, p79) 

	for v80, v81 in pairs(p76.appearance) do
		if p79 == v80 or not p79 then
			for v82 = #v81, 1, -1 do
				local v83 = v81[v82]
				local v84 = v83[1]
				local v85 = v83[2]
				if v84 == p77 and v85 == p78 then
					table.remove(v81, v82)
				end
			end
		end
	end
	u1.rebuild(p76)
end
function u1.change(p86) 

	local v87 = p86:getStateGroup()
	for _, v88 in pairs(v87) do
		local v89, v90, v91 = unpack(v88)
		u1.apply(p86, v89, v90, v91)
	end
end
function u1.set(u92, p93) 

	local v94 = u92.themesJanitor
	v94:clean()
	v94:add(u92.stateChanged:Connect(function()

		u1.change(u92)
	end))
	if typeof(p93) == "Instance" and p93:IsA("ModuleScript") then
		p93 = require(p93)
	end
	u92.appliedTheme = p93
	u1.rebuild(u92)
end
function u1.statesMatch(p95, p96) 
	local v97
	if p95 then
		v97 = string.lower(p95)
	else
		v97 = p95
	end
	local v98
	if p96 then
		v98 = string.lower(p96)
	else
		v98 = p96
	end
	return v97 == v98 or not p95 or not p96
end
function u1.rebuild(u99) 

	local u100 = u99.appliedTheme
	local u101 = { "Deselected", "Selected", "Viewing" }
	(function() 

		for _, v102 in pairs(u101) do
			local u103 = {}
			local function v111(p104, p105) 

				if p104 then
					for _, v106 in pairs(p104) do
						local v107 = v106[5]
						local v108 = v106[4]
						if u1.statesMatch(p105, v108) then
							local v109 = v106[1] .. "-" .. v106[2]
							local v110 = u2.copyTable(v106)
							v110[5] = v107
							u103[v109] = v110
						end
					end
				end
			end
			if v102 == "Selected" then
				v111(u3, "Deselected")
			end
			v111(u3, "Empty")
			v111(u3, v102)
			if u100 ~= u3 then
				if v102 == "Selected" then
					v111(u100, "Deselected")
				end
				v111(u3, "Empty")
				v111(u100, v102)
			end
			local v112 = {}
			local v113 = u99.appearance[v102]
			if v113 then
				for _, v114 in pairs(v113) do
					local v115 = v114[5]
					if v115 ~= nil then
						local v116 = {
							v114[1],
							v114[2],
							v114[3],
							v102,
							v115
						}
						table.insert(v112, v116)
					end
				end
			end
			v111(v112, v102)
			local v117 = {}
			for _, v118 in pairs(u103) do
				table.insert(v117, v118)
			end
			u99.appearance[v102] = v117
		end
		u1.change(u99)
	end)()
end
return u1