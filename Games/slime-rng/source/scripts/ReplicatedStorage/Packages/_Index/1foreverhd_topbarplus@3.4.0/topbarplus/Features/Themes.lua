-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Themes, time of decompilation: Sun May  3 10:09:34 2026 ]]
local t1 = {}
local Utility = require(script.Parent.Parent.Utility)
local Default = require(script.Default)

function t1.getThemeValue(p1, p2, p3, _) -- line: 16
	if p1 then
		for _, v in pairs(p1) do
			local v10, v11, v12 = unpack(v)

			if p2 == v10 and p3 == v11 then
				return v12
			end
		end
	end

	return nil
end
function t1.getInstanceValue(p5, p6) -- line: 28
	local ok, result = pcall(function() -- line: 29
		-- upvalues: p5 (copy), p6 (copy)
		return p5[p6]
	end)

	if not ok then
		result = p5:GetAttribute(p6)
	end

	return result
end
function t1.getRealInstance(p7) -- line: 38
	if not p7:GetAttribute("IsAClippedClone") then
		return
	end

	local OriginalInstance = p7:FindFirstChild("OriginalInstance")

	if not OriginalInstance then
		return
	end

	return OriginalInstance.Value
end
function t1.getClippedClone(p8) -- line: 49
	if not p8:GetAttribute("HasAClippedClone") then
		return
	end

	local ClippedClone = p8:FindFirstChild("ClippedClone")

	if not ClippedClone then
		return
	end

	return ClippedClone.Value
end
function t1.refresh(p9, p10, p11) -- line: 60
	-- upvalues: t1 (copy)
	if p11 then
		local v24 = p9:getStateGroup()
		local v25 = t1.getThemeValue(v24, p10.Name, p11) or t1.getInstanceValue(p10, p11)

		t1.apply(p9, p10, p11, v25, true)

		return
	end

	local v26 = p9:getStateGroup()

	if not v26 then
		return
	end

	local t2 = {
		[p10.Name] = p10
	}

	for _, v in pairs(p10:GetDescendants()) do
		local Collective = v:GetAttribute("Collective")

		if Collective then
			t2[Collective] = v
		end

		t2[v.Name] = v
	end

	for _, v in pairs(v26) do
		local v33, v34, v35 = unpack(v)
		local v36 = t2[v33]

		if v36 then
			t1.apply(p9, v36.Name, v34, v35, true)
		end
	end
end
function t1.apply(p12, p13, p14, p15, p16) -- line: 93
	-- upvalues: t1 (copy)
	if p12.isDestroyed then
		return
	end

	local t3

	if typeof(p13) == "Instance" then
		t3 = { p13 }
		p13 = p13.Name
	else
		t3 = p12:getInstanceOrCollective(p13)
	end

	local v44 = p13 .. "-" .. p14
	local v45 = p12.customBehaviours[v44]

	for _, v in pairs(t3) do
		local v48 = t1.getClippedClone(v)

		if v48 then
			table.insert(t3, v48)
		end
	end

	for _, v in pairs(t3) do
		if (p14 ~= "Position" or not t1.getClippedClone(v)) and (p14 ~= "Size" or not t1.getRealInstance(v)) then
			local v51 = t1.getInstanceValue(v, p14)

			if p16 or v51 ~= p15 then
				if v45 then
					local v52 = v45(p15, v, p14)

					if v52 ~= nil then
						p15 = v52
					end
				end

				if not pcall(function() -- line: 139
					-- upvalues: v (copy), p14 (copy), p15 (ref)
					v[p14] = p15
				end) then
					v:SetAttribute(p14, p15)
				end
			end
		end
	end
end
function t1.getModifications(p17) -- line: 153
	if typeof(p17[1]) ~= "table" then
		p17 = { p17 }
	end

	return p17
end
function t1.merge(p18, p19, p20) -- line: 162
	-- upvalues: t1 (copy)
	local v57, v58, v59, v60 = table.unpack(p19)
	local v61, v62, _, v64 = table.unpack(p18)

	if v57 == v61 and v58 == v62 and t1.statesMatch(v60, v64) then
		p18[3] = v59

		if p20 then
			p20(p18)
		end

		return true
	end

	return false
end
function t1.modify(p21, p22, p23) -- line: 175
	-- upvalues: Utility (copy), t1 (copy)
	task.spawn(function() -- line: 183
		-- upvalues: p23 (ref), Utility (copy), p22 (ref), t1 (copy), p21 (copy)
		p23 = p23 or Utility.generateUID()
		p22 = t1.getModifications(p22)

		for _, v in pairs(p22) do
			local v102, v103, v104, v105 = table.unpack(v)

			if v105 == nil then
				t1.modify(p21, {
					v102,
					v103,
					v104,
					"Selected"
				}, p23)
				t1.modify(p21, {
					v102,
					v103,
					v104,
					"Viewing"
				}, p23)
			end

			local v106 = Utility.formatStateName(v105 or "Deselected")
			local v107 = p21:getStateGroup(v106);

			(function() --[[ updateRecord ]] -- line: 200
				-- upvalues: v107 (copy), t1 (copy), v (copy), p23 (ref), v106 (copy), p21 (copy), v102 (copy), v103 (copy), v104 (copy)
				for _, v2 in pairs(v107) do
					if t1.merge(v2, v, function(p24) -- line: 202
						-- upvalues: p23 (ref), v106 (copy), p21 (copy), t1 (copy), v102 (copy), v103 (copy), v104 (copy)
						p24[5] = p23

						if v106 == p21.activeState then
							t1.apply(p21, v102, v103, v104)
						end
					end) then
						return
					end
				end

				local t4 = {
					v102,
					v103,
					v104,
					v106,
					p23
				}

				table.insert(v107, t4)

				if v106 == p21.activeState then
					t1.apply(p21, v102, v103, v104)
				end
			end)()
		end
	end)

	return p23
end
function t1.remove(p25, p26) -- line: 220
	-- upvalues: t1 (copy)
	for _, v in pairs(p25.appearance) do
		for i = #v, 1, -1 do
			if p26 == v[i][5] then
				table.remove(v, i)
			end
		end
	end

	t1.rebuild(p25)
end
function t1.removeWith(p27, p28, p29, p30) -- line: 233
	-- upvalues: t1 (copy)
	for k, v in pairs(p27.appearance) do
		if p30 == k or not p30 then
			for i = #v, 1, -1 do
				local v82 = v[i]
				local v83 = v82[1]
				local v84 = v82[2]

				if v83 == p28 and v84 == p29 then
					table.remove(v, i)
				end
			end
		end
	end

	t1.rebuild(p27)
end
function t1.change(p31) -- line: 249
	-- upvalues: t1 (copy)
	local v86 = p31:getStateGroup()

	for _, v in pairs(v86) do
		local v89, v90, v91 = unpack(v)

		t1.apply(p31, v89, v90, v91)
	end
end
function t1.set(p32, p33) -- line: 259
	-- upvalues: t1 (copy)
	local themesJanitor = p32.themesJanitor

	themesJanitor:clean()
	themesJanitor:add(p32.stateChanged:Connect(function() -- line: 265
		-- upvalues: t1 (copy), p32 (copy)
		t1.change(p32)
	end))

	if typeof(p33) == "Instance" and p33:IsA("ModuleScript") then
		p33 = require(p33)
	end

	p32.appliedTheme = p33
	t1.rebuild(p32)
end
function t1.statesMatch(p34, p35) -- line: 275
	return (p34 and string.lower(p34)) == (p35 and string.lower(p35)) or (not p34 or not p35)
end
function t1.rebuild(p36) -- line: 282
	-- upvalues: t1 (copy), Utility (copy), Default (copy)
	local appliedTheme = p36.appliedTheme
	local t5 = {
		"Deselected",
		"Selected",
		"Viewing"
	};

	(function() --[[ generateTheme ]] -- line: 289
		-- upvalues: t5 (copy), t1 (copy), Utility (copy), Default (copy), appliedTheme (copy), p36 (copy)
		for _, v in pairs(t5) do
			local t6 = {}

			local function updateDetails(p37, p38) -- line: 295
				-- upvalues: t1 (copy), Utility (copy), t6 (copy)
				if not p37 then
					return
				end

				for _, v3 in pairs(p37) do
					local v127 = v3[5]
					local v128 = v3[4]

					if t1.statesMatch(p38, v128) then
						local v129 = v3[1] .. "-" .. v3[2]
						local v130 = Utility.copyTable(v3)

						v130[5] = v127
						t6[v129] = v130
					end
				end
			end

			if v == "Selected" then
				updateDetails(Default, "Deselected")
			end

			updateDetails(Default, "Empty")
			updateDetails(Default, v)

			if appliedTheme ~= Default then
				if v == "Selected" then
					updateDetails(appliedTheme, "Deselected")
				end

				updateDetails(Default, "Empty")
				updateDetails(appliedTheme, v)
			end

			local t7 = {}
			local v113 = p36.appearance[v]

			if v113 then
				for _, v4 in pairs(v113) do
					local v116 = v4[5]

					if v116 ~= nil then
						table.insert(t7, {
							v4[1],
							v4[2],
							v4[3],
							v,
							v116
						})
					end
				end
			end

			updateDetails(t7, v)

			local t8 = {}

			for _, v5 in pairs(t6) do
				table.insert(t8, v5)
			end

			p36.appearance[v] = t8
		end

		t1.change(p36)
	end)()
end

return t1
