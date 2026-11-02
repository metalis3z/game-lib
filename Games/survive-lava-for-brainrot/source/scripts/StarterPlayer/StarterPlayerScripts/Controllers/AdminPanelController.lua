-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {}
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_4 = v_u_2.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Admin")
local v_u_6 = v_u_5:WaitForChild("ScrollingFrame")
local v_u_7 = v3:WaitForChild("Events"):WaitForChild("AdminPanel")
local v_u_8 = require(v3:WaitForChild("Registries"):WaitForChild("LuckyBlocksRegistry"))
local v_u_9 = require(v3.Icon)
local v_u_10 = require(script.Parent:WaitForChild("UIController"))
local v_u_11 = require(script.Parent:WaitForChild("PollController"))
local v_u_12 = game.PlaceId == 72144151448818 and {
	21349438,
	2657540898,
	116514507,
	45449033,
	381042662,
	92896663,
	8035006873,
	178596165,
	425901043,
	9923316322,
	10916243,
	348338200,
	327423121,
	6096303964,
	69326238,
	537836346,
	8095632868
} or {
	21349438,
	2657540898,
	10916243,
	327423121,
	425901043
}
local v_u_13 = v3:WaitForChild("Brainrots")
local v_u_14 = {
	"Normal",
	"Gold",
	"Diamond",
	"Emerald",
	"Bloodmoon",
	"Rainbow"
}
local v_u_15 = {
	"valentines",
	"lowgravity",
	"lava",
	"serverluck",
	"disco",
	"skipfusetime",
	"stoplava",
	"icelavaevent",
	"slimelavaevent"
}
local function v_u_30(p_u_16, p_u_17, p_u_18)
	local v_u_19 = p_u_17:WaitForChild("Template"):WaitForChild("Template")
	p_u_17.Visible = false
	local v_u_20 = false
	local function v_u_22()
		-- upvalues: (copy) p_u_17, (copy) v_u_19
		for _, v21 in p_u_17:GetChildren() do
			if v21:IsA("TextButton") and v21 ~= v_u_19 then
				v21:Destroy()
			end
		end
	end
	local function v27()
		-- upvalues: (ref) v_u_20, (copy) v_u_22, (copy) p_u_16, (copy) p_u_17, (copy) p_u_18, (copy) v_u_19
		if v_u_20 then
			return
		else
			v_u_22()
			local v23 = p_u_16.Text
			if v23 == "" then
				p_u_17.Visible = false
				return
			else
				local v24 = p_u_18(v23)
				if v24 and #v24 ~= 0 then
					for _, v_u_25 in v24 do
						local v26 = v_u_19:Clone()
						v26.Name = v_u_25
						v26.Text = v_u_25
						v26.Visible = true
						v26.Parent = p_u_17
						v26.MouseButton1Click:Connect(function()
							-- upvalues: (ref) p_u_16, (copy) v_u_25, (ref) v_u_20, (ref) p_u_17, (ref) v_u_22
							p_u_16.Text = v_u_25
							v_u_20 = true
							p_u_17.Visible = false
							v_u_22()
							task.defer(function()
								-- upvalues: (ref) v_u_20
								v_u_20 = false
							end)
						end)
					end
					p_u_17.Visible = true
				else
					p_u_17.Visible = false
				end
			end
		end
	end
	p_u_16:GetPropertyChangedSignal("Text"):Connect(v27)
	p_u_16.Focused:Connect(v27)
	p_u_16.FocusLost:Connect(function(p28)
		-- upvalues: (copy) p_u_17, (copy) v_u_19, (copy) p_u_16, (ref) v_u_20, (copy) v_u_22
		if not (p28 and p_u_17.Visible) then
			task.delay(0.15, function()
				-- upvalues: (ref) v_u_20, (ref) p_u_17, (ref) v_u_22
				v_u_20 = true
				p_u_17.Visible = false
				v_u_22()
				task.defer(function()
					-- upvalues: (ref) v_u_20
					v_u_20 = false
				end)
			end)
			return
		end
		for _, v29 in p_u_17:GetChildren() do
			if v29:IsA("TextButton") and v29 ~= v_u_19 then
				p_u_16.Text = v29.Text
				break
			end
		end
		v_u_20 = true
		p_u_17.Visible = false
		v_u_22()
		task.defer(function()
			-- upvalues: (ref) v_u_20
			v_u_20 = false
		end)
	end)
end
local function v_u_37(p31)
	-- upvalues: (copy) v_u_2
	local v32 = p31:lower()
	local v33 = {}
	for _, v34 in v_u_2:GetPlayers() do
		if v34.Name:lower():sub(1, #v32) == v32 then
			local v35 = v34.Name
			table.insert(v33, v35)
		elseif v34.DisplayName:lower():sub(1, #v32) == v32 then
			local v36 = v34.DisplayName
			table.insert(v33, v36)
		end
	end
	return v33
end
local function v_u_52(p38)
	-- upvalues: (copy) v_u_8, (copy) v_u_13, (copy) v_u_14
	local v39 = p38:gsub("%s+", " ")
	local v40 = v39:find(" ") ~= nil
	local v41 = {}
	for _, v42 in v39:split(" ") do
		if v42 ~= "" then
			table.insert(v41, v42)
		end
	end
	local v43 = {}
	local v44 = v39:lower()
	if #v41 == 0 then
		return {}
	end
	for v45 in v_u_8 do
		if v45:lower():sub(1, #v44) == v44 then
			table.insert(v43, v45)
		end
	end
	if #v41 ~= 1 or v40 then
		if #v43 == 0 then
			local v46 = v41[2] and (v41[2]:lower() or "") or ""
			for _, v47 in v_u_14 do
				if v46 == "" or v47:lower():sub(1, #v46) == v46 then
					local v48 = v41[1] .. " " .. v47
					table.insert(v43, v48)
				end
			end
		end
		return v43
	end
	local v49 = v41[1]:lower()
	for _, v50 in v_u_13.Normal:GetChildren() do
		if v50.Name:lower():sub(1, #v49) == v49 then
			local v51 = v50.Name
			table.insert(v43, v51)
		end
	end
	return v43
end
local function v_u_69(p53)
	-- upvalues: (copy) v_u_15, (copy) v_u_14
	local v54 = p53:gsub("%s+", " ")
	local v55 = v54:find(" ") ~= nil
	local v56 = {}
	for _, v57 in v54:split(" ") do
		if v57 ~= "" then
			table.insert(v56, v57)
		end
	end
	local v58 = {}
	if #v56 == 0 then
		return {}
	end
	if #v56 == 1 and not v55 then
		local v59 = v56[1]:lower()
		for _, v60 in v_u_15 do
			if v60:sub(1, #v59) == v59 then
				table.insert(v58, v60)
			end
		end
		return v58
	end
	if v56[1]:lower() ~= "lava" then
		if v56[1]:lower() == "serverluck" then
			local v61 = v56[2] or ""
			local v62 = v56[3] or ""
			if v61 == "" then
				table.insert(v58, "serverluck 2")
				table.insert(v58, "serverluck 4")
				table.insert(v58, "serverluck 8")
				return v58
			end
			if v62 == "" and (v54:sub(-1) ~= " " or #v56 < 3) then
				local v63 = "serverluck " .. v61 .. " 15"
				table.insert(v58, v63)
				local v64 = "serverluck " .. v61 .. " 30"
				table.insert(v58, v64)
				local v65 = "serverluck " .. v61 .. " 60"
				table.insert(v58, v65)
				return v58
			end
		elseif v56[1]:lower() == "disco" then
			if (v56[2] or "") == "" or (v54:sub(-1) ~= " " or #v56 < 2) then
				table.insert(v58, "disco 15")
				table.insert(v58, "disco 30")
				table.insert(v58, "disco 60")
				return v58
			end
		elseif v56[1]:lower() == "lowgravity" and ((v56[2] or "") == "" or (v54:sub(-1) ~= " " or #v56 < 2)) then
			table.insert(v58, "lowgravity 15")
			table.insert(v58, "lowgravity 30")
			table.insert(v58, "lowgravity 60")
		end
		return v58
	end
	local v66 = v56[2] and v56[2]:lower() or ""
	for _, v67 in v_u_14 do
		if v66 == "" or v67:lower():sub(1, #v66) == v66 then
			local v68 = "lava " .. v67
			table.insert(v58, v68)
		end
	end
	return v58
end
local function v_u_77(p70)
	local v71 = p70:gsub("%s+", " ")
	local _ = v71:find(" ") == nil
	local v72 = {}
	for _, v73 in v71:split(" ") do
		if v73 ~= "" then
			table.insert(v72, v73)
		end
	end
	local v74 = {}
	local v75 = v71:lower()
	if #v72 == 0 then
		return {}
	end
	for _, v76 in {
		"Common",
		"Rare",
		"Epic",
		"Legendary",
		"Mythic",
		"Secret",
		"Celestial"
	} do
		if v76:lower():sub(1, #v75) == v75 then
			table.insert(v74, v76)
		end
	end
	return v74
end
local function v_u_85(p78)
	-- upvalues: (copy) v_u_8
	local v79 = p78:gsub("%s+", " ")
	local _ = v79:find(" ") == nil
	local v80 = {}
	for _, v81 in v79:split(" ") do
		if v81 ~= "" then
			table.insert(v80, v81)
		end
	end
	local v82 = {}
	local v83 = v79:lower()
	if #v80 == 0 then
		return {}
	end
	for v84 in v_u_8 do
		if v84:lower():sub(1, #v83) == v83 then
			table.insert(v82, v84)
		end
	end
	return v82
end
function v1.Init(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_4, (copy) v_u_9, (copy) v_u_10, (copy) v_u_5, (copy) v_u_6, (copy) v_u_30, (copy) v_u_37, (copy) v_u_7, (copy) v_u_52, (copy) v_u_11, (copy) v_u_69, (copy) v_u_85, (copy) v_u_77
	if table.find(v_u_12, v_u_4.UserId) then
		local v_u_86 = false
		local v_u_87 = Color3.fromRGB(255, 20, 60)
		local v_u_88 = Color3.fromRGB(20, 255, 60)
		v_u_9.new():setLabel("Admin"):setRight(true):bindEvent("deselected", function()
			-- upvalues: (ref) v_u_10, (ref) v_u_5
			v_u_10:OpenFrame(v_u_5)
		end):oneClick()
		v_u_5:WaitForChild("CloseBtn").MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_5
			v_u_10:CloseFrame(v_u_5)
		end)
		local v89 = v_u_6:WaitForChild("EventsFrame")
		local v_u_90 = v89:WaitForChild("GlobalBtn")
		local v_u_91 = v_u_90:FindFirstChildOfClass("UIStroke")
		v_u_90.Text = v_u_86 and "GLOBAL: ON" or "GLOBAL: OFF"
		v_u_90.TextColor3 = v_u_86 and v_u_88 and v_u_88 or v_u_87
		if v_u_91 then
			v_u_91.Color = v_u_86 and v_u_88 and v_u_88 or v_u_87
		end
		v_u_90.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_86, (copy) v_u_90, (copy) v_u_88, (copy) v_u_87, (copy) v_u_91
			v_u_86 = not v_u_86
			v_u_90.Text = v_u_86 and "GLOBAL: ON" or "GLOBAL: OFF"
			v_u_90.TextColor3 = v_u_86 and v_u_88 or v_u_87
			if v_u_91 then
				v_u_91.Color = v_u_86 and v_u_88 or v_u_87
			end
		end)
		local v92 = v_u_6:WaitForChild("EconomyFrame")
		local v93 = v92:WaitForChild("Economy")
		local v_u_94 = v93:WaitForChild("PlayerNameBox")
		local v95 = v93:WaitForChild("Options")
		local v_u_96 = v93:WaitForChild("MoneyAmountBox")
		local v97 = v93:WaitForChild("GiveMoneyBtn")
		local v98 = v93:WaitForChild("TakeMoneyBtn")
		v_u_30(v_u_94, v95, v_u_37)
		v97.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_94, (copy) v_u_96, (ref) v_u_7, (ref) v_u_86
			local v99 = v_u_94.Text
			local v100 = v_u_96.Text
			local v101 = tonumber(v100)
			if v99 and (v99 ~= "" and v101) then
				v_u_7:FireServer("GiveMoney", {
					["Player"] = v99,
					["Amount"] = v101,
					["Global"] = v_u_86
				})
			end
		end)
		v98.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_94, (copy) v_u_96, (ref) v_u_7, (ref) v_u_86
			local v102 = v_u_94.Text
			local v103 = v_u_96.Text
			local v104 = tonumber(v103)
			if v102 and (v102 ~= "" and v104) then
				v_u_7:FireServer("TakeMoney", {
					["Player"] = v102,
					["Amount"] = v104,
					["Global"] = v_u_86
				})
			end
		end)
		local v105 = v92:WaitForChild("Items")
		local v_u_106 = v105:WaitForChild("PlayerNameBox")
		local v107 = v105:WaitForChild("PlayerOptions")
		local v_u_108 = v105:WaitForChild("ItemNameBox")
		local v109 = v105:WaitForChild("ItemOptions")
		local v110 = v105:WaitForChild("GiveItemBtn")
		local v111 = v105:WaitForChild("TakeItemBtn")
		local v112 = v105:WaitForChild("SpawnItemBtn")
		local v113 = v105:WaitForChild("SpawnItemServerBtn")
		v_u_30(v_u_106, v107, v_u_37)
		v_u_30(v_u_108, v109, v_u_52)
		v110.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_106, (copy) v_u_108, (ref) v_u_7, (ref) v_u_86
			local v114 = v_u_106.Text
			local v115 = v_u_108.Text
			if v114 and (v114 ~= "" and (v115 and v115 ~= "")) then
				v_u_7:FireServer("GiveItem", {
					["Player"] = v114,
					["Item"] = v115,
					["Global"] = v_u_86
				})
			end
		end)
		v111.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_106, (copy) v_u_108, (ref) v_u_7
			local v116 = v_u_106.Text
			local v117 = v_u_108.Text
			if v116 and (v116 ~= "" and (v117 and v117 ~= "")) then
				v_u_7:FireServer("TakeItem", {
					["Player"] = v116,
					["Item"] = v117
				})
			end
		end)
		v112.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_106, (copy) v_u_108, (ref) v_u_7, (ref) v_u_86
			local v118 = v_u_106.Text
			local v119 = v_u_108.Text
			if v118 and (v118 ~= "" and (v119 and v119 ~= "")) then
				v_u_7:FireServer("SpawnItem", {
					["Player"] = v118,
					["Item"] = v119,
					["Global"] = v_u_86
				})
			end
		end)
		v113.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_108, (ref) v_u_7, (ref) v_u_86
			local v120 = v_u_108.Text
			if v120 and v120 ~= "" then
				v_u_7:FireServer("SpawnItemServer", {
					["Item"] = v120,
					["Global"] = v_u_86
				})
			end
		end)
		local v121 = v89:WaitForChild("Annoucements")
		local v_u_122 = v121:WaitForChild("MessageBox")
		v121:WaitForChild("AnnounceBtn").MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_122, (ref) v_u_7, (ref) v_u_86
			local v123 = v_u_122.Text
			if v123 and v123 ~= "" then
				v_u_7:FireServer("Announce", {
					["Message"] = v123,
					["Global"] = v_u_86
				})
			end
		end)
		local v124 = v_u_6:WaitForChild("PollFrame")
		local v125 = v124:WaitForChild("PollBtn")
		local v_u_126 = v124:WaitForChild("PollDurationBox")
		v125.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_126, (ref) v_u_11, (ref) v_u_86
			local v127 = v_u_126.Text
			v_u_11:OpenPollCreate(v_u_86, tonumber(v127) or 60)
		end)
		local v128 = v89:WaitForChild("Event")
		local v_u_129 = v128:WaitForChild("EventNameBox")
		local v130 = v128:WaitForChild("Options")
		local v131 = v128:WaitForChild("StartEventBtn")
		local v132 = v128:WaitForChild("EndEventBtn")
		v_u_30(v_u_129, v130, v_u_69)
		v131.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_129, (ref) v_u_7, (ref) v_u_86
			local v133 = v_u_129.Text
			if v133 and v133 ~= "" then
				v_u_7:FireServer("StartEvent", {
					["Event"] = v133,
					["Global"] = v_u_86
				})
			end
		end)
		v132.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_129, (ref) v_u_7, (ref) v_u_86
			local v134 = v_u_129.Text
			if v134 and v134 ~= "" then
				v_u_7:FireServer("EndEvent", {
					["Event"] = v134,
					["Global"] = v_u_86
				})
			end
		end)
		local v135 = v_u_6:WaitForChild("TrollFrame")
		local v_u_136 = v135:WaitForChild("PlayerNameBox")
		local v137 = v135:WaitForChild("Options")
		local v138 = v135:WaitForChild("BanBtn")
		local v139 = v135:WaitForChild("ExplodeBtn")
		local v140 = v135:WaitForChild("FlingBtn")
		local v141 = v135:WaitForChild("FreezeBtn")
		local v142 = v135:WaitForChild("InvincibilityOn")
		local v143 = v135:WaitForChild("InvincibilityOff")
		local v144 = v135:WaitForChild("KickBtn")
		local v145 = v135:WaitForChild("KillBtn")
		local v146 = v135:WaitForChild("TpHereBtn")
		local v147 = v135:WaitForChild("TpToBtn")
		local v148 = v_u_6:WaitForChild("CutscenesFrame")
		local v149 = v148:WaitForChild("StartBtn")
		local v_u_150 = v148:WaitForChild("LuckyblockName")
		local v_u_151 = v148:WaitForChild("AreaName")
		local v152 = v148:WaitForChild("LuckyblockOptions")
		local v153 = v148:WaitForChild("AreaNameOptions")
		v_u_30(v_u_136, v137, v_u_37)
		v_u_30(v_u_150, v152, v_u_85)
		v_u_30(v_u_151, v153, v_u_77)
		v149.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_150, (copy) v_u_151, (ref) v_u_7, (ref) v_u_86
			local v154
			if v_u_150.Text == "" then
				v154 = nil
			else
				v154 = v_u_150.Text
			end
			local v155
			if v_u_151.Text == "" then
				v155 = nil
			else
				v155 = v_u_151.Text
			end
			v_u_7:FireServer("SpawnLuckyblockCutscene", {
				["Luckyblock"] = v154,
				["Area"] = v155,
				["Global"] = v_u_86
			})
		end)
		v142.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v156 = v_u_136.Text
			if not v156 or v156 == "" then
				v156 = nil
			end
			if v156 then
				v_u_7:FireServer("InvincibleOn", {
					["Player"] = v156,
					["Global"] = v_u_86
				})
			end
		end)
		v143.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v157 = v_u_136.Text
			if not v157 or v157 == "" then
				v157 = nil
			end
			if v157 then
				v_u_7:FireServer("InvincibleOff", {
					["Player"] = v157,
					["Global"] = v_u_86
				})
			end
		end)
		v138.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v158 = v_u_136.Text
			if not v158 or v158 == "" then
				v158 = nil
			end
			if v158 then
				v_u_7:FireServer("Ban", {
					["Player"] = v158,
					["Global"] = v_u_86
				})
			end
		end)
		v139.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v159 = v_u_136.Text
			if not v159 or v159 == "" then
				v159 = nil
			end
			if v159 then
				v_u_7:FireServer("Explode", {
					["Player"] = v159,
					["Global"] = v_u_86
				})
			end
		end)
		v140.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v160 = v_u_136.Text
			if not v160 or v160 == "" then
				v160 = nil
			end
			if v160 then
				v_u_7:FireServer("Fling", {
					["Player"] = v160,
					["Global"] = v_u_86
				})
			end
		end)
		v141.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v161 = v_u_136.Text
			if not v161 or v161 == "" then
				v161 = nil
			end
			if v161 then
				v_u_7:FireServer("Freeze", {
					["Player"] = v161,
					["Global"] = v_u_86
				})
			end
		end)
		v144.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v162 = v_u_136.Text
			if not v162 or v162 == "" then
				v162 = nil
			end
			if v162 then
				v_u_7:FireServer("Kick", {
					["Player"] = v162,
					["Global"] = v_u_86
				})
			end
		end)
		v145.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v163 = v_u_136.Text
			if not v163 or v163 == "" then
				v163 = nil
			end
			if v163 then
				v_u_7:FireServer("Kill", {
					["Player"] = v163,
					["Global"] = v_u_86
				})
			end
		end)
		v146.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v164 = v_u_136.Text
			if not v164 or v164 == "" then
				v164 = nil
			end
			if v164 then
				v_u_7:FireServer("TPHere", {
					["Player"] = v164,
					["Global"] = v_u_86
				})
			end
		end)
		v147.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_7, (ref) v_u_86
			local v165 = v_u_136.Text
			if not v165 or v165 == "" then
				v165 = nil
			end
			if v165 then
				v_u_7:FireServer("TPTo", {
					["Player"] = v165,
					["Global"] = v_u_86
				})
			end
		end)
	end
end
return v1
