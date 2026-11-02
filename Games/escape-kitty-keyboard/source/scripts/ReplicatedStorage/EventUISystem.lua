

local u1 = game:GetService("CollectionService")
local u2 = game:GetService("MarketplaceService")
local u3 = game:GetService("Players")
local u4 = game:GetService("ReplicatedStorage")
local u5 = game:GetService("SoundService")
local u6 = require(u4:WaitForChild("ClientState"))
local u7 = require(u4:WaitForChild("EventsConfig"))
local u8 = require(u4:WaitForChild("NotificationSystem"))
local u9 = require(u4:WaitForChild("Config"))
local v10 = {}
local u11 = false
local function u14(p12) 

	if p12 then
		local u13 = Instance.new("Sound")
		u13.SoundId = p12.ID
		u13.Volume = p12.Volume or 0.5
		u13.RollOffMaxDistance = 0
		u13.Parent = u5
		u13:Play()
		u13.Ended:Connect(function()

			u13:Destroy()
		end)
	end
end
local function u18(p15) 

	local v16 = u3.LocalPlayer:WaitForChild("PlayerGui")
	for _, v17 in ipairs(u1:GetTagged(p15)) do
		if v17:IsDescendantOf(v16) then
			return v17
		end
	end
end
function v10.Init(_) 

	if u11 then
		return
	end
	u11 = true
	local u19 = {}
	local u20 = {}
	local u21 = {}
	for _, u22 in ipairs(u7.GamepassButtons or {}) do
		for _, v23 in ipairs(u1:GetTagged(u22.Tag)) do
			local u24 = u22.Gamepass
			v23.Activated:Connect(function()

				u2:PromptGamePassPurchase(u3.LocalPlayer, u24)
			end)
			if u19[u24] ~= nil then
				v23.Visible = not u19[u24]
			end
		end
		u1:GetInstanceAddedSignal(u22.Tag):Connect(function(p25)

			local u26 = u22.Gamepass
			p25.Activated:Connect(function()

				u2:PromptGamePassPurchase(u3.LocalPlayer, u26)
			end)
			if u19[u26] ~= nil then
				p25.Visible = not u19[u26]
			end
		end)
	end
	task.spawn(function()

		local u27 = u3.LocalPlayer.UserId
		for _, v28 in ipairs(u7.GamepassButtons or {}) do
			local u29 = v28.Gamepass
			local v30, v31 = pcall(function()

				return u2:UserOwnsGamePassAsync(u27, u29)
			end)
			u19[u29] = v30 and v31
			for _, v32 in ipairs(u1:GetTagged(v28.Tag)) do
				v32.Visible = not u19[u29]
			end
		end
	end)
	u2.PromptGamePassPurchaseFinished:Connect(function(_, p33, p34)

		if p34 then
			u19[p33] = true
			for _, v35 in ipairs(u7.GamepassButtons or {}) do
				if v35.Gamepass == p33 then
					for _, v36 in ipairs(u1:GetTagged(v35.Tag)) do
						v36.Visible = false
					end
				end
			end
		end
	end)
	local u37 = u4:WaitForChild("Remotes"):WaitForChild("BuyEventReward", 10)
	if u37 then
		for _, u38 in ipairs(u7.ShopRewards or {}) do
			local u39 = u38.Tag
			local function v45(p40) 

				p40.Activated:Connect(function()

					local v41, v42 = u37:InvokeServer(u39)
					if v41 then
						local v43 = u38.Reward.Type == "Wins" and "Wins" or "XP"
						u14(u9.SOUNDS.BUY)
						u8:ShowMessage("+" .. v42 .. " " .. v43 .. "!", Color3.fromRGB(100, 255, 140))
						return
					else
						u14(u9.SOUNDS.ERROR)
						local v44 = u18("EventCurrencyModal")
						if v44 then
							u6:ToggleModal(v44)
						else
							u8:ShowMessage("Not enough " .. u38.Currency.Key .. "!", Color3.fromRGB(255, 100, 100))
						end
					end
				end)
			end
			for _, v46 in ipairs(u1:GetTagged(u39)) do
				v46.Activated:Connect(function()

					local v47, v48 = u37:InvokeServer(u39)
					if v47 then
						local v49 = u38.Reward.Type == "Wins" and "Wins" or "XP"
						u14(u9.SOUNDS.BUY)
						u8:ShowMessage("+" .. v48 .. " " .. v49 .. "!", Color3.fromRGB(100, 255, 140))
						return
					else
						u14(u9.SOUNDS.ERROR)
						local v50 = u18("EventCurrencyModal")
						if v50 then
							u6:ToggleModal(v50)
						else
							u8:ShowMessage("Not enough " .. u38.Currency.Key .. "!", Color3.fromRGB(255, 100, 100))
						end
					end
				end)
			end
			u1:GetInstanceAddedSignal(u39):Connect(v45)
		end
	end
	for _, v51 in ipairs(u7.CurrencyDevProducts or {}) do
		local u52 = v51.Id
		local function v54(p53) 

			p53.Activated:Connect(function()

				u2:PromptProductPurchase(u3.LocalPlayer, u52)
			end)
		end
		for _, v55 in ipairs(u1:GetTagged(v51.Tag)) do
			v55.Activated:Connect(function()

				u2:PromptProductPurchase(u3.LocalPlayer, u52)
			end)
		end
		u1:GetInstanceAddedSignal(v51.Tag):Connect(v54)
	end
	local u56 = {}
	for _, v57 in ipairs(u7.CurrencyDevProducts or {}) do
		u56[v57.Id] = true
	end
	u2.PromptProductPurchaseFinished:Connect(function(_, p58, p59)

		if u56[p58] then
			u14(p59 and u9.SOUNDS.BUY or u9.SOUNDS.ERROR)
		end
	end)
	local u60 = {}
	for _, v61 in ipairs(u7.GamepassButtons or {}) do
		u60[v61.Gamepass] = true
	end
	u2.PromptGamePassPurchaseFinished:Connect(function(_, p62, p63)

		if u60[p62] then
			u14(p63 and u9.SOUNDS.BUY or u9.SOUNDS.ERROR)
		end
	end)
	local v64 = os.time()
	local v65 = false
	for _, v66 in ipairs(u7.Events) do
		if v66.Start <= v64 and v64 < v66.End then
			v65 = true
			break
		end
	end
	for _, v67 in ipairs(u1:GetTagged("UIActionBtn")) do
		if v67:GetAttribute("Action") == "EventShop" then
			v67.Visible = v65
		end
	end
	for u68, v69 in ipairs(u7.Events) do
		u20[u68] = false
		u21[u68] = false
		if v69.FrameTag and v69.FrameTag ~= "" then
			for _, v70 in ipairs(u1:GetTagged(v69.FrameTag)) do
				v70.Visible = false
			end
		end
		for _, v71 in ipairs(v69.ExtraFrameTags or {}) do
			for _, v72 in ipairs(u1:GetTagged(v71)) do
				v72.Visible = false
			end
		end
		if v69.TimerTag then
			for _, v73 in ipairs(u1:GetTagged(v69.TimerTag)) do
				v73.Visible = false
			end
		end
		if v69.FrameTag and v69.FrameTag ~= "" then
			u1:GetInstanceAddedSignal(v69.FrameTag):Connect(function(p74)

				local v75 = u7.Events[u68]
				local v76 = os.time()
				local v77 = v75.FrameTag:gsub("Frame$", "")
				local v78 = table.find(u6:Get().OwnedTrails or {}, v77) ~= nil
				if not v78 then
					if v75.Start <= v76 then
						v78 = v76 < v75.End
					else
						v78 = false
					end
				end
				p74.Visible = v78
			end)
		end
		for _, u79 in ipairs(v69.ExtraFrameTags or {}) do
			u1:GetInstanceAddedSignal(u79):Connect(function(p80)

				local v81 = u7.Events[u68]
				local v82 = os.time()
				local v83 = u79:gsub("Frame$", "")
				local v84 = table.find(u6:Get().OwnedTrails or {}, v83) ~= nil
				if not v84 then
					if v81.Start <= v82 then
						v84 = v82 < v81.End
					else
						v84 = false
					end
				end
				p80.Visible = v84
			end)
		end
	end
	task.spawn(function()

		local u85 = u3.LocalPlayer.UserId
		for u86, u87 in ipairs(u7.Events) do
			task.spawn(function()

				if u87.Gamepass and u87.Gamepass > 0 then
					local v88, v89 = pcall(function()

						return u2:UserOwnsGamePassAsync(u85, u87.Gamepass)
					end)
					if v88 then
						u20[u86] = v89
					end
				end
				u21[u86] = true
			end)
			local v90 = os.time()
			if v90 < u87.Start then
				local v91 = u87.Start - v90
				task.delay(v91, function()

					local _ = u6:Get().OwnedTrails
					if u87.FrameTag and u87.FrameTag ~= "" then
						for _, v92 in ipairs(u1:GetTagged(u87.FrameTag)) do
							v92.Visible = true
						end
					end
					for _, v93 in ipairs(u87.ExtraFrameTags or {}) do
						for _, v94 in ipairs(u1:GetTagged(v93)) do
							v94.Visible = true
						end
					end
				end)
			end
		end
		while true do
			local v95 = os.time()
			local v96 = u6:Get().OwnedTrails or {}
			local v97 = {}
			local v98 = {}
			local v99 = nil
			for _, v100 in ipairs(u7.Events) do
				local v101
				if v100.Start <= v95 then
					v101 = v95 < v100.End
				else
					v101 = false
				end
				if v101 then
					v99 = v100.Name
				end
				if v100.FrameTag and v100.FrameTag ~= "" then
					local v102 = v100.FrameTag:gsub("Frame$", "")
					local v103 = table.find(v96, v102) ~= nil
					v97[v100.FrameTag] = v97[v100.FrameTag] or (v103 or v101)
				end
				for _, v104 in ipairs(v100.ExtraFrameTags or {}) do
					local v105 = v104:gsub("Frame$", "")
					local v106 = table.find(v96, v105) ~= nil
					v97[v104] = v97[v104] or (v106 or v101)
				end
				if v100.TimerTag then
					if not v98[v100.TimerTag] then
						v98[v100.TimerTag] = {
							["visible"] = false
						}
					end
					if v101 then
						v98[v100.TimerTag].visible = true
						local v107 = v98[v100.TimerTag]
						local v108 = v100.End - v95
						local v109
						if v108 <= 0 then
							v109 = "0j 00h 00m 00s"
						else
							local v110 = v108 / 86400
							local v111 = math.floor(v110)
							local v112 = v108 % 86400 / 3600
							local v113 = math.floor(v112)
							local v114 = v108 % 3600 / 60
							local v115 = math.floor(v114)
							local v116 = v108 % 60
							v109 = string.format("%dj %02dh %02dm %02ds", v111, v113, v115, v116)
						end
						v107.text = v109
					end
				end
			end
			for v117, v118 in pairs(v97) do
				for _, v119 in ipairs(u1:GetTagged(v117)) do
					v119.Visible = v118
				end
			end
			for v120, v121 in pairs(v98) do
				for _, v122 in ipairs(u1:GetTagged(v120)) do
					v122.Visible = v121.visible
					if v121.visible and v121.text then
						v122.Text = v121.text
					end
				end
			end
			local v123 = v99 ~= nil
			for _, v124 in ipairs(u1:GetTagged("UIActionBtn")) do
				if v124:GetAttribute("Action") == "EventShop" then
					v124.Visible = v123
				end
			end
			local v125 = {}
			local v126 = {}
			local v127 = {}
			for _, v128 in ipairs(u7.Currencies) do
				if v128.Events then
					for _, v129 in ipairs(v128.Events) do
						if v129 == v99 then
							local v130 = v128.Key
							table.insert(v125, v130)
							if (v128.Rarity or 0) == 0 then
								local v131 = v128.Key
								table.insert(v127, v131)
							elseif v128.Rarity == 1 then
								local v132 = v128.Key
								table.insert(v126, v132)
							end
						end
					end
				end
			end
			local v133 = #v125 > 0
			local v134 = #v126 > 0
			local v135 = u6:Get()
			for _, v136 in ipairs(u1:GetTagged("EventCurrencyFrame")) do
				v136.Visible = v133
			end
			for _, v137 in ipairs(u1:GetTagged("EventCurrency")) do
				local v138 = v137:GetAttribute("CurrencyKey")
				if v138 then
					local v139 = v135[v138] or 0
					v137.Text = tostring(v139)
				else
					local v140 = v127[1] and (v135[v127[1]] or 0) or 0
					v137.Text = tostring(v140)
				end
			end
			for _, v141 in ipairs(u1:GetTagged("EventCurrency2")) do
				v141.Visible = v134
				if v134 then
					local v142 = v141:GetAttribute("CurrencyKey")
					if v142 then
						local v143 = v135[v142] or 0
						v141.Text = tostring(v143)
					else
						local v144 = v126[1] and (v135[v126[1]] or 0) or 0
						v141.Text = tostring(v144)
					end
				end
			end
			local v145 = {}
			for _, v146 in ipairs(u7.Currencies) do
				if v146.Icon and v146.Icon ~= 0 then
					v145[v146.Key] = "rbxassetid://" .. v146.Icon
				end
			end
			for _, v147 in ipairs(u1:GetTagged("EventCurrencyIcon")) do
				local v148 = v147:GetAttribute("CurrencyKey")
				local v149
				if v148 then
					v149 = v145[v148]
				else
					v149 = v127[1]
					if v149 then
						v149 = v145[v127[1]]
					end
				end
				if v149 then
					v147.Image = v149
				end
			end
			for _, v150 in ipairs(u1:GetTagged("EventCurrencyIcon2")) do
				v150.Visible = v134
				if v134 then
					local v151 = v150:GetAttribute("CurrencyKey")
					local v152
					if v151 then
						v152 = v145[v151]
					else
						v152 = v126[1]
						if v152 then
							v152 = v145[v126[1]]
						end
					end
					if v152 then
						v150.Image = v152
					end
				end
			end
			task.wait(1)
		end
	end)
end
return v10