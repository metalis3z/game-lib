--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  Discord: discord.gg/nDWm6PkFrT
--]]

-- Decompiled

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("HttpService")
local v_u_5 = game:GetService("RunService")
local v6 = require(v2.Packages.Net)
local v_u_7 = require(v2.Packages.Trove)
local v_u_8 = require(v2.Packages.FFlags)
local v_u_9 = require(v2.Packages.Observers)
require(v2.Datas.Rarities)
local v_u_10 = require(v2.Datas.ServerData)
local v_u_11 = require(v2.Datas.Animals)
local v_u_12 = require(v2.Controllers.CustomRichTextController)
local v_u_13 = require(v2.Shared.Animals)
local v_u_14 = v6:RemoteEvent("Liveboard/NewEntry")
local v_u_15 = v6:RemoteEvent("Liveboard/ClaimEntry")
local v_u_16 = v6:RemoteFunction("Liveboard/GetEntries")
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v20 = {}
local v_u_21 = Random.new():NextNumber(0, 1)
local function v_u_29(p22, p_u_23, p24)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_21
	local v_u_25 = p22.Filler
	if p_u_23 and p24 then
		v_u_25.PlayerBg.Visible = true
		v_u_25.PlayerBg.Username.TextColor3 = Color3.fromRGB(255, 255, 255)
		v_u_25.PlayerBg.Username.Text = p24
		local v_u_26 = v_u_4:GenerateGUID(false)
		v_u_25:SetAttribute("ImageJitter", v_u_26)
		local v27 = v_u_8:GetInstant("Liveboard/ThumbnailJitterMin", 0)
		local v28 = v_u_8:GetInstant("Liveboard/ThumbnailJitterMax", 7)
		task.delay(v27 + (v28 - v27) * v_u_21, function()
			-- upvalues: (copy) v_u_25, (copy) v_u_26, (copy) p_u_23
			if v_u_25:GetAttribute("ImageJitter") == v_u_26 then
				v_u_25.PlayerBg.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(p_u_23)
			end
		end)
	else
		v_u_25.PlayerBg.Visible = false
		v_u_25.PlayerBg.Username.TextColor3 = Color3.fromRGB(255, 61, 61)
		v_u_25.PlayerBg.Username.Text = "UNCLAIMED"
		v_u_25.PlayerBg.Headshot.Image = ""
		v_u_25:SetAttribute("ImageJitter", nil)
	end
end
local function v_u_34(p30)
	-- upvalues: (copy) v_u_17, (copy) v_u_18, (copy) v_u_19
	local v31 = v_u_17[p30]
	if v31 then
		v_u_18[v31.UID] = nil
		v_u_19[v31.UID] = v31.ExpiresAt
		v31.Trove:Destroy()
		v31.Frame:Destroy()
		table.remove(v_u_17, p30)
		for v32, v33 in v_u_17 do
			v33.Frame.LayoutOrder = v32
		end
	end
end
local function v_u_69(p_u_35, p36, p37, p38)
	-- upvalues: (copy) v_u_19, (copy) v_u_18, (copy) v_u_29, (copy) v_u_12, (copy) v_u_13, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11, (copy) v_u_17, (copy) v_u_8, (copy) v_u_34
	if v_u_19[p_u_35.UID] then
		return
	end
	local v39 = v_u_18[p_u_35.UID]
	if v39 then
		v_u_29(v39.Frame, p_u_35.OwnerUserId, p_u_35.OwnerDisplayName)
		return
	end
	local v40 = p_u_35.IsLocalServer
	if v40 then
		p37 = p36
	end
	local v41 = p37:Clone()
	v41.Visible = true
	v41.Name = "Entry"
	local v42 = v41.Filler
	v_u_12.apply(v42.Title, v_u_13:ColorBrainrotName(p_u_35.BrainrotName))
	local v43 = v42.Spawned
	local v44 = math.floor(0)
	local v45 = math.max(0, v44)
	local v46
	if v45 < 60 then
		v46 = ("Spawned %*s ago"):format(v45)
	else
		local v47 = v45 / 60
		local v48 = math.floor(v47)
		local v49 = v45 % 60
		if v49 > 0 then
			v46 = ("Spawned %*m %*s ago"):format(v48, v49)
		else
			v46 = ("Spawned %*m ago"):format(v48)
		end
	end
	v43.Text = v46
	v42.Location.Text = v40 and "[SERVER]" or "[GLOBAL]"
	v_u_29(v41, p_u_35.OwnerUserId, p_u_35.OwnerDisplayName)
	v42.BrainrotBg.Img.Visible = false
	local v_u_50 = Instance.new("ViewportFrame")
	v_u_50.Name = "BrainrotViewport"
	v_u_50.BackgroundTransparency = 1
	v_u_50.Size = UDim2.fromScale(1, 1)
	v_u_50.Position = UDim2.fromScale(0.5, 0.5)
	v_u_50.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_50.Parent = v42.BrainrotBg
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_13, (copy) p_u_35, (copy) v_u_50
		v_u_13:AttachOnViewport(p_u_35.BrainrotName, v_u_50, nil, p_u_35.Mutation)
	end)
	local v51 = v42.Bar.Fill
	v51.Size = UDim2.fromScale(1, 1)
	v41.Parent = p38
	local v52 = v_u_7.new()
	local v53 = workspace:GetServerTimeNow()
	local v54 = v53 - p_u_35.Timestamp
	local v55 = math.max(0, v54)
	local v56 = p_u_35.DisplayDuration - v55
	local v57 = math.max(0, v56)
	if v57 <= 0 then
		v41:Destroy()
		v52:Destroy()
		return
	end
	local v58 = v57 / p_u_35.DisplayDuration
	v51.Size = UDim2.fromScale(v58, 1)
	local v59 = v_u_3:Create(v51, TweenInfo.new(v57, Enum.EasingStyle.Linear), {
		["Size"] = UDim2.fromScale(0, 1)
	})
	v52:Add(v59)
	v59:Play()
	local v60 = v_u_11[p_u_35.BrainrotName]
	local v61
	if v60 then
		v61 = v60.Rarity
	else
		v61 = nil
	end
	local v62 = {
		["UID"] = p_u_35.UID,
		["Rarity"] = v61,
		["Frame"] = v41,
		["Trove"] = v52,
		["ExpiresAt"] = v53 + v57,
		["SpawnedAt"] = p_u_35.Timestamp,
		["Duration"] = p_u_35.DisplayDuration
	}
	local v63
	if v61 == "OG" then
		v63 = 1
	else
		v63 = 1
		for v64, v65 in v_u_17 do
			if v65.Rarity ~= "OG" then
				break
			end
			v63 = v64 + 1
		end
	end
	local v66 = v_u_17
	table.insert(v66, v63, v62)
	v_u_18[p_u_35.UID] = v62
	for v67, v68 in ipairs(v_u_17) do
		v68.Frame.LayoutOrder = v67
	end
	while #v_u_17 > v_u_8:GetInstant("Liveboard/MaxEntries", 50) do
		v_u_34(#v_u_17)
	end
end
function v20.Start(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_9, (copy) v_u_7, (copy) v_u_14, (copy) v_u_69, (copy) v_u_15, (copy) v_u_18, (copy) v_u_29, (copy) v_u_5, (copy) v_u_17, (copy) v_u_34, (copy) v_u_19, (copy) v_u_16
	if not (v_u_10.IsDuelsServer() or v_u_10.IsTsunamiServer()) then
		local v_u_70 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		v_u_9.observeTag("Liveboard", function(p71)
			-- upvalues: (ref) v_u_7, (copy) v_u_70, (ref) v_u_14, (ref) v_u_69, (ref) v_u_15, (ref) v_u_18, (ref) v_u_29, (ref) v_u_5, (ref) v_u_17, (ref) v_u_34, (ref) v_u_19, (ref) v_u_16
			local v_u_72 = v_u_7.new()
			local v73 = v_u_72:Clone(script.SurfaceGui)
			v73.Adornee = p71
			v73.Parent = v_u_70
			local v_u_74 = v73.ScrollingFrame
			local v_u_75 = v_u_74.ServerTemplate
			local v_u_76 = v_u_74.GlobalTemplate
			v_u_75.Visible = false
			v_u_76.Visible = false
			v_u_72:Add(v_u_14.OnClientEvent:Connect(function(p77)
				-- upvalues: (ref) v_u_69, (copy) v_u_75, (copy) v_u_76, (copy) v_u_74
				if type(p77) == "table" then
					local v78 = p77.BrainrotName
					if type(v78) == "string" then
						v_u_69(p77, v_u_75, v_u_76, v_u_74)
					end
				else
					return
				end
			end))
			v_u_72:Add(v_u_15.OnClientEvent:Connect(function(p79, p80, p81)
				-- upvalues: (ref) v_u_18, (ref) v_u_29
				local v82 = v_u_18[p79]
				if v82 then
					v_u_29(v82.Frame, p80, p81)
				end
			end))
			v_u_72:Add(v_u_5.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_17, (ref) v_u_34, (ref) v_u_19
				local v83 = workspace:GetServerTimeNow()
				local v84 = 1
				while v84 <= #v_u_17 do
					local v85 = v_u_17[v84]
					if v85.ExpiresAt <= v83 then
						v_u_34(v84)
					else
						local v86 = v83 - v85.SpawnedAt
						local v87 = v85.Frame.Filler.Spawned
						local v88 = math.floor(v86)
						local v89 = math.max(0, v88)
						local v90
						if v89 < 60 then
							v90 = ("Spawned %*s ago"):format(v89)
						else
							local v91 = v89 / 60
							local v92 = math.floor(v91)
							local v93 = v89 % 60
							if v93 > 0 then
								v90 = ("Spawned %*m %*s ago"):format(v92, v93)
							else
								v90 = ("Spawned %*m ago"):format(v92)
							end
						end
						v87.Text = v90
						v84 = v84 + 1
					end
				end
				for v94, v95 in v_u_19 do
					if v95 <= v83 then
						v_u_19[v94] = nil
					end
				end
			end))
			task.spawn(function()
				-- upvalues: (ref) v_u_16, (ref) v_u_69, (copy) v_u_75, (copy) v_u_76, (copy) v_u_74
				local v96, v97 = pcall(v_u_16.InvokeServer, v_u_16)
				if v96 and typeof(v97) == "table" then
					for _, v98 in v97 do
						v_u_69(v98, v_u_75, v_u_76, v_u_74)
					end
				end
			end)
			return function()
				-- upvalues: (copy) v_u_72, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19
				v_u_72:Clean()
				table.clear(v_u_17)
				table.clear(v_u_18)
				table.clear(v_u_19)
			end
		end)
	end
end
return v20