

local u1 = {}
local u2 = _G.HDAdminMain
local u3 = u2.settings
local u4 = game:GetService("Players")
local u5 = game:GetService("AssetService")
local u6 = {}
local u7 = {}
local u8 = {}
local u9 = {}
function u1.register(u10, p11, u12) 

	local v13 = { u10, p11, u12 }
	u8[u10] = v13
	u9[tostring(p11)] = v13
	local v14 = u10:sub(1, 1):lower() .. u10:sub(2)
	if u12 then
		u12 = u12.Rank
	end
	local v15 = (not u12 or (not tonumber(u12) or u12 <= 0)) and 10 or false
	local v16
	if u3.DisableBoosterBundles then
		v16 = not u12
	else
		v16 = u3.DisableFunAndBoosterCommands
		if v16 then
			v16 = not u12
		end
	end
	local v17 = tostring(v14)
	local v18
	if u12 then
		v18 = nil
	else
		v18 = "/" .. v17
	end
	if not u12 then
		v17 = "boosterBundle" .. v17
	end
	local v19 = {
		["RankLock"] = false,
		["Loopable"] = false,
		["Description"] = "",
		["DisableChatUndo"] = false,
		["Name"] = v17,
		["Override"] = v18,
		["Aliases"] = {}
	}
	local v20
	if u12 then
		v20 = { u3.Prefix }
	else
		v20 = { u3.ChatPrefix, u3.UniversalPrefix }
	end
	v19.Prefixes = v20
	v19.Rank = u12 or "Booster"
	v19.Tags = { "fun" }
	v19.Groups = { "Bundle" }
	v19.Contributors = { "ForeverHD" }
	v19.LimitGroupPerMinute = v15
	v19.DisabledByOwner = v16
	v19.Args = { "Player" }
	function v19.Function(_, p21) 

		local v22 = p21[1]
		if not u12 then
			u2:GetModule("cf"):CheckFirstTimeUsing(v22)
		end
		local _, _ = u1.apply(v22, u10)
	end
	function v19.UnFunction(_, p23) 

		local v24 = p23[1]
		u1.unapply(v24)
	end
	return v19
end
function u1.getDetail(p25) 

	local v26 = tostring(p25)
	return u8[v26] or u9[v26]
end
function u1.getWebsiteDescription(u27) 

	local u28 = u27.Name
	local u29 = u27.Character
	if u29 then
		u29 = u29:FindFirstChild("HDOriginalDescription")
	end
	if u29 then
		task.defer(function()

			u29:Destroy()
		end)
		return u29
	end
	local v30 = u6[u28]
	if not v30 then
		local v31, v32 = pcall(function()

			return u4:GetHumanoidDescriptionFromUserId(u27.UserId)
		end)
		if not v31 then
			return false, v32
		end
		local u33 = v32
		u6[u28] = u33
		u27:GetPropertyChangedSignal("Parent"):Once(function()

			u6[u28] = nil
			u33:Destroy()
		end)
		v30 = u33
	end
	return v30
end
function u1.unapply(p34) 

	local u35, v36 = u1.getWebsiteDescription(p34)
	if not u35 then
		return false, v36
	end
	local u37 = p34.Character
	if u37 then
		u37 = u37:FindFirstChildOfClass("Humanoid")
	end
	if not u37 then
		return false, "Missing humanoid"
	end
	local v38, v39 = pcall(function()

		u37:ApplyDescriptionReset(u35, Enum.AssetTypeVerification.Always)
	end)
	return v38, v39
end
function u1.getBundleDescription(u40) 

	local v41 = tostring(u40)
	local v42 = u7[v41]
	if v42 then
		return v42
	end
	local v43, v44 = pcall(function()

		return u5:GetBundleDetailsAsync(u40)
	end)
	if not v43 then
		return false, v44
	end
	local u45 = nil
	for _, v46 in pairs(v44.Items) do
		if v46.Type == "UserOutfit" then
			u45 = v46.Id
			break
		end
	end
	if not u45 then
		return false, "Missing Bundle Outfit"
	end
	local v47, v48 = pcall(function()

		return u4:GetHumanoidDescriptionFromOutfitId(u45)
	end)
	if not v47 then
		return false, v48
	end
	u7[v41] = v48
	return v48
end
function u1.apply(p49, p50) 

	local v51 = u2:GetModule("cf"):GetHumanoid(p49)
	if v51 then
		v51:UnequipTools()
	end
	local v52 = u1.getDetail(p50)
	local v53 = v52[2]
	local v54 = v52[3] or {}
	local v55 = v54.IgnoreAccessories
	local v56 = {}
	if typeof(v55) == "table" then
		for _, v57 in pairs(v55) do
			v56[v57] = true
		end
	end
	local v58 = v54.IgnoreBodyParts
	local v59 = {}
	if typeof(v58) == "table" then
		for _, v60 in pairs(v58) do
			v59[v60] = true
		end
	end
	local v61 = v54.RemoveBodyParts
	local v62 = {}
	if typeof(v61) == "table" then
		for _, v63 in pairs(v61) do
			v62[v63] = true
		end
	end
	local v64, v65 = u1.getWebsiteDescription(p49)
	if v64 then
		local v66, v67 = u1.getBundleDescription(v53)
		if v66 then
			local u68 = v66:Clone()
			for _, v69 in pairs(v64:GetChildren()) do
				if v69:IsA("AccessoryDescription") then
					local v70 = v69.AccessoryType.Name
					if v55 ~= true and not v56[v70] then
						v69:Clone().Parent = u68
					end
				elseif v69:IsA("BodyPartDescription") then
					local v71 = v69.BodyPart.Name
					if v58 ~= true and not v59[v71] then
						local v72 = nil
						for _, v73 in pairs(u68:GetChildren()) do
							if v73:IsA("BodyPartDescription") and v73.BodyPart == v69.BodyPart then
								v72 = v73
							end
						end
						if v72 then
							v72.Color = v69.Color
						else
							v69:Clone().Parent = u68
						end
					end
					if v62[v71] then
						u68[v71] = v64[v71]
					end
				end
			end
			for _, v74 in pairs({
				"ClimbAnimation",
				"FallAnimation",
				"IdleAnimation",
				"JumpAnimation",
				"MoodAnimation",
				"RunAnimation",
				"SwimAnimation",
				"WalkAnimation",
				"GraphicTShirt",
				"Pants",
				"Shirt"
			}) do
				u68[v74] = v64[v74]
			end
			local v75 = u3.ScaleLimit or 5
			for v76, v78 in pairs(v54) do
				if v76:sub(1, 5) == "Scale" then
					if v75 < v78 then
						local v78 = v75
					end
					local v79 = v76:sub(6):gsub("(%u)", " %1"):gsub("^%s", ""):split(" ")
					for _, v80 in pairs(v79) do
						u68[v80 .. "Scale"] = v78
					end
				end
			end
			local v81 = p49.Character
			local u82
			if v81 then
				u82 = v81:FindFirstChild("Humanoid")
			else
				u82 = v81
			end
			if v81 then
				v81 = v81:FindFirstChild("HDOriginalDescription")
			end
			local v83, v84 = pcall(function()

				u82:ApplyDescriptionReset(u68, Enum.AssetTypeVerification.Always)
			end)
			u68:Destroy()
			if v83 then
				return true
			else
				return false, v84
			end
		else
			return false, v67
		end
	else
		return false, v65
	end
end
return u1