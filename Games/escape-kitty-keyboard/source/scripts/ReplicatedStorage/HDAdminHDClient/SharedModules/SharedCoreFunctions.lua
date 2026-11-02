

local u1 = {}
local u2 = _G.HDAdminMain
local u3 = game:GetService("RunService"):IsClient()
function u1.SetSeed(_, p4) 
	if p4 > 100000000 then
		local v5 = #tostring(100000000)
		local v6 = tostring(p4)
		local v7 = -v5
		local v8 = string.sub(v6, v7)
		p4 = tonumber(v8)
	end
	math.randomseed(p4)
	return p4
end
local u9 = {}
function u1.GetAnimationId(_, u10) 

	local v11 = tostring(u10)
	local v12 = u9[v11]
	if v12 then
		return v12
	end
	if u3 then
		local v13, v14 = pcall(function()

			return u2.signals.GetAnimationId:InvokeServer(u10)
		end)
		if not (v13 and v14) then
			return 0
		end
		u9[v11] = v14
		return v14
	end
	local v15, v16 = pcall(function()

		return game:GetService("InsertService"):LoadAsset(u10)
	end)
	if v15 then
		if v15 then
			v15 = v16:FindFirstChildOfClass("Animation")
		end
		if v15 then
			local v17 = v15.AnimationId
			v12 = tonumber(v17:match("%d+"))
			u9[v11] = v12
			v15:Destroy()
		end
		return v12
	end
end
local u18 = nil
function u1.GetEmotesDict(_) 

	if u18 then
		return u18
	end
	local v19 = u2:GetModule("cf"):GetEmotes()
	u18 = {}
	for _, v20 in v19 do
		local v21 = v20.id
		u18[tostring(v21)] = v20.name
	end
	return u18
end
local u22 = nil
local u23 = false
local u24 = false
function u1.GetEmotes(_, u25) 

	if u3 then
		while u24 do
			task.wait(0.5)
		end
		if u22 then
			return u22
		end
		u24 = true
		local v26, v27 = pcall(function()

			return u2.signals.GetEmotes:InvokeServer()
		end)
		u24 = false
		if not v26 or typeof(v27) ~= "table" then
			return {}
		end
		u22 = v27
		return u22
	end
	local function v39(p28) 

		local v29 = u25
		if v29 then
			v29 = u2.pd[u25]
		end
		if v29 then
			v29 = v29.FavoritedUGC
		end
		if typeof(v29) == "table" then
			local v30 = {}
			for _, v31 in p28 do
				local v32 = v31.id
				v30[tostring(v32)] = true
			end
			for v33, v34 in v29 do
				local v35 = tostring(v33)
				if not v30[v35] then
					v30[v35] = true
					local v36 = v34.name
					local v37 = tostring(v36)
					local v38 = {
						["id"] = tonumber(v33),
						["name"] = v37
					}
					table.insert(p28, v38)
				end
			end
		end
		return p28
	end
	local u40 = game:GetService("AvatarEditorService")
	if u23 == true then
		repeat
			task.wait(1)
		until u23 ~= true
	end
	if u22 then
		return v39(u22)
	end
	local v41 = {}
	local u42 = CatalogSearchParams.new()
	u42.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
	u42.CreatorType = Enum.CreatorTypeFilter.Group
	u42.CreatorId = 4676369
	u42.SortType = Enum.CatalogSortType.RecentlyCreated
	u42.Limit = 120
	u23 = true
	local v43 = 1
	while true do
		local v44, u45 = pcall(function()

			return u40:SearchCatalog(u42)
		end)
		if v44 then
			break
		end
		task.wait(v43)
		v43 = v43 * 2
	end
	while true do
		for _, v46 in u45:GetCurrentPage() do
			table.insert(v41, v46)
		end
		if u45.IsFinished then
			break
		end
		local v47, v48 = pcall(function()

			u45:AdvanceToNextPageAsync()
		end)
		if not v47 then
			warn("Failed to advance to next page:", v48)
			break
		end
		task.wait(0.1)
		if u45.IsFinished then
			break
		end
	end
	u23 = false
	if #v41 == 0 then
		return v39({})
	end
	u22 = {}
	local v49 = u2:GetModule("Emotes") or {}
	local v50 = {}
	local v51 = {}
	for _, v52 in v49 do
		local v53 = v52.id
		local v54 = v52.name
		v50[tostring(v53)] = v54
	end
	for _, v55 in v41 do
		local v56 = v55.Name
		local v57 = tostring(v56)
		local v58 = v55.Id
		local v59 = v50[tostring(v58)] or u2:GetModule("cf"):normalizeName(v57)
		local v60 = u22
		table.insert(v60, {
			["id"] = v58,
			["name"] = v59
		})
		v51[tostring(v58)] = true
	end
	for _, v61 in v49 do
		local v62 = v61.id
		local v63 = tostring(v62)
		if not v51[v63] then
			v51[v63] = true
			local v64 = u22
			table.insert(v64, v61)
		end
	end
	return v39(u22)
end
function u1.denormalizeName(_, p65) 
	if p65 == "" then
		return ""
	end
	local v66 = {}
	local v67 = 1
	for v68 = 2, #p65 do
		if p65:sub(v68, v68):match("%u") then
			local v69 = v68 - 1
			table.insert(v66, p65:sub(v67, v69))
			v67 = v68
		end
	end
	table.insert(v66, p65:sub(v67))
	for v70, v71 in ipairs(v66) do
		v66[v70] = v71:sub(1, 1):upper() .. v71:sub(2):lower()
	end
	return table.concat(v66, " ")
end
function u1.normalizeName(_, p72) 
	local v73 = {}
	for v74 in tostring(p72):match("^%s*(.-)%s*$"):gsub("[^%a%s]", ""):gmatch("%S+") do
		table.insert(v73, v74)
	end
	local v75 = #v73
	if v75 == 0 then
		return ""
	end
	if v75 == 1 then
		return v73[1]:lower()
	end
	if v75 ~= 2 then
		return table.concat(v73, ""):lower()
	end
	local v76 = v73[1]:lower()
	local v77 = v73[2]
	return v76 .. v77:sub(1, 1):upper() .. v77:sub(2):lower()
end
local u78 = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"0",
	"<",
	">",
	"?",
	"@",
	"{",
	"}",
	"[",
	"]",
	"!",
	"(",
	")",
	"=",
	"+",
	"~",
	"#"
}
local function u83(p79) 

	local v80 = {}
	if p79 == "Letters" then
		for _, v81 in u78 do
			table.insert(v80, v81)
			if v81 == "Z" then
				return v80
			end
		end
	elseif p79 == "LettersAndNumbers" then
		for _, v82 in u78 do
			table.insert(v80, v82)
			if v82 == "0" then
				return v80
			end
		end
	elseif p79 ~= nil then
		error((("Limiter \'%*\' does not exist!"):format(p79)))
	end
	return u78
end
function u1.GenerateUID(_, p84, p85) 

	local v86 = u83(p85)
	local v87 = #v86
	local v88 = ""
	for _ = 1, p84 or 8 do
		v88 = v88 .. v86[math.random(1, v87)]
	end
	return v88
end
local u89 = nil
function u1.PromptGamepass(_, u90, u91) 

	if u2.runService:IsServer() then
		u2.signals.PromptGamepass:FireClient(u90, u91)
	else
		task.defer(function()

			if u91 == "Booster" then
				if u2.gui.MainFrame.Pages.Boost.Buy.Banner.Fade.Discount.Visible then
					u91 = u2.accessories.Booster2
				else
					u91 = u2.accessories.Booster
				end
			end
			local v92 = false
			for _, v93 in u2.accessories do
				local v94 = u91
				if tostring(v93) == tostring(v94) then
					v92 = true
					break
				end
			end
			if v92 then
				u2.signals.PurchaseAccessory:FireServer(u91)
				return
			else
				local v95 = u91
				local v96 = u91
				if tonumber(v96) == nil then
					local v97 = u91
					if typeof(v97) == "string" then
						v95 = u2.products[u91]
					end
				end
				local u98 = false
				local v99 = u91
				if tonumber(v99) == nil then
					local v100 = u91
					if typeof(v100) == "string" then
						u98 = u2.accessories[u91]
					end
				end
				local u101 = v95 or (u98 or 0)
				local v102 = game:GetService("LogService")
				if u89 then
					u89:Disconnect()
					u89 = nil
				end
				local v103 = u2:GetModule("cf"):GetGamepasses()
				local v104 = tostring(u101)
				local u105 = nil
				for _, v106 in pairs(v103) do
					u105 = v106[v104]
					if u105 then
						break
					end
				end
				u89 = v102.MessageOut:Connect(function(p107, p108)

					if p108 == Enum.MessageType.MessageWarning and tostring(p107):match("AllowThirdPartySales") then
						if u105 and (not u105.FromHD and (not u105.Rank or u105.Rank and (u2.pdata.Rank and u105.Rank <= u2.pdata.Rank))) then
							local v109 = { "CallFunctionOnClick", function()

									u2:GetModule("cf"):CreateNewCommandMenu("purchase", u101, 14)
								end }
							u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, "ThirdPartySales must be enabled. Click to see how.", v109)
						elseif u98 then
							u2.signals.PurchaseAccessory:FireServer(u98)
						else
							u2:GetModule("cf"):CreateNewCommandMenu("purchase", u101, 13)
						end
						if u89 then
							u89:Disconnect()
							u89 = nil
						end
					end
				end)
				task.delay(5, function()

					if u89 then
						u89:Disconnect()
						u89 = nil
					end
				end)
				if game:GetService("RunService"):IsStudio() then
					u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, "This can only be purchased in-game.")
				else
					local _, _ = pcall(function()

						return u2.marketplaceService:PromptGamePassPurchase(u90, u101)
					end)
				end
			end
		end)
	end
end
function u1.WaitForEvent(_, ...) 
	local v110 = ({ ... })[1]
	local u111
	if typeof(v110) == "Instance" and v110:IsA("BindableEvent") then
		u111 = v110
	else
		u111 = Instance.new("BindableEvent")
	end
	local v112 = {}
	for _, v113 in pairs({ ... }) do
		if v113 ~= v110 then
			v112[#v112 + 1] = v113:Connect(function()

				u111:Fire()
			end)
		end
	end
	u111.Event:Wait()
	u111:Destroy()
	for _, v114 in pairs(v112) do
		v114:Disconnect()
	end
end
function u1.HasBooster(_, p115) 

	local u116 = p115 or u2.player
	local v117, v118 = pcall(function()

		return (u2.marketplaceService:UserOwnsGamePassAsync(u116.UserId, u2.products.Booster) or (u2.marketplaceService:UserOwnsGamePassAsync(u116.UserId, u2.products.Donor) or (u2.marketplaceService:PlayerOwnsAsset(u116, u2.accessories.Booster) or u2.marketplaceService:PlayerOwnsAsset(u116, u2.accessories.Booster2)))) and true or false
	end)
	return v117 == true and v118 == true
end
function u1.CreateSound(_, p119) 
	local v120 = Instance.new("Sound")
	for v121, v123 in pairs(p119) do
		if v121 == "SoundId" then
			local v123 = "rbxassetid://" .. v123
		end
		v120[v121] = v123
	end
	return v120
end
function u1.FormatNotice2(_, p124, p125, ...) 

	local v126 = u2:GetModule("CoreNotices"):GetNotice(p124)
	v126[2] = string.format(v126[2], ...)
	v126[3] = p125
	return v126
end
function u1.FormatNotice(_, p127, ...) 

	local v128 = u2:GetModule("CoreNotices"):GetNotice(p127)
	v128[2] = string.format(v128[2], ...)
	return v128
end
function u1.RandomiseTable(_, p129, p130) 
	local v131
	if p130 then
		local v132 = os.time() / p130
		v131 = math.floor(v132)
	else
		v131 = p130
	end
	local v133 = {}
	if p129[1] ~= nil then
		for v134 = 1, #p129 do
			if p130 then
				math.randomseed(v131 + v134)
			end
			local v135 = math.random(1, #v133 + 1)
			local v136 = p129[v134]
			table.insert(v133, v135, v136)
		end
	end
	return v133
end
function u1.IsPunished(_, p137) 
	return (not p137 or (not p137.Character or p137.Character.Parent ~= workspace)) and true or false
end
function u1.UnSeatPlayer(_, p138) 

	local v139 = u1:GetHumanoid(p138)
	if v139 then
		local v140 = v139.SeatPart
		local v141 = v140 and v140:FindFirstChild("SeatWeld")
		if v141 then
			v141:Destroy()
			wait()
		end
	end
end
function u1.GetBanDateString(_, p142, p143) 

	local v144 = p142.min or p143.min
	local v145 = p142.hour or p143.hour
	local v146 = p142.day or p143.day
	local v147 = u2:GetModule("cf"):GetMonths()[p142.month or p143.month]
	local v148 = p142.year or p143.year
	if v144 < 10 then
		v144 = "0" .. v144
	end
	if v145 < 10 then
		v145 = "0" .. v145
	end
	local v149 = string.sub(v146, -1)
	local v150 = tonumber(v149)
	local v151 = "th"
	if v150 < 10 or v150 > 15 then
		v151 = v150 == 1 and "st" or (v150 == 2 and "nd" or (v150 == 3 and "rd" or v151))
	end
	return v145 .. ":" .. v144 .. ", " .. v146 .. v151 .. " " .. v147 .. " " .. v148 .. ((p142 or not p143) and "" or " UTC")
end
function u1.GetTimeAmount(_, p152, p153) 
	local v154 = 0
	local v155 = ""
	local v156 = p153 < 0 and 0 or p153
	if p152 == "m" then
		v156 = v156 > 60 and 60 or v156
		v154 = v156 * 60
		v155 = "Minutes"
	elseif p152 == "h" then
		v156 = v156 > 24 and 24 or v156
		v154 = v156 * 3600
		v155 = "Hours"
	elseif p152 == "d" then
		v156 = v156 > 100000 and 100000 or v156
		v154 = v156 * 86400
		v155 = "Days"
	end
	return v154, v155, v156
end
function u1.GetMonths(_) 
	return {
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	}
end
function u1.AnchorModel(_, p157, p158) 
	for _, v159 in pairs(p157:GetDescendants()) do
		if v159:IsA("BasePart") and not v159.Parent:IsA("Accessory") then
			v159.Anchored = p158
		end
	end
end
function u1.TweenModel(_, u160, p161, p162) 

	local u163 = Instance.new("CFrameValue")
	u163.Value = u160:GetPrimaryPartCFrame()
	local u164 = nil
	u164 = u163:GetPropertyChangedSignal("Value"):Connect(function()

		if u160.PrimaryPart == nil then
			u164:Disconnect()
		else
			u160:SetPrimaryPartCFrame(u163.Value)
		end
	end)
	local v165 = u2.tweenService:Create(u163, p162, {
		["Value"] = p161
	})
	v165:Play()
	v165.Completed:Connect(function()

		u163:Destroy()
	end)
end
function u1.Movement(_, p166, p167) 

	if p167 == nil then
		p167 = u2.player
	end
	local v168 = u1:GetHRP(p167)
	local v169 = u1:GetHumanoid(p167)
	if v168 and v169 then
		if not p166 then
			local v170 = v169.WalkSpeed
			v169.WalkSpeed = 0
			wait()
			v169.WalkSpeed = v170
			v168.Anchored = true
			return
		end
		v168.Anchored = false
	end
end
function u1.SetFakePart(_, u171, u172, u173) 

	task.defer(function()

		local u174 = u173.Name
		local u175 = u2:GetModule("MorphHandler"):CreateFakeBodyPart(u171, u173)
		local u176 = {}
		local function v180() 

			for _, v177 in pairs(u176) do
				v177:Disconnect()
			end
			u175:Destroy()
			if not u175:GetAttribute("DisableMorphPart") then
				local v178 = u171:WaitForChild(u174, 4)
				local v179 = u171:FindFirstChildOfClass("Humanoid")
				if v178 and (u171.Parent and (v179 and v179.Health > 0)) then
					u1:SetFakePart(u171, u172, v178)
				end
			end
		end
		local v181 = u173.Destroying
		table.insert(u176, v181:Once(v180))
		local v182 = u173:GetPropertyChangedSignal("Size")
		table.insert(u176, v182:Once(v180))
		for v183, v184 in pairs(u172) do
			if v183 == "Material" then
				u175.Material = v184
				if v184 == Enum.Material.Glass then
					u175.Transparency = 0.5
				else
					u175.Transparency = 0
				end
			elseif v183 == "Reflectance" then
				u175.Reflectance = v184
			elseif v183 == "Transparency" then
				u175.Transparency = v184
			elseif v183 == "Color" then
				u175.Color = v184
			end
		end
	end)
end
function u1.SetFakeBodyParts(_, p185, p186) 

	for _, v187 in pairs(p185:GetDescendants()) do
		local v188 = v187.Parent
		if (v188 == p185 or v188 and v188:IsA("Accessory")) and u2:GetModule("cf"):CheckBodyPart(v187) then
			u1:SetFakePart(p185, p186, v187)
		end
	end
end
function u1.CheckBodyPart(_, p189) 
	if p189:IsA("BasePart") and p189.Name ~= "HumanoidRootPart" then
		local v190 = p189.Name
		if string.sub(v190, 1, 4) ~= "Fake" then
			return true
		end
	end
	return false
end
function u1.CreateClone(_, p191) 

	if p191 == nil then
		p191 = u2.player.Character
	end
	local v192 = p191:FindFirstChild("Humanoid")
	if v192 then
		p191.Archivable = true
		local v193 = p191:Clone()
		local v194 = v193.Humanoid
		v193.Name = p191.Name .. "\'s HDAdminClone"
		local v195 = v193:FindFirstChild("Chest") and true or false
		for _, v196 in pairs(v193:GetDescendants()) do
			if v196:IsA("Humanoid") then
				v196.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			elseif v196:IsA("BillboardGui") then
				v196:Destroy()
			elseif v196:IsA("Weld") and v196.Part1 ~= nil then
				v196.Part0 = v196.Parent
				if v193:FindFirstChild(v196.Part1.Name) then
					v196.Part1 = v193[v196.Part1.Name]
				elseif not v195 then
					v196:Destroy()
				end
			end
		end
		v193.Parent = workspace
		local v197 = {}
		v192:GetAppliedDescription()
		if v193:FindFirstChild("Animate") then
			for _, v198 in pairs(v193.Animate:GetChildren()) do
				local v199 = v198:GetChildren()[1]
				if v199 then
					v197[v198.Name] = v194:LoadAnimation(v199)
				end
			end
			v197.idle:Play()
		end
		return v193, v197
	end
end
function u1.SetTransparency(_, p200, p201, p202) 

	local v203 = u2.players:GetPlayerFromCharacter(p200)
	if (not v203 or (not u2.pd[v203] or (not u2.pd[v203].Items.UnderControl or p202))) and p200 then
		local v204 = p200:FindFirstChild("FakeHead") and true or false
		for _, v205 in pairs(p200:GetDescendants()) do
			if v205:IsA("BasePart") and v205.Name ~= "HumanoidRootPart" or v205.Name == "face" and v205:IsA("Decal") then
				local v206 = v205:FindFirstChild("OriginalTransparency")
				if p201 == 1 and (v205.Transparency ~= 0 and not v206) then
					local v207 = Instance.new("IntValue")
					v207.Name = "OriginalTransparency"
					v207.Value = v205.Transparency
					v207.Parent = v205
				elseif p201 == 0 and v206 then
					v205.Transparency = v206.Value
					v206:Destroy()
				elseif not v204 or p200:FindFirstChild(v205.Name .. "Fake") == nil then
					v205.Transparency = p201
				end
			elseif v205:IsA("ParticleEmitter") and v205.Name == "BodyEffect" or v205:IsA("PointLight") then
				if p201 == 1 then
					v205.Enabled = false
				elseif p201 == 0 then
					v205.Enabled = true
				end
			elseif v205:IsA("BillboardGui") then
				if p201 == 1 then
					v205.Enabled = false
				elseif p201 == 0 then
					v205.Enabled = true
				end
			end
		end
	end
end
function u1.GetMessageTime(_, p208) 
	local v209 = string.len(p208) * 0.08 + 2
	return v209 > 10 and 10 or v209
end
function u1.GetProductInfo(_, u210) 

	local v211, v212 = pcall(function()

		return u2.marketplaceService:GetProductInfo(u210)
	end)
	return not v211 and {} or v212
end
function u1.CheckIfValidSound(_, p213) 

	return u1:GetProductInfo(p213).AssetTypeId == 3
end
function u1.GetChar(_, p214) 

	if p214 == nil then
		p214 = u2.player
	end
	if p214 then
		return p214.Character
	end
end
function u1.GetHRP(_, p215) 

	if p215 == nil then
		p215 = u2.player
	end
	if p215 and p215.Character then
		return p215.Character:FindFirstChild("HumanoidRootPart")
	end
end
function u1.GetNeck(_, p216) 

	if p216 == nil then
		p216 = u2.player
	end
	local v217 = p216 and (p216.Character and p216.Character:FindFirstChild("Head"))
	if v217 then
		local v218 = v217:FindFirstChild("Neck")
		local v219 = p216.Character:FindFirstChild("Torso")
		if not v218 and v219 then
			v218 = v219:FindFirstChild("Neck")
		end
		return v218
	end
end
function u1.GetHead(_, p220) 

	if p220 == nil then
		p220 = u2.player
	end
	if p220 and p220.Character then
		return p220.Character:FindFirstChild("Head")
	end
end
function u1.GetFace(_, p221) 

	if p221 == nil then
		p221 = u2.player
	end
	if p221 and p221.Character then
		local v222 = p221.Character:FindFirstChild("Head")
		if v222 then
			local v223 = v222:FindFirstChild("face")
			if v223 and v223.ClassName == "Decal" then
				return v223
			end
		end
		return v222
	end
end
function u1.GetHumanoid(_, p224) 

	if p224 == nil then
		p224 = u2.player
	end
	if p224 and p224.Character then
		return p224.Character:FindFirstChild("Humanoid")
	end
end
function u1.GetTorso(_, p225) 

	if p225 == nil then
		p225 = u2.player
	end
	if p225 and p225.Character then
		return p225.Character:FindFirstChild("UpperTorso") or p225.Character:FindFirstChild("Torso")
	end
end
function u1.SetJumpHeight(_, p226, p227) 

	local v228 = u1:GetHumanoid(p226)
	if v228 then
		v228.JumpHeight = p227
		local v229 = 2 * workspace.Gravity * p227
		v228.JumpPower = math.sqrt(v229)
	end
end
function u1.GetDescription(_, p230) 

	local v231 = u1:GetHumanoid(p230)
	if v231 then
		v231 = v231:GetAppliedDescription()
	end
	return v231
end
function u1.GetProductInfo(_, u232, u233) 

	local u234 = {}
	local _, _ = pcall(function()

		u234 = u2.marketplaceService:GetProductInfo(u232, u233)
	end)
	return u234
end
function u1.GetFriends(_, u235) 

	local v236 = {}
	local v237, u238 = pcall(function()

		return u2.players:GetFriendsAsync(u235)
	end)
	if v237 then
		while true do
			local v239 = u238:GetCurrentPage()
			for _, v240 in pairs(v239) do
				v236[v240.Username] = v240.Id
			end
			if not (u238.IsFinished or pcall(function()

				return u238:AdvanceToNextPageAsync()
			end)) or u238.IsFinished then
				goto l2
			end
		end
	else
		::l2::
		return v236
	end
end
function u1.GetRankName(_, p241) 

	local v242 = ""
	for _, v243 in pairs(u2.settings.Ranks) do
		local v244 = v243[1]
		local v245 = v243[2]
		if p241 == v244 then
			v242 = v245
		end
	end
	return v242
end
function u1.GetRankId(_, p246) 

	local v247 = 0
	for _, v248 in pairs(u2.settings.Ranks) do
		local v249 = v248[1]
		if p246 == v248[2] then
			v247 = v249
		end
	end
	return v247
end
function u1.CheckRankExists(_, p250) 

	for _, v251 in pairs(u2.settings.Ranks) do
		if string.lower(v251[2]) == p250 then
			return true
		end
	end
	return false
end
function u1.GetUserId(_, u252) 

	tick()
	local v253 = u2.UserIdsFromName[u252]
	if not v253 or v253 <= 1 then
		local u254 = 1
		local _, _ = pcall(function()

			u254 = u2.players:GetUserIdFromNameAsync(u252)
		end)
		u2.UserIdsFromName[u252] = u254
		v253 = u254
	end
	return v253
end
function u1.GetName(_, p255) 

	local v256 = tostring(p255)
	local u257 = tonumber(p255)
	local u258 = u2.UsernamesFromUserId[v256]
	if not u258 then
		u258 = ""
		if u257 then
			local v259, _ = pcall(function()

				u258 = u2.players:GetNameFromUserIdAsync(u257)
			end)
			if v259 then
				u2.UsernamesFromUserId[v256] = u258
			end
		end
	end
	return u258
end
function u1.FindValue(_, p260, p261) 
	for _, v262 in pairs(p260) do
		if tostring(v262) == tostring(p261) then
			return true
		end
	end
	return false
end
return u1