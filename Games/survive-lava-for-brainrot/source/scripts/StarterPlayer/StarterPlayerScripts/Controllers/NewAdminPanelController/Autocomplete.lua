-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Registries.LuckyBlocksRegistry)
require(v2.Registries.MutationRegistry)
local v_u_4 = v2:WaitForChild("Brainrots")
local v_u_5 = {
	"Normal",
	"Gold",
	"Diamond",
	"Emerald",
	"Bloodmoon",
	"Rainbow"
}
local v_u_6 = {
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
return {
	["SetupAutocomplete"] = function(p_u_7, p_u_8, p_u_9)
		local v_u_10 = p_u_8:WaitForChild("Template"):WaitForChild("Template")
		p_u_8.Visible = false
		local v_u_11 = false
		local function v_u_13()
			-- upvalues: (copy) p_u_8, (copy) v_u_10
			for _, v12 in p_u_8:GetChildren() do
				if v12:IsA("TextButton") and v12 ~= v_u_10 then
					v12:Destroy()
				end
			end
		end
		local function v17()
			-- upvalues: (ref) v_u_11, (copy) v_u_13, (copy) p_u_7, (copy) p_u_9, (copy) p_u_8, (copy) v_u_10
			if v_u_11 then
				return
			else
				v_u_13()
				local v14 = p_u_9(p_u_7.Text)
				if v14 and #v14 ~= 0 then
					for _, v_u_15 in v14 do
						local v16 = v_u_10:Clone()
						v16.Name = v_u_15
						v16.Text = v_u_15
						v16.Visible = true
						v16.Parent = p_u_8
						v16.MouseButton1Click:Connect(function()
							-- upvalues: (ref) p_u_7, (copy) v_u_15, (ref) v_u_11, (ref) p_u_8, (ref) v_u_13
							p_u_7.Text = v_u_15
							v_u_11 = true
							p_u_8.Visible = false
							v_u_13()
							task.defer(function()
								-- upvalues: (ref) v_u_11
								v_u_11 = false
							end)
						end)
					end
					p_u_8.Visible = true
				else
					p_u_8.Visible = false
				end
			end
		end
		p_u_7:GetPropertyChangedSignal("Text"):Connect(v17)
		p_u_7.Focused:Connect(v17)
		p_u_7.FocusLost:Connect(function(p18)
			-- upvalues: (copy) p_u_8, (copy) v_u_10, (copy) p_u_7, (ref) v_u_11, (copy) v_u_13
			if not (p18 and p_u_8.Visible) then
				task.delay(0.15, function()
					-- upvalues: (ref) v_u_11, (ref) p_u_8, (ref) v_u_13
					v_u_11 = true
					p_u_8.Visible = false
					v_u_13()
					task.defer(function()
						-- upvalues: (ref) v_u_11
						v_u_11 = false
					end)
				end)
				return
			end
			for _, v19 in p_u_8:GetChildren() do
				if v19:IsA("TextButton") and v19 ~= v_u_10 then
					p_u_7.Text = v19.Text
					break
				end
			end
			v_u_11 = true
			p_u_8.Visible = false
			v_u_13()
			task.defer(function()
				-- upvalues: (ref) v_u_11
				v_u_11 = false
			end)
		end)
	end,
	["GetPlayerSuggestions"] = function(p20)
		-- upvalues: (copy) v_u_1
		local v21 = p20:lower()
		local v22 = {}
		for _, v23 in v_u_1:GetPlayers() do
			if v23.Name:lower():sub(1, #v21) == v21 then
				local v24 = v23.Name
				table.insert(v22, v24)
			elseif v23.DisplayName:lower():sub(1, #v21) == v21 then
				local v25 = v23.DisplayName
				table.insert(v22, v25)
			end
		end
		return v22
	end,
	["GetNumbersSuggestions"] = function(p26)
		local v27 = p26:gsub("%s+", " ")
		local v28 = {}
		for _, v29 in v27:split(" ") do
			if v29 ~= "" then
				table.insert(v28, v29)
			end
		end
		local v30 = {
			"100",
			"1_000",
			"10_000",
			"100_000",
			"1_000_000",
			"10_000_000",
			"100_000_000",
			"1_000_000_000",
			"10_000_000_000",
			"100_000_000_000",
			"1_000_000_000_000",
			"10_000_000_000_000",
			"100_000_000_000_000",
			"1_000_000_000_000_000"
		}
		if #v28 == 0 then
			return v30
		end
		local v31 = v27:lower()
		local v32 = {}
		for _, v33 in v30 do
			if v33:lower():sub(1, #v31) == v31 then
				table.insert(v32, v33)
			end
		end
		return v32
	end,
	["GetChanceSuggestions"] = function(p34)
		local v35 = p34:gsub("%s+", " ")
		local v36 = {}
		for _, v37 in v35:split(" ") do
			if v37 ~= "" then
				table.insert(v36, v37)
			end
		end
		local v38 = {
			"0.001",
			"0.01",
			"0.1",
			"1",
			"2.5",
			"5",
			"10",
			"20",
			"50",
			"75",
			"100"
		}
		if #v36 == 0 then
			return v38
		end
		local v39 = v35:lower()
		local v40 = {}
		for _, v41 in v38 do
			if v41:lower():sub(1, #v39) == v39 then
				table.insert(v40, v41)
			end
		end
		return v40
	end,
	["GetTimeSuggestions"] = function(p42)
		local v43 = p42:gsub("%s+", " ")
		local v44 = {}
		for _, v45 in v43:split(" ") do
			if v45 ~= "" then
				table.insert(v44, v45)
			end
		end
		local v46 = {
			"30",
			"60",
			"120",
			"180",
			"300",
			"600",
			"900",
			"1800",
			"3600"
		}
		if #v44 == 0 then
			return v46
		end
		local v47 = v43:lower()
		local v48 = {}
		for _, v49 in v46 do
			if v49:lower():sub(1, #v47) == v47 then
				table.insert(v48, v49)
			end
		end
		return v48
	end,
	["GetItemSuggestions"] = function(p50)
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		local v51 = p50:gsub("%s+", " ")
		local v52 = v51:find(" ") ~= nil
		local v53 = {}
		for _, v54 in v51:split(" ") do
			if v54 ~= "" then
				table.insert(v53, v54)
			end
		end
		local v55 = {}
		local v56 = v51:lower()
		if #v53 ~= 0 then
			for v57 in v_u_3 do
				if v57:lower():sub(1, #v56) == v56 then
					table.insert(v55, v57)
				end
			end
			if #v53 == 1 and not v52 then
				local v58 = v53[1]:lower()
				local v59 = v_u_4:FindFirstChild("Normal")
				if v59 then
					for _, v60 in v59:GetChildren() do
						if v60.Name:lower():sub(1, #v58) == v58 then
							local v61 = v60.Name
							table.insert(v55, v61)
						end
					end
					return v55
				end
			elseif #v55 == 0 then
				local v62 = v53[2] and (v53[2]:lower() or "") or ""
				for _, v63 in v_u_5 do
					if v62 == "" or v63:lower():sub(1, #v62) == v62 then
						local v64 = v53[1] .. " " .. v63
						table.insert(v55, v64)
					end
				end
			end
			return v55
		end
		for v65 in v_u_3 do
			table.insert(v55, v65)
		end
		local v66 = v_u_4:FindFirstChild("Normal")
		if v66 then
			for _, v67 in v66:GetChildren() do
				local v68 = v67.Name
				table.insert(v55, v68)
			end
		end
		return v55
	end,
	["GetEventSuggestions"] = function(p69)
		-- upvalues: (copy) v_u_6, (copy) v_u_5
		local v70 = p69:gsub("%s+", " ")
		local v71 = v70:find(" ") ~= nil
		local v72 = {}
		for _, v73 in v70:split(" ") do
			if v73 ~= "" then
				table.insert(v72, v73)
			end
		end
		local v74 = {}
		if #v72 == 0 then
			for _, v75 in v_u_6 do
				table.insert(v74, v75)
			end
			return v74
		end
		if #v72 == 1 and not v71 then
			local v76 = v72[1]:lower()
			for _, v77 in v_u_6 do
				if v77:sub(1, #v76) == v76 then
					table.insert(v74, v77)
				end
			end
			return v74
		end
		if v72[1]:lower() ~= "lava" then
			if v72[1]:lower() == "serverluck" then
				local v78 = v72[2] or ""
				local v79 = v72[3] or ""
				if v78 == "" then
					table.insert(v74, "serverluck 2")
					table.insert(v74, "serverluck 4")
					table.insert(v74, "serverluck 8")
					return v74
				end
				if v79 == "" and (v70:sub(-1) ~= " " or #v72 < 3) then
					local v80 = "serverluck " .. v78 .. " 15"
					table.insert(v74, v80)
					local v81 = "serverluck " .. v78 .. " 30"
					table.insert(v74, v81)
					local v82 = "serverluck " .. v78 .. " 60"
					table.insert(v74, v82)
					return v74
				end
			elseif v72[1]:lower() == "disco" then
				if (v72[2] or "") == "" or (v70:sub(-1) ~= " " or #v72 < 2) then
					table.insert(v74, "disco 15")
					table.insert(v74, "disco 30")
					table.insert(v74, "disco 60")
					return v74
				end
			elseif v72[1]:lower() == "lowgravity" and ((v72[2] or "") == "" or (v70:sub(-1) ~= " " or #v72 < 2)) then
				table.insert(v74, "lowgravity 15")
				table.insert(v74, "lowgravity 30")
				table.insert(v74, "lowgravity 60")
			end
			return v74
		end
		local v83 = v72[2] and v72[2]:lower() or ""
		for _, v84 in v_u_5 do
			if v83 == "" or v84:lower():sub(1, #v83) == v83 then
				local v85 = "lava " .. v84
				table.insert(v74, v85)
			end
		end
		return v74
	end,
	["GetAreaNameSuggestions"] = function(p86)
		local v87 = p86:gsub("%s+", " ")
		local v88 = {}
		for _, v89 in v87:split(" ") do
			if v89 ~= "" then
				table.insert(v88, v89)
			end
		end
		local v90 = {
			"Common",
			"Rare",
			"Epic",
			"Legendary",
			"Mythic",
			"Secret",
			"Celestial"
		}
		if #v88 == 0 then
			return v90
		end
		local v91 = v87:lower()
		local v92 = {}
		for _, v93 in v90 do
			if v93:lower():sub(1, #v91) == v91 then
				table.insert(v92, v93)
			end
		end
		return v92
	end,
	["GetLuckyblockSuggestions"] = function(p94)
		-- upvalues: (copy) v_u_3
		local v95 = p94:gsub("%s+", " ")
		local v96 = {}
		for _, v97 in v95:split(" ") do
			if v97 ~= "" then
				table.insert(v96, v97)
			end
		end
		local v98 = {}
		if #v96 == 0 then
			for v99 in v_u_3 do
				table.insert(v98, v99)
			end
			return v98
		end
		local v100 = v95:lower()
		for v101 in v_u_3 do
			if v101:lower():sub(1, #v100) == v100 then
				table.insert(v98, v101)
			end
		end
		return v98
	end
}
