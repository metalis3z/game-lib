-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v2 = {
	["GroupTag"] = {
		["Name"] = "MEMBER",
		["Color"] = Color3.fromRGB(188, 70, 255)
	},
	["PremiumTag"] = {
		["Name"] = "PREMIUM",
		["Color"] = Color3.fromRGB(150, 0, 255)
	},
	["GroupPremiumTag"] = {
		["Name"] = "\240\159\145\145 VIP PREMIUM",
		["Color"] = Color3.fromRGB(255, 125, 0)
	},
	["VIPTag"] = {
		["Name"] = "\240\159\145\145 VIP",
		["Color"] = Color3.fromRGB(255, 255, 0)
	},
	["Ranks"] = {},
	["Players"] = {
		{
			["Name"] = "DEVELOPER",
			["Verified"] = true,
			["Color"] = Color3.fromRGB(52, 205, 246),
			["Override"] = true,
			["Players"] = { 1831770264, 5782246083, 116514507 }
		}
	}
}
v_u_1.Tags = v2
local v_u_3 = game:GetService("Players")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("TextChatService")
local v_u_6 = v4.Events.ChatNotification
function v_u_1.FindChatTag(_, p7)
	-- upvalues: (copy) v_u_1
	local v8 = p7:GetAttribute("IsInGroup")
	local v9 = p7.MembershipType
	local v10 = {}
	local v11 = false
	local v12 = false
	if v8 then
		local v13 = p7:GetAttribute("GroupRank")
		local v14 = v_u_1.Tags.Ranks[v13] or v_u_1.Tags.GroupTag
		v11 = v14 ~= v_u_1.Tags.GroupTag
		if v9 == Enum.MembershipType.Premium then
			if not v11 then
				local v15 = v_u_1.Tags.GroupPremiumTag
				table.insert(v10, v15)
			end
		else
			table.insert(v10, v14)
		end
	elseif v9 == Enum.MembershipType.Premium then
		local v16 = v_u_1.Tags.PremiumTag
		table.insert(v10, v16)
	end
	local v17 = p7:GetAttribute("IsVIP") and not v11 and { v_u_1.Tags.VIPTag } or v10
	for _, v18 in v_u_1.Tags.Players do
		if table.find(v18.Players, p7.UserId) then
			v17 = v18.Override and not v12 and {} or v17
			table.insert(v17, v18)
			v12 = true
		end
	end
	return v17
end
function v_u_1.Init(p_u_19)
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_3
	v_u_6.OnClientEvent:Connect(function(p20)
		-- upvalues: (ref) v_u_5
		v_u_5.TextChannels.RBXSystem:DisplaySystemMessage(p20)
	end)
	function v_u_5.OnIncomingMessage(p21)
		-- upvalues: (ref) v_u_3, (copy) p_u_19
		local v22 = p21.TextSource
		if v22 then
			v22 = v_u_3:GetPlayerByUserId(v22.UserId)
		end
		local v23
		if v22 then
			v23 = p_u_19:FindChatTag(v22)
		else
			v23 = v22
		end
		if not v23 or v23 == {} then
			return nil
		end
		local v24 = ""
		local v25 = false
		for _, v26 in v23 do
			v24 = v24 .. "<font color=\"#" .. v26.Color:ToHex() .. "\">[" .. v26.Name .. "]</font>"
			if v26.Verified and not v22.HasVerifiedBadge then
				v25 = true
			end
		end
		local v27 = Instance.new("TextChatMessageProperties")
		v27.PrefixText = v24 .. " " .. v22.DisplayName .. (v25 and utf8.char(57344) or "") .. ":"
		return v27
	end
end
return v_u_1
