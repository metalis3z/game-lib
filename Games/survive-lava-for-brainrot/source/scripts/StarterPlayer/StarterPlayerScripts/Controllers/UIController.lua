-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
WOAH COPY SHARING
WOAH COPY SHARING
local v_u_1 = {}
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("MarketplaceService")
local v_u_8 = game:GetService("CollectionService")
game:GetService("AvatarEditorService")
game:GetService("SocialService")
local v_u_9 = game:GetService("StarterGui")
local v_u_10 = game:GetService("UserInputService")
local v_u_11 = game:GetService("SocialService")
game:GetService("StarterPlayer")
local v_u_12 = TweenInfo.new(0.2, Enum.EasingStyle.Back)
local v_u_13 = TweenInfo.new(0.1, Enum.EasingStyle.Sine)
local v_u_14 = TweenInfo.new(0.075, Enum.EasingStyle.Sine)
local v_u_15 = TweenInfo.new(0.1, Enum.EasingStyle.Sine)
local v_u_16 = require(v_u_4.Shared.FormatNumber)
local v_u_17 = require(v_u_4.Icon)
local v_u_18 = require(script.Parent:WaitForChild("PlotsController"))
local v_u_19 = require(script.Parent.UpdateController)
local v_u_20 = v_u_5.SFX
local v_u_21 = v_u_20.Button
local v_u_22 = v_u_20.Frame
local v_u_23 = v_u_20.Purchase
local v_u_24 = v_u_20.Error
local v_u_25 = v_u_3.LocalPlayer
local v_u_26 = require(v_u_4.Modules.DataController)
local v_u_27 = require(v_u_4.Registries.BrainrotRegistry)
local v_u_28 = require(v_u_4.Registries.RarityRegistry)
require(v_u_4.Registries.MutationRegistry)
require(v_u_4.Data.DefaultData)
local v_u_29 = require(v_u_4.Modules.EventTimerController)
local v_u_30 = v_u_25:WaitForChild("PlayerGui"):WaitForChild("HUD")
local v_u_31 = v_u_30:WaitForChild("Notf")
local v_u_32 = v_u_30:WaitForChild("EventNotf")
local v_u_33 = v_u_30:WaitForChild("Cash")
local v_u_34 = v_u_30:WaitForChild("Speed")
local v_u_35 = v_u_30:WaitForChild("Jump")
local v36 = v_u_30:WaitForChild("LeftButtons")
local v_u_37 = v36:WaitForChild("SlowMode"):WaitForChild("Button")
local v_u_38 = v_u_30:WaitForChild("Rebirth")
local v_u_39 = v_u_38:WaitForChild("InsiderFrame"):WaitForChild("Insider"):WaitForChild("RequirementBar")
local v_u_40 = v_u_38:WaitForChild("InsiderFrame"):WaitForChild("Rebirth")
local v_u_41 = v_u_38:WaitForChild("InsiderFrame"):WaitForChild("Insider"):WaitForChild("Rewards")
local v_u_42 = v_u_38:WaitForChild("InsiderFrame"):WaitForChild("Insider"):WaitForChild("Brainrots")
local v_u_43 = v_u_30:WaitForChild("Upgrades")
local v_u_44 = v_u_30:WaitForChild("CarryUpgrades")
local v_u_45 = v_u_44:WaitForChild("InsiderFrame"):WaitForChild("Carry")
local v_u_46 = v_u_30:WaitForChild("Index")
local v_u_47 = v_u_46:WaitForChild("InsiderFrame"):WaitForChild("ScrollingFrame")
local v_u_48 = v_u_30:WaitForChild("Gift")
local v_u_49 = v_u_48:WaitForChild("InsiderFrame"):WaitForChild("Frame"):WaitForChild("Title")
local v_u_50 = v_u_48:WaitForChild("InsiderFrame"):WaitForChild("Accept")
v_u_48:WaitForChild("InsiderFrame"):WaitForChild("Decline")
local v_u_51 = v_u_30:WaitForChild("MainShop")
local v52 = v_u_51:WaitForChild("InsiderFrame"):WaitForChild("ScrollingFrame")
local v_u_53 = v52:WaitForChild("StarterPack")
local v_u_54 = v52:WaitForChild("ServerLucks")
local v_u_55 = v_u_54:WaitForChild("Timer")
local v56 = v_u_30:WaitForChild("ServerLuck")
v56:WaitForChild("Multiplier")
v56:FindFirstChild("Timer")
local v_u_57 = v_u_30:WaitForChild("LuckyBlock")
local v_u_58 = v_u_57:WaitForChild("InsiderFrame"):WaitForChild("Return")
local v_u_59 = v_u_57:WaitForChild("InsiderFrame"):WaitForChild("StartCraft")
local v_u_60 = v_u_57:WaitForChild("InsiderFrame"):WaitForChild("Craft")
local v_u_61 = v_u_57:WaitForChild("InsiderFrame"):WaitForChild("Skip")
local v_u_62 = v_u_57:WaitForChild("InsiderFrame"):WaitForChild("Claim")
local v_u_63 = v_u_30:WaitForChild("BrainrotFrame")
local v_u_64 = v_u_30:WaitForChild("Revive")
local v_u_65 = v_u_64:WaitForChild("Yes")
local v_u_66 = v_u_30:WaitForChild("Notifications")
local v_u_67 = v_u_66:WaitForChild("Notf")
local v_u_68 = workspace:WaitForChild("GameFolder"):WaitForChild("Shops")
local v_u_69 = v_u_68:WaitForChild("Speed")
local v_u_70 = v_u_68:WaitForChild("Carry")
local v_u_71 = v_u_68:WaitForChild("Ladder")
local v_u_72 = v_u_68:WaitForChild("GravityCoil")
local v_u_73 = nil
task.spawn(function()
	-- upvalues: (ref) v_u_73, (copy) v_u_68
	v_u_73 = v_u_68:WaitForChild("FuseMachine", 5)
end)
local v_u_74 = v_u_68:WaitForChild("Sell")
local v_u_75 = v_u_74:WaitForChild("HeadAtt"):WaitForChild("BillboardGui")
local v_u_76 = v_u_75:WaitForChild("Dialogue"):WaitForChild("Text")
local v77 = v_u_4.Events
local v_u_78 = v77.Notification
local v_u_79 = v77.Rebirth
local v_u_80 = v77.Speed
local v_u_81 = v77.Carry
local v_u_82 = v77.Brainrots
local v_u_83 = v77.Index
local v_u_84 = v77.PlaySound
local v_u_85 = v77.Gift
local v_u_86 = v77.Revive
local v_u_87 = v77.Tutorial
local _ = v77.Favorited
local v_u_88 = v77.FuseBrainrots
local v_u_89 = false
local v_u_90 = {}
local v_u_91 = nil
local v_u_92 = nil
local v_u_93 = nil
local v_u_94 = nil
local v_u_95 = v_u_81:InvokeServer("GetPrices")
local v_u_96 = 0
local v_u_97 = {}
local v_u_98 = "Normal"
local v_u_99 = {
	{
		["Level"] = 9,
		["ProductId"] = 3526319949
	},
	{
		["Level"] = 7,
		["ProductId"] = 3526319891
	},
	{
		["Level"] = 5,
		["ProductId"] = 3526319816
	},
	{
		["Level"] = 3,
		["ProductId"] = 3526319775
	},
	{
		["Level"] = 1,
		["ProductId"] = 3526147579
	}
}
local v_u_100 = {
	["Products"] = {
		[3522281226] = 3526145731,
		[3520584567] = 3526145887,
		[3520584978] = 3526146033,
		[3525302910] = 3526146187,
		[3525303012] = 3526146318,
		[3520584867] = 3526146434,
		[3525302968] = 3526146542,
		[3524604603] = 3526146696,
		[3523296443] = 3526146828,
		[3523296614] = 3526146962,
		[3523942371] = 3526147081,
		[3523942398] = 3526147214,
		[3523942426] = 3526147344,
		[3523942452] = 3526147451,
		[3518152563] = 3526147579,
		[3523259535] = 3526147684,
		[3523956995] = 3526147804,
		[3522538541] = 3526147981,
		[3524480122] = 3526148194,
		[3523956943] = 3526148403,
		[3523957050] = 3526148554,
		[3523956928] = 3526148747,
		[3523956964] = 3526148797,
		[3523122494] = 3526148926,
		[3525310027] = 3526149021
	},
	["Passes"] = {
		[1691473797] = 1694208871,
		[1687479683] = 1693794094,
		[1679100285] = 1694602214
	}
}
local v_u_101 = {
	[Enum.KeyCode.DPadUp] = v36:WaitForChild("Shop"),
	[Enum.KeyCode.DPadLeft] = v36:WaitForChild("Index"),
	[Enum.KeyCode.DPadDown] = v36:WaitForChild("Rebirth"),
	[Enum.KeyCode.DPadRight] = v_u_30:WaitForChild("RightButtons"):WaitForChild("StopLava")
}
local v_u_102 = {}
local function v_u_111(p103)
	local v104 = p103 / 86400
	local v105 = math.floor(v104)
	local v106 = p103 % 86400 / 3600
	local v107 = math.floor(v106)
	local v108 = p103 % 3600 / 60
	local v109 = math.floor(v108)
	local v110 = p103 % 60
	if v105 > 0 then
		return string.format("%dd %02dh %02dm %02ds", v105, v107, v109, v110)
	elseif v107 > 0 then
		return string.format("%02dh %02dm %02ds", v107, v109, v110)
	elseif v109 > 0 then
		return string.format("%02dm %02ds", v109, v110)
	else
		return string.format("%02ds", v110)
	end
end
function v_u_1.FetchAssetPrice(_, p_u_112, p_u_113, p_u_114)
	-- upvalues: (copy) v_u_102, (copy) v_u_7
	if v_u_102[p_u_112] then
		if p_u_114 then
			p_u_114(v_u_102[p_u_112])
		end
	else
		task.spawn(function()
			-- upvalues: (ref) v_u_7, (copy) p_u_112, (copy) p_u_113, (ref) v_u_102, (copy) p_u_114
			local v115, v116 = pcall(v_u_7.GetProductInfoAsync, v_u_7, p_u_112, p_u_113)
			if v115 and v116 then
				v_u_102[p_u_112] = v116.PriceInRobux
				if p_u_114 then
					p_u_114(v116.PriceInRobux)
				end
			end
		end)
	end
end
function v_u_1.FetchProductPrices(_)
	-- upvalues: (copy) v_u_100, (copy) v_u_1
	for _, v117 in v_u_100.Products do
		v_u_1:FetchAssetPrice(v117, Enum.InfoType.Product)
	end
	for _, v118 in v_u_100.Passes do
		v_u_1:FetchAssetPrice(v118, Enum.InfoType.GamePass)
	end
end
function v_u_1.LavaNotification(_, p119, p120, p121)
	-- upvalues: (copy) v_u_31, (ref) v_u_91
	v_u_31.Text = p119
	v_u_31.TextColor3 = p121 or Color3.fromRGB(255, 255, 255)
	if v_u_91 then
		task.cancel(v_u_91)
	end
	v_u_91 = task.delay(p120, function()
		-- upvalues: (ref) v_u_31
		v_u_31.Text = ""
		v_u_31.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end
function v_u_1.LowGravityNotification(_, p122, p123, p124)
	-- upvalues: (copy) v_u_32, (ref) v_u_92
	v_u_32.Text = p122
	v_u_32.TextColor3 = p124 or Color3.fromRGB(255, 255, 255)
	if v_u_92 then
		task.cancel(v_u_92)
	end
	v_u_92 = task.delay(p123, function()
		-- upvalues: (ref) v_u_32
		v_u_32.Text = ""
		v_u_32.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end
function v_u_1.ShowNotification(_, p125, p126, p127)
	-- upvalues: (copy) v_u_67, (copy) v_u_66, (copy) v_u_20, (copy) v_u_6
	local v128 = p126 or {}
	local v_u_129 = v_u_67:Clone()
	v_u_129.Text = p125
	v_u_129.TextColor3 = v128.Color or v_u_129.TextColor3
	v_u_129.LayoutOrder = v128.LayoutOrder or v_u_129.LayoutOrder
	v_u_129.Visible = true
	v_u_129.Parent = v_u_66
	if v128.Tag then
		v_u_129:AddTag(v128.Tag)
	end
	if v128.Sound then
		v_u_20[v128.Sound]:Play()
	end
	if v128.Rainbow then
		task.spawn(function()
			-- upvalues: (copy) v_u_129
			local v130 = 0
			while v_u_129 and v_u_129.Parent do
				v130 = (v130 + 0.02) % 1
				v_u_129.TextColor3 = Color3.fromHSV(v130, 1, 1)
				task.wait(0.05)
			end
		end)
	end
	local v_u_131 = v_u_6:Create(v_u_129.UIScale, TweenInfo.new(0.1), {
		["Scale"] = 1
	})
	v_u_131:Play()
	if v128.Grow then
		task.spawn(function()
			-- upvalues: (copy) v_u_131, (ref) v_u_6, (copy) v_u_129
			v_u_131.Completed:Wait()
			v_u_6:Create(v_u_129.UIScale, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				["Scale"] = 1.15
			}):Play()
		end)
	end
	if v128.Texts then
		for _, v132 in v128.Texts do
			v_u_129.Text = v132.Text
			task.wait(v132.Time)
		end
		task.delay(0.1, workspace.Destroy, v_u_129)
		v_u_6:Create(v_u_129.UIScale, TweenInfo.new(0.1), {
			["Scale"] = 0
		}):Play()
	else
		task.delay((p127 or 5) + 0.1, workspace.Destroy, v_u_129)
		task.wait(p127 or 5)
		v_u_6:Create(v_u_129.UIScale, TweenInfo.new(0.1), {
			["Scale"] = 0
		}):Play()
	end
end
function v_u_1.Make3DBrainrot(p133, p134, p135, p136)
	-- upvalues: (copy) v_u_4
	local v137 = v_u_4.Brainrots:FindFirstChild(p135)
	if v137 then
		local v138 = v137:FindFirstChild(p134)
		if v138 then
			local v_u_139 = v_u_4.Brainrots.Normal:FindFirstChild(p134)
			if v_u_139 then
				local v_u_140 = v138:Clone()
				v_u_140.Parent = p136
				task.spawn(function()
					-- upvalues: (copy) v_u_139, (copy) v_u_140
					local v141 = v_u_139:FindFirstChildWhichIsA("Animation", true)
					if v141 then
						if v141.AnimationId == "" then
							warn(v_u_139, v_u_139.Animation, "has no AnimationId")
							return
						elseif v_u_139:FindFirstChildWhichIsA("Model") then
							for _, v142 in v_u_140:GetChildren() do
								if v142:IsA("Model") then
									v142.AnimationController:LoadAnimation(v141):Play()
								end
							end
						else
							v_u_140.AnimationController:LoadAnimation(v141):Play()
						end
					else
						return
					end
				end)
				local v143 = v_u_139:GetAttribute("CameraOrientation") or Vector3.new(0, 0, 0)
				local v144 = v_u_139:GetAttribute("CameraOffset") or Vector3.new(0, 0, 0)
				local v145 = CFrame.fromOrientation(0, 2.356194490192345, 0)
				local v146 = CFrame.fromOrientation
				local v147 = v143.X
				local v148 = math.rad(v147)
				local v149 = v143.Y
				local v150 = math.rad(v149)
				local v151 = v143.Z
				v_u_140:PivotTo(v145 * v146(v148, v150, (math.rad(v151))) + Vector3.new(-0.5, -4, 0) + v144)
				p133:ChangeBrainrot(v_u_140, v138, p135)
			else
				warn((("Normal brainrot not found: %*"):format(p134)))
			end
		else
			warn(p134, "not found in Mutation Folder", p135)
			return
		end
	else
		return warn(p135, "does not have mutation folder")
	end
end
function v_u_1.ChangeRebirths(_)
	-- upvalues: (ref) v_u_94, (copy) v_u_79, (copy) v_u_26, (copy) v_u_39, (copy) v_u_40, (copy) v_u_38, (copy) v_u_41, (copy) v_u_42, (copy) v_u_27, (copy) v_u_1
	v_u_94 = v_u_79:InvokeServer("GetRebirths")
	local v152 = v_u_26:GetValueFromPathAsync("Rebirths")
	local v153 = v_u_26:GetValueFromPathAsync("Upgrades/Speed")
	local v154 = v_u_94[v152 + 1]
	local v155
	if v154 then
		v155 = v154.Speed
	else
		v155 = v154
	end
	local v156 = {
		{
			["Name"] = "Jump",
			["Value"] = v152 * 3,
			["Image"] = "rbxassetid://84847836500700",
			["Size"] = UDim2.fromScale(0.9, 0.9)
		},
		{
			["Name"] = "Multiplier",
			["Value"] = 1 + (v152 + 1) / 2
		}
	}
	v_u_39:WaitForChild("Name").Text = v155 and (("%*/%* Speed"):format(v153 + 16, v155 + 16 or "MAX") or "MAX REBIRTHS REACHED!") or "MAX REBIRTHS REACHED!"
	local v157 = v_u_39:WaitForChild("Fill")
	local v158 = UDim2.fromScale
	local v159 = v153 / (v155 or v153)
	v157.Size = v158(math.clamp(v159, 0, 0.995), 1)
	v_u_40.Position = UDim2.fromScale(v155 and 0.325 or 0.5, 0.936)
	v_u_38:WaitForChild("InsiderFrame"):WaitForChild("RebirthRobux").Visible = v155
	local v160 = v154 and v156 and v156 or {}
	for _, v161 in v_u_41:GetChildren() do
		if v161:IsA("ImageLabel") then
			v161:Destroy()
		end
	end
	for _, v162 in v_u_42:GetChildren() do
		if v162:IsA("ImageLabel") then
			v162:Destroy()
		end
	end
	for _, v163 in v160 do
		local v164 = v163.Name
		local v165 = v163.Value
		if v165 then
			local v166 = script.RebirthReward:Clone()
			v166.Icon.Visible = true
			v166.Parent = v_u_41
			if v164 == "Multiplier" then
				v166.NameText.Text = v165 .. "x Multiplier"
			elseif v164 == "Jump" then
				v166.NameText.Text = "+3 Jump Height"
			elseif v164 == "Floor" then
				v166.NameText.Text = "+1 Floor"
			end
			v166.Icon.Image = v163.Image or v166.Icon.Image
			v166.Icon.Size = v163.Size or v166.Icon.Size
		end
	end
	for _, v167 in v154 and v154.Brainrots or {} do
		local v168 = script.RebirthReward:Clone()
		v168.Parent = v_u_42
		v168.NameText.Text = v_u_27[v167].DisplayName or v167:gsub("(%u)", " %1"):gsub("^ ", "")
		v_u_1:Make3DBrainrot(v167, "Normal", v168.ViewportFrame.WorldModel)
	end
end
function v_u_1.ChangeSpeeds(_)
	-- upvalues: (copy) v_u_26, (copy) v_u_43, (copy) v_u_16
	local v169 = v_u_26:GetValueFromPathAsync("Upgrades/Speed")
	for _, v170 in v_u_43:WaitForChild("InsiderFrame"):GetChildren() do
		if v170:IsA("ImageLabel") then
			local v171 = v170:WaitForChild("RequirementText")
			local v172 = v170:WaitForChild("MoneyButton")
			local v173 = v170.Name
			local v174 = 0
			for v175 = 0, tonumber(v173) - 1 do
				local v176 = 50 + (v169 + v175 + 1) * 150
				local v177 = (v169 + v175) / 50
				local v178 = v176 ^ math.clamp(v177, 1, 6)
				v174 = v174 + math.round(v178)
			end
			local v179 = 16 + v169
			local v180 = 16 + v169
			local v181 = v170.Name
			v171.Text = v179 .. " > " .. v180 + tonumber(v181)
			v172:WaitForChild("Text").Text = "$" .. v_u_16(v174)
		end
	end
end
function v_u_1.ChangeCarry(_)
	-- upvalues: (copy) v_u_26, (copy) v_u_45, (copy) v_u_95, (copy) v_u_16
	local v182 = v_u_26:GetValueFromPathAsync("Upgrades/Carry")
	local v183 = v_u_45:WaitForChild("RequirementText")
	local v184 = v_u_45:WaitForChild("MoneyButton")
	local v185 = v_u_45:WaitForChild("RobuxButton")
	local v186 = v_u_95
	local v187 = v182 + 1
	local v188 = v186[tostring(v187)]
	v183.Text = v182 .. " > " .. (v188 and v182 + 1 or "MAX")
	v184:WaitForChild("Text").Text = v188 and ("$" .. v_u_16(v188) or "MAX") or "MAX"
	v185.Visible = v188
end
function v_u_1.ChangeIndex(_, p189)
	-- upvalues: (copy) v_u_82, (ref) v_u_97, (copy) v_u_47, (ref) v_u_98, (copy) v_u_27, (copy) v_u_46, (ref) v_u_96
	local v190 = p189 or v_u_82:InvokeServer("Index") or {}
	v_u_97 = {}
	for v191, v192 in v190 do
		v_u_97[v191] = {}
		for _, v193 in v192 do
			if not table.find(v_u_97[v191], v193) then
				local v194 = v_u_47:FindFirstChild(v193)
				if v194 then
					local v195 = v_u_97[v191]
					table.insert(v195, v193)
					if v191 == v_u_98 then
						v194.BrainrotName.Text = v_u_27[v193].DisplayName or v193:gsub("(%u)", " %1"):gsub("^ ", "")
						v194.ViewportFrame.Ambient = Color3.fromRGB(200, 200, 200)
						v194.ViewportFrame.LightColor = Color3.fromRGB(140, 140, 140)
					end
				end
			end
		end
	end
	if v_u_97[v_u_98] then
		local v196 = v_u_46.Header.Complete
		local v197 = #v_u_97[v_u_98] / v_u_96 * 100
		v196.Text = math.floor(v197) .. "% Completed"
		v_u_46.Header.Discovered.Text = #v_u_97[v_u_98] .. "/" .. v_u_96 .. " Discovered"
	end
end
function v_u_1.IsFrameOpen(_, p198)
	-- upvalues: (copy) v_u_90
	return table.find(v_u_90, p198) ~= nil
end
function v_u_1.OpenFrame(_, p199, p200)
	-- upvalues: (ref) v_u_89, (copy) v_u_15, (copy) v_u_90, (copy) v_u_1, (copy) v_u_9, (copy) v_u_22, (copy) v_u_6, (copy) v_u_38, (copy) v_u_63
	if p199 then
		if not v_u_89 or p200 then
			v_u_89 = true
			task.delay(v_u_15.Time, function()
				-- upvalues: (ref) v_u_89
				v_u_89 = false
			end)
			local v201 = table.find(v_u_90, p199)
			if p200 == false then
				v201 = true
			elseif p200 ~= nil then
				v201 = false
			end
			if not v201 and (p199:FindFirstChild("UIScale") and p199.UIScale.Scale == 1) then
				local v202 = v_u_90
				table.insert(v202, p199)
			end
			for _, v203 in v_u_90 do
				if v203 == p199 or not v203:GetAttribute("NoClose") then
					v_u_1:CloseFrame(v203)
				end
			end
			if not v201 then
				v_u_9:SetCore("TopbarEnabled", false)
			end
			if not v201 then
				local v204 = p199:FindFirstChildOfClass("UIScale")
				if not v204 then
					v204 = Instance.new("UIScale", p199)
					v204.Scale = 0
				end
				v_u_22:Play()
				v_u_6:Create(v204, v_u_15, {
					["Scale"] = 1
				}):Play()
				p199.Visible = true
				if p199 == v_u_38 then
					v_u_63.Visible = false
				end
				local v205 = v_u_90
				table.insert(v205, p199)
			end
		end
	else
		warn("Frame not found", p199, p200, debug.traceback(nil, 2))
		return
	end
end
function v_u_1.CloseFrame(_, p206)
	-- upvalues: (copy) v_u_9, (ref) v_u_89, (copy) v_u_15, (copy) v_u_6, (copy) v_u_38, (copy) v_u_25, (copy) v_u_63, (copy) v_u_90
	v_u_9:SetCore("TopbarEnabled", true)
	v_u_89 = true
	task.delay(v_u_15.Time, function()
		-- upvalues: (ref) v_u_89
		v_u_89 = false
	end)
	v_u_6:Create(p206:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", p206), v_u_15, {
		["Scale"] = 0
	}):Play()
	local v207 = p206 == v_u_38 and v_u_25.Character
	if v207 then
		v_u_63.Visible = v207:GetAttribute("CarryingBrainrot") or false
	end
	table.remove(v_u_90, table.find(v_u_90, p206))
end
function v_u_1.PressButton(_, p208)
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_2, (copy) v_u_21, (copy) v_u_26, (copy) v_u_99, (copy) v_u_7, (copy) v_u_25
	local v209 = p208:FindFirstChild("Frame")
	local v210 = p208:GetAttribute("GamepassId")
	local v211 = p208:GetAttribute("ProductId")
	if v209 then
		if v209.Value then
			v_u_1:OpenFrame(v209.Value)
			if v_u_10.PreferredInput == Enum.PreferredInput.Gamepad then
				v_u_2:Select(v209.Value)
			end
		end
	else
		v_u_21:Play()
	end
	if p208.Name == "RebirthRobux" then
		local v212 = v_u_26:GetValueFromPathAsync("Rebirths")
		for _, v213 in v_u_99 do
			if v212 + 1 >= v213.Level then
				v_u_7:PromptProductPurchase(v_u_25, v213.ProductId)
				return
			end
		end
	else
		if v210 then
			v_u_7:PromptGamePassPurchase(v_u_25, v210)
		end
		if v211 then
			v_u_7:PromptProductPurchase(v_u_25, v211)
			if v211 == 3526146696 and (p208.ClosingFrame and p208.ClosingFrame.Value) then
				v_u_1:CloseFrame(p208.ClosingFrame.Value)
			end
		end
	end
end
function v_u_1.ButtonFunction(p_u_214, p_u_215)
	-- upvalues: (copy) v_u_6, (copy) v_u_12, (copy) v_u_13, (copy) v_u_14, (copy) v_u_100, (copy) v_u_102, (copy) v_u_1
	local v216 = p_u_215:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", p_u_215)
	local v_u_217 = v_u_6:Create(v216, v_u_12, {
		["Scale"] = p_u_215:GetAttribute("HoverScale") or 1.05
	})
	local v_u_218 = v_u_6:Create(v216, v_u_13, {
		["Scale"] = 1
	})
	local v_u_219 = v_u_6:Create(v216, v_u_14, {
		["Scale"] = p_u_215:GetAttribute("PressScale") or 0.9
	})
	local v_u_220 = p_u_215:GetAttribute("Studs")
	if v_u_220 then
		v_u_220 = p_u_215.Stud_Texture.TileSize
	end
	local v_u_221
	if v_u_220 then
		v_u_221 = v_u_6:Create(p_u_215.Stud_Texture, v_u_12, {
			["TileSize"] = UDim2.fromScale(v_u_220.X.Scale / 1.05, v_u_220.Y.Scale / 1.05)
		})
	else
		v_u_221 = v_u_220
	end
	local v_u_222
	if v_u_220 then
		v_u_222 = v_u_6:Create(p_u_215.Stud_Texture, v_u_13, {
			["TileSize"] = UDim2.fromScale(v_u_220.X.Scale / 1, v_u_220.Y.Scale / 1)
		})
	else
		v_u_222 = v_u_220
	end
	local v_u_223
	if v_u_220 then
		v_u_223 = v_u_6:Create(p_u_215.Stud_Texture, v_u_14, {
			["TileSize"] = UDim2.fromScale(v_u_220.X.Scale / 0.9, v_u_220.Y.Scale / 0.9)
		})
	else
		v_u_223 = v_u_220
	end
	local v224 = p_u_215:GetAttribute("GamepassId")
	local v225 = p_u_215:GetAttribute("ProductId")
	if v224 and v_u_100.Passes[v224] then
		v224 = v_u_100.Passes[v224]
		p_u_215:SetAttribute("GamepassId", v224)
	elseif v225 and v_u_100.Products[v225] then
		v225 = v_u_100.Products[v225]
		p_u_215:SetAttribute("ProductId", v225)
	end
	local v_u_226 = p_u_215:FindFirstChild("PriceText") or p_u_215:FindFirstChild("Price")
	if v_u_226 and not p_u_215:GetAttribute("AvoidOverride") then
		local v227 = v224 or v225
		local v228 = v224 and Enum.InfoType.GamePass or Enum.InfoType.Product
		if v227 and v_u_102[v227] then
			v_u_226.Text = v_u_102[v227]
		elseif v227 then
			v_u_1:FetchAssetPrice(v227, v228, function(p229)
				-- upvalues: (copy) v_u_226
				if v_u_226 and v_u_226.Parent then
					v_u_226.Text = p229
				end
			end)
		end
	end
	p_u_215.MouseEnter:Connect(function()
		-- upvalues: (copy) v_u_217, (copy) v_u_220, (copy) v_u_221
		v_u_217:Play()
		if v_u_220 then
			v_u_221:Play()
		end
	end)
	p_u_215.MouseLeave:Connect(function()
		-- upvalues: (copy) v_u_218, (copy) v_u_220, (copy) v_u_222
		v_u_218:Play()
		if v_u_220 then
			v_u_222:Play()
		end
	end)
	p_u_215.MouseButton1Down:Connect(function()
		-- upvalues: (copy) v_u_219, (copy) v_u_220, (copy) v_u_223
		v_u_219:Play()
		if v_u_220 then
			v_u_223:Play()
		end
	end)
	p_u_215.MouseButton1Up:Connect(function()
		-- upvalues: (copy) v_u_217, (copy) v_u_220, (copy) v_u_221
		v_u_217:Play()
		if v_u_220 then
			v_u_221:Play()
		end
	end)
	p_u_215.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_214, (copy) p_u_215
		p_u_214:PressButton(p_u_215)
	end)
end
function v_u_1.CelestialTimer(_)
	-- upvalues: (copy) v_u_8
	local v230 = workspace:GetAttribute("CelestialTimer")
	for _, v231 in v_u_8:GetTagged("CelestialTimer") do
		local v232 = string.format
		local v233 = v231.Text:find("Celestial") and "Celestial Spawns In: " or ""
		local v234 = v230 / 60
		v231.Text = v232("%s%02d:%02d", v233, math.floor(v234), v230 % 60)
	end
end
function v_u_1.MoonTimer(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_51, (copy) v_u_19
	local v235 = workspace:GetAttribute("MoonTimer") or 0
	local v236 = (workspace:GetAttribute("CurrentEvent") or "") == "LowGravity"
	local v237 = v236 and "MOON Ends In:" or "MOON Starts In:"
	for _, v238 in v_u_8:GetTagged("MoonTimer") do
		local v239 = string.format
		local v240 = v235 / 60
		v238.Text = v239("%02d:%02d", math.floor(v240), v235 % 60)
	end
	for _, v241 in v_u_8:GetTagged("MoonState") do
		v241.Text = v237
	end
	local v242 = v_u_51:FindFirstChild("LuckyBlocks", true)
	if v242 then
		if v_u_19.UpdateFinished then
			v_u_51:FindFirstChild("LuckyBlock", true).Visible = true
		end
		if v236 then
			for _, v243 in v242:GetChildren() do
				if v243:IsA("ImageLabel") then
					local v244 = v243:FindFirstChild("Icon")
					if v244 then
						local v245 = v244:GetAttribute("MoonIcon")
						if v245 then
							local v246 = v243.TextLabel:GetAttribute("OriginalText")
							if v246 then
								v244.Image = v245
								v243.TextLabel.Text = ("Moon %*"):format(v246)
								v243.TraitChance.Visible = true
							end
						end
					end
				end
			end
		else
			for _, v247 in v242:GetChildren() do
				if v247:IsA("ImageLabel") then
					local v248 = v247:FindFirstChild("Icon")
					if v248 then
						local v249 = v248:GetAttribute("OGIcon")
						if v249 then
							local v250 = v247.TextLabel:GetAttribute("OriginalText")
							if v250 then
								v248.Image = v249
								v247.TextLabel.Text = v250
								v247.TraitChance.Visible = false
							end
						end
					end
				end
			end
		end
	else
		return
	end
end
function v_u_1.UpdateServerLuck(_)
	-- upvalues: (copy) v_u_54, (copy) v_u_29, (copy) v_u_55
	local v251 = workspace:GetAttribute("LuckValue") or 0
	local v252 = workspace:GetAttribute("LuckBoost") or 1
	local v253 = workspace:GetAttribute("LuckTimer") or 0
	local v254 = workspace:GetAttribute("AdminLuckTimer") or 0
	local v255 = workspace:GetAttribute("AdminLuckBoost") or 0
	local v256 = (v254 <= 0 or (v255 <= 0 or not v255)) and 1 or v255
	local v257 = v253 > 0 and v251 > 0 and (2 ^ v251 or 1) or 1
	local v258 = math.max(v252, v256, v257)
	local v259 = v258 >= 8 and 3 or (v258 >= 4 and 2 or (v258 >= 2 and 1 or 0))
	local v260 = v254 + v253
	for _, v261 in v_u_54:GetChildren() do
		if v261:IsA("ImageLabel") then
			v261.Visible = v261.LayoutOrder == v251
			if v261.LayoutOrder == v259 - 1 then
				v_u_29:UpdateEvent("Server Luck", v260, ("%*x Luck"):format(v258), v261.Icon.Image)
			end
		end
	end
	if v260 > 0 then
		local v262 = string.format
		local v263 = v260 / 60
		v_u_55.Text = "ENDS IN: " .. v262("%02d:%02d", math.floor(v263), v260 % 60)
		v_u_55.Visible = true
	else
		v_u_55.Visible = false
	end
	local _ = v258 > 1
end
function v_u_1.ChangeFuseMachine(_, p264, p265)
	-- upvalues: (copy) v_u_26, (copy) v_u_25, (copy) v_u_58, (copy) v_u_59, (copy) v_u_60, (copy) v_u_61, (copy) v_u_62, (copy) v_u_57, (copy) v_u_4, (copy) v_u_1
	local v266 = {}
	local v267 = 0
	local v268 = v_u_26:GetValueFromPathAsync(v_u_26.PathBuilder.OtherData.Fusing)
	local v269 = v_u_25:GetAttribute("FuseTimer") or 0
	v_u_58.Visible = not v268
	v_u_59.Visible = not v268
	local v270 = v_u_60
	local v271
	if v268 then
		v271 = v269 > 0
	else
		v271 = v268
	end
	v270.Visible = v271
	local v272 = v_u_61
	local v273
	if v268 then
		v273 = v269 > 0
	else
		v273 = v268
	end
	v272.Visible = v273
	local v274 = v_u_62
	local v275
	if v268 then
		v275 = v269 <= 0
	else
		v275 = v268
	end
	v274.Visible = v275
	for _, v276 in p265 or {} do
		local v277 = v276.Name
		table.insert(v266, v277)
		v267 = v267 + (table.find(p264, v276.Name) and 0 or 1)
	end
	local v278 = v268 and v266 and v266 or p264
	for v279 = 1, 3 do
		local v280 = v_u_57.InsiderFrame.Insider:WaitForChild("Brainrot" .. v279)
		if v278[v279] then
			local v281 = v_u_4.Brainrots.Normal:FindFirstChild(v278[v279])
			if not v281 then
				warn((("Normal brainrot not found: %*"):format(v278[v279])))
				return
			end
			v280.Visible = true
			v280.BrainrotName.Text = v281:GetAttribute("DisplayName")
			local v282 = v280.ViewportFrame.WorldModel
			v282:ClearAllChildren()
			v_u_1:Make3DBrainrot(v278[v279], "Normal", v282)
			v280.BrainrotName.TextColor3 = table.find(v266, v278[v279]) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0)
			v280.ViewportFrame.Ambient = table.find(v266, v278[v279]) and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(0, 0, 0)
			v280.ViewportFrame.LightColor = table.find(v266, v278[v279]) and Color3.fromRGB(140, 140, 140) or Color3.fromRGB(0, 0, 0)
			if not table.find(v266, v278[v279]) and v267 > 0 then
				v267 = v267 - 1
				v280.BrainrotName.Text = v280.BrainrotName.Text .. " (Wrong One!)"
				v280.BrainrotName.TextColor3 = Color3.fromRGB(255, 0, 0)
				v280.ViewportFrame.Ambient = Color3.fromRGB(150, 0, 0)
				v280.ViewportFrame.LightColor = Color3.fromRGB(150, 0, 0)
			end
		else
			v280.Visible = false
		end
	end
end
function v_u_1.ChangeBrainrot(_, p283, p284, p285)
	for _, v286 in p283:GetChildren() do
		if v286:IsA("BasePart") then
			if v286:FindFirstChild("SurfaceAppearance") then
				v286.TextureID = v286.SurfaceAppearance:GetAttribute("ColorMap") or p284[v286.Name].TextureID
			elseif v286:IsA("MeshPart") then
				v286.TextureID = p284[v286.Name].TextureID
			end
			if p285 == "Rainbow" then
				v286:AddTag("Rainbow")
			else
				v286:RemoveTag("Rainbow")
			end
		end
	end
end
function v_u_1.ChangeController(_, p287)
	-- upvalues: (copy) v_u_8, (copy) v_u_10
	for _, v288 in v_u_8:GetTagged("Controller") do
		v288.Visible = p287
		local _ = v_u_10:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross"
		if v288:GetAttribute("PS") then
			v288.Visible = v288.Visible and v288
		elseif v288:GetAttribute("Xbox") then
			local v289 = v288.Visible
			if v289 then
				v289 = not v288
			end
			v288.Visible = v289
		end
	end
end
function v_u_1.Init(p_u_290)
	-- upvalues: (copy) v_u_26, (copy) v_u_33, (copy) v_u_16, (copy) v_u_34, (copy) v_u_35, (copy) v_u_1, (copy) v_u_25, (copy) v_u_60, (copy) v_u_58, (copy) v_u_59, (copy) v_u_61, (copy) v_u_62, (copy) v_u_88, (copy) v_u_50, (copy) v_u_85, (copy) v_u_49, (copy) v_u_48, (copy) v_u_63, (copy) v_u_87, (copy) v_u_86, (ref) v_u_93, (copy) v_u_65, (copy) v_u_64, (copy) v_u_27, (copy) v_u_46, (ref) v_u_98, (ref) v_u_97, (ref) v_u_96, (copy) v_u_47, (copy) v_u_4, (copy) v_u_28, (copy) v_u_19, (copy) v_u_8, (copy) v_u_43, (copy) v_u_80, (copy) v_u_23, (copy) v_u_24, (copy) v_u_37, (copy) v_u_45, (copy) v_u_81, (copy) v_u_69, (copy) v_u_70, (copy) v_u_71, (copy) v_u_72, (copy) v_u_74, (ref) v_u_73, (copy) v_u_18, (copy) v_u_30, (copy) v_u_76, (copy) v_u_75, (copy) v_u_7, (copy) v_u_57, (copy) v_u_3, (copy) v_u_44, (copy) v_u_78, (copy) v_u_84, (copy) v_u_53, (copy) v_u_83, (copy) v_u_40, (copy) v_u_79, (copy) v_u_10, (copy) v_u_90, (copy) v_u_2, (copy) v_u_101, (copy) v_u_11, (copy) v_u_51, (copy) v_u_111, (copy) v_u_17, (copy) v_u_5
	local v_u_291 = v_u_26:GetValueFromPathAsync("Cash")
	local v292 = v_u_26:GetValueFromPathAsync("Upgrades/Speed")
	local v293 = v_u_26:GetValueFromPathAsync("Upgrades/Jump")
	local v_u_294 = v_u_26:GetValueFromPathAsync(v_u_26.PathBuilder.OtherData.Fusing)
	v_u_33.Text = "$" .. v_u_16(v_u_291)
	v_u_34.Text = v_u_16(v292 + 16) .. " Speed"
	local v295 = v_u_35
	local v296 = v_u_16
	local v297 = v293 * 0.3
	v295.Text = v296((math.round(v297))) .. " Jump"
	v_u_1:FetchProductPrices()
	v_u_1:ChangeRebirths()
	v_u_1:ChangeSpeeds()
	v_u_1:ChangeCarry()
	local v_u_298 = v_u_25:GetAttribute("FuseTimer") or 0
	local v299 = v_u_60.Text
	local v300
	if v_u_298 <= 0 then
		v300 = "Craft"
	else
		local v301 = string.format
		local v302 = v_u_298 / 60
		v300 = v301("%02d:%02d", math.floor(v302), v_u_298 % 60)
	end
	v299.Text = v300
	v_u_58.Visible = not v_u_294
	v_u_59.Visible = not v_u_294
	local v303 = v_u_60
	v_u_294 = v_u_294
	if v_u_294 then
		local v304 = v_u_298 > 0
	end
	v303.Visible = v304
	local v305 = v_u_61
	v_u_294 = v_u_294
	if v_u_294 then
		local v306 = v_u_298 > 0
	end
	v305.Visible = v306
	local v307 = v_u_62
	v_u_294 = v_u_294
	local v308
	if v_u_294 then
		v308 = v_u_298 <= 0
	else
		v308 = v_u_294
	end
	v307.Visible = v308
	v_u_88:FireServer("Get")
	v_u_58.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_88
		v_u_88:FireServer("Return")
	end)
	v_u_59.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_88
		v_u_88:FireServer("StartFusing")
	end)
	v_u_62.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_88
		v_u_88:FireServer("Fuse")
	end)
	v_u_88.OnClientEvent:Connect(function(p309, p310)
		-- upvalues: (ref) v_u_1
		v_u_1:ChangeFuseMachine(p309, p310)
	end)
	v_u_59:WaitForChild("Text").Text = "Craft Lucky Block ($50M)"
	v_u_26:GetPathSignal(v_u_26.PathBuilder.OtherData.Fusing):Connect(function()
		-- upvalues: (ref) v_u_294, (ref) v_u_26, (ref) v_u_58, (ref) v_u_59, (ref) v_u_60, (copy) v_u_298, (ref) v_u_61, (ref) v_u_62
		v_u_294 = v_u_26:GetValueFromPathAsync(v_u_26.PathBuilder.OtherData.Fusing)
		v_u_58.Visible = not v_u_294
		v_u_59.Visible = not v_u_294
		local v311 = v_u_60
		local v312 = v_u_294
		if v312 then
			v312 = v_u_298 > 0
		end
		v311.Visible = v312
		local v313 = v_u_61
		local v314 = v_u_294
		if v314 then
			v314 = v_u_298 > 0
		end
		v313.Visible = v314
		local v315 = v_u_62
		local v316 = v_u_294
		if v316 then
			v316 = v_u_298 <= 0
		end
		v315.Visible = v316
	end)
	v_u_25:GetAttributeChangedSignal("FuseTimer"):Connect(function()
		-- upvalues: (ref) v_u_25, (ref) v_u_60, (ref) v_u_58, (ref) v_u_294, (ref) v_u_59, (ref) v_u_61, (ref) v_u_62
		local v317 = v_u_25:GetAttribute("FuseTimer")
		local v318 = v_u_60.Text
		local v319
		if v317 <= 0 then
			v319 = "Craft"
		else
			local v320 = string.format
			local v321 = v317 / 60
			v319 = v320("%02d:%02d", math.floor(v321), v317 % 60)
		end
		v318.Text = v319
		v_u_58.Visible = not v_u_294
		v_u_59.Visible = not v_u_294
		local v322 = v_u_60
		local v323 = v_u_294
		if v323 then
			v323 = v317 > 0
		end
		v322.Visible = v323
		local v324 = v_u_61
		local v325 = v_u_294
		if v325 then
			v325 = v317 > 0
		end
		v324.Visible = v325
		local v326 = v_u_62
		local v327 = v_u_294
		if v327 then
			v327 = v317 <= 0
		end
		v326.Visible = v327
	end)
	v_u_50.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_85
		v_u_85:FireServer()
	end)
	v_u_85.OnClientEvent:Connect(function(p328)
		-- upvalues: (ref) v_u_49, (ref) v_u_1, (ref) v_u_48
		v_u_49.Text = string.format("%s wants to gift you %s!", p328.Sender, p328.Brainrot)
		v_u_1:OpenFrame(v_u_48, true)
	end)
	v_u_63:WaitForChild("Drop").MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_87
		v_u_87:FireServer("Drop")
	end)
	v_u_87.OnClientEvent:Connect(function(p329)
		-- upvalues: (ref) v_u_63
		if p329 == "Grab" or p329 == "Drop" then
			v_u_63.Visible = p329 == "Grab"
		end
	end)
	v_u_86.OnClientEvent:Connect(function(_)
		-- upvalues: (ref) v_u_93, (ref) v_u_65, (ref) v_u_1, (ref) v_u_64
		if v_u_93 then
			task.cancel(v_u_93)
		end
		v_u_93 = task.spawn(function()
			-- upvalues: (ref) v_u_65, (ref) v_u_1, (ref) v_u_64
			for v330 = 10, 0, -1 do
				v_u_65.Title.Text = string.format("Yes (%ss)", v330)
				task.wait(1)
			end
			v_u_1:OpenFrame(v_u_64, false)
		end)
		v_u_1:OpenFrame(v_u_64, true)
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_46, (ref) v_u_98, (ref) v_u_97, (ref) v_u_96, (ref) v_u_47, (ref) v_u_4, (ref) v_u_1, (ref) v_u_28, (ref) v_u_19, (ref) v_u_8
		local v_u_331 = {}
		for v332 in v_u_27 do
			table.insert(v_u_331, v332)
		end
		table.sort(v_u_331, function(p333, p334)
			-- upvalues: (ref) v_u_27
			return v_u_27[p333].CashPerSec < v_u_27[p334].CashPerSec
		end)
		for _, v_u_335 in {
			"Normal",
			"Gold",
			"Diamond",
			"Emerald",
			"Bloodmoon",
			"Rainbow"
		} do
			v_u_46:WaitForChild("Mutations"):WaitForChild(v_u_335).MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_98, (copy) v_u_335, (ref) v_u_46, (ref) v_u_97, (ref) v_u_96, (copy) v_u_331, (ref) v_u_27, (ref) v_u_47, (ref) v_u_4, (ref) v_u_1
				v_u_98 = v_u_335
				local v336 = v_u_46.Header.Complete
				local v337 = #v_u_97[v_u_98] / v_u_96 * 100
				v336.Text = math.floor(v337) .. "% Completed"
				v_u_46.Header.Discovered.Text = #v_u_97[v_u_98] .. "/" .. v_u_96 .. " Discovered"
				for _, v_u_338 in v_u_331 do
					local v_u_339 = v_u_27[v_u_338]
					task.spawn(function()
						-- upvalues: (ref) v_u_47, (copy) v_u_338, (ref) v_u_4, (ref) v_u_335, (ref) v_u_97, (ref) v_u_98, (copy) v_u_339, (ref) v_u_1
						local v340 = v_u_47:FindFirstChild(v_u_338)
						local v341
						if v340 then
							v341 = v340.ViewportFrame.WorldModel:GetChildren()[1]
						else
							v341 = v340
						end
						local v342 = v_u_4.Brainrots[v_u_335]:FindFirstChild(v_u_338)
						if v342 then
							if v341 then
								if v340 then
									v340.BrainrotName.Text = not table.find(v_u_97[v_u_98], v_u_338) or v_u_339.DisplayName or (v_u_338:gsub("(%u)", " %1"):gsub("^ ", "") or "??")
									v340.ViewportFrame.Ambient = table.find(v_u_97[v_u_98], v_u_338) and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(0, 0, 0)
									v340.ViewportFrame.LightColor = table.find(v_u_97[v_u_98], v_u_338) and Color3.fromRGB(140, 140, 140) or Color3.fromRGB(0, 0, 0)
									if v341:FindFirstChildOfClass("Model") then
										for _, v343 in v341:GetChildren() do
											if v343:IsA("Model") then
												if v343.PrimaryPart:FindFirstChild("SurfaceAppearance") then
													v343.PrimaryPart.SurfaceAppearance:Destroy()
													v343.PrimaryPart.TextureID = v342.PrimaryPart.TextureID
												else
													v343.PrimaryPart.TextureID = v342.PrimaryPart.TextureID
												end
												if v342.PrimaryPart:FindFirstChild("SurfaceAppearance") then
													v342.PrimaryPart.SurfaceAppearance:Clone().Parent = v343.PrimaryPart
												end
												if v_u_335 == "Rainbow" then
													v343.PrimaryPart:AddTag("Rainbow")
												else
													v343.PrimaryPart:RemoveTag("Rainbow")
												end
											end
										end
									else
										v_u_1:ChangeBrainrot(v341, v342, v_u_335)
									end
								else
									return
								end
							else
								warn((("Brainrot viewport model not found: %*"):format(v_u_338)))
								return
							end
						else
							warn((("Brainrot model not found: %*/%*"):format(v_u_335, v_u_338)))
							return
						end
					end)
				end
			end)
			if v_u_335 == "Normal" then
				v_u_47.Name = v_u_335 .. "List"
				v_u_47.Visible = true
				v_u_47.Parent = v_u_47.Parent
				for v344, v345 in v_u_331 do
					local v346 = v_u_27[v345]
					if v346 then
						local v347 = v_u_28[v346.Rarity]
						if v347 then
							local v348 = v346.HiddenUntilUpdate
							if v348 then
								v348 = not v_u_19.UpdateFinished
							end
							if not v348 then
								v_u_96 = v_u_96 + 1
							end
							local v349 = v_u_47[v346.Rarity]:Clone()
							v349.Name = v345
							v349.Icon.Visible = false
							v349.ViewportFrame.Ambient = Color3.fromRGB(0, 0, 0)
							v349.ViewportFrame.LightColor = Color3.fromRGB(0, 0, 0)
							v349.Visible = not v348
							v349.Parent = v_u_47
							v349.LayoutOrder = v347.Index
							if v348 then
								v_u_8:AddTag(v349, "ClientShowOnUpdate")
							end
							v_u_1:Make3DBrainrot(v345, v_u_335, v349.ViewportFrame.WorldModel)
							local v350 = v_u_47
							v350.CanvasSize = v350.CanvasSize + UDim2.fromScale(0, v344 % 4 == 0 and 0.35 or 0)
						end
					end
				end
			end
		end
		v_u_1:ChangeIndex()
		v_u_19.UpdateSignalClient:Once(function()
			-- upvalues: (ref) v_u_96, (ref) v_u_47, (ref) v_u_27, (ref) v_u_1
			v_u_96 = 0
			for _, v351 in v_u_47:GetChildren() do
				if v_u_27[v351.Name] then
					v_u_96 = v_u_96 + 1
				end
			end
			v_u_1:ChangeIndex()
		end)
	end)
	for _, v_u_352 in { 1, 5, 10 } do
		v_u_43:WaitForChild("InsiderFrame"):WaitForChild(v_u_352):WaitForChild("MoneyButton").MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_80, (copy) v_u_352, (ref) v_u_23, (ref) v_u_24
			local v353 = v_u_352
			local v354 = v_u_80:InvokeServer("Speed", (tonumber(v353)))
			if v354 == nil then
				return
			elseif v354 then
				v_u_23:Play()
			else
				v_u_24:Play()
			end
		end)
	end
	v_u_37.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_80, (ref) v_u_37
		local v355 = v_u_80:InvokeServer("Speed")
		v_u_37.Title.Text = "Slow Mode: " .. (v355 and "On" or "Off")
		v_u_37.Image = v355 and "rbxassetid://76298087250695" or "rbxassetid://92963303283282"
	end)
	v_u_45:WaitForChild("MoneyButton").MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_81, (ref) v_u_23, (ref) v_u_24
		if v_u_81:InvokeServer("Carry") then
			v_u_23:Play()
		else
			v_u_24:Play()
		end
	end)
	workspace:GetAttributeChangedSignal("LuckyBlockFuseTimer"):Connect(function()
		-- upvalues: (ref) v_u_8
		local v356 = workspace:GetAttribute("LuckyBlockFuseTimer")
		for _, v357 in v_u_8:GetTagged("RecipeTimer") do
			local v358 = string.format
			local v359 = v356 / 60
			v357.Text = v358("Next Recipe in: %02d:%02d", math.floor(v359), v356 % 60)
		end
	end)
	for _, v_u_360 in {
		v_u_69,
		v_u_70,
		v_u_71,
		v_u_72,
		v_u_74,
		v_u_73
	} do
		local v_u_361 = Instance.new("Part", v_u_360)
		v_u_361.Name = "TouchPart"
		v_u_361.CFrame = v_u_360:GetPivot() * CFrame.new(v_u_360 == v_u_74 and -8 or -4, 0, 0) * CFrame.fromOrientation(0, 0, 1.5707963267948966)
		v_u_361.Shape = Enum.PartType.Cylinder
		v_u_361.Size = Vector3.new(10, 0, 0) + Vector3.new(0, 1, 1) * (v_u_360 == v_u_74 and 40 or (v_u_360 == v_u_73 and 40 or 20))
		v_u_361.Anchored = true
		v_u_361.Transparency = 1
		v_u_361.CanCollide = false
		if v_u_360 == v_u_74 then
			local v362 = Instance.new("Attachment", v_u_360)
			local v363 = Instance.new("ProximityPrompt", v362)
			v363.ActionText = "Sell"
			v363.RequiresLineOfSight = false
			v363.Triggered:Connect(function(p364)
				-- upvalues: (ref) v_u_25, (ref) v_u_18, (ref) v_u_30, (ref) v_u_76, (ref) v_u_75
				if p364 == v_u_25 then
					if not v_u_18.SellDebounce then
						v_u_30.SellBillboard.Enabled = true
						v_u_76.Text = "Hello! What do you need from me?"
						v_u_75.Enabled = true
						if v_u_18.SellTask then
							task.cancel(v_u_18.SellTask)
						end
					end
				else
					return
				end
			end)
		elseif v_u_360 == v_u_71 or v_u_360 == v_u_72 then
			local v365 = Instance.new("Attachment", v_u_360)
			local v366 = Instance.new("ProximityPrompt", v365)
			v366.ActionText = "Buy!"
			v366.RequiresLineOfSight = false
			v366.Triggered:Connect(function(p367)
				-- upvalues: (ref) v_u_25, (ref) v_u_7, (copy) v_u_360, (ref) v_u_71
				if p367 == v_u_25 then
					v_u_7:PromptGamePassPurchase(v_u_25, v_u_360 == v_u_71 and 1693794094 or 1699541442)
				end
			end)
		elseif v_u_360 == v_u_73 then
			v_u_361:Destroy()
			local v368 = Instance.new("Attachment", v_u_360)
			local v_u_369 = Instance.new("ProximityPrompt", v368)
			v_u_369.ActionText = "Open"
			v_u_369.RequiresLineOfSight = false
			print(v_u_369)
			v_u_369.Triggered:Connect(function(p370)
				-- upvalues: (ref) v_u_25, (ref) v_u_1, (ref) v_u_57
				if p370 == v_u_25 then
					v_u_1:OpenFrame(v_u_57)
				end
			end)
			local function v372()
				-- upvalues: (ref) v_u_1, (ref) v_u_57, (copy) v_u_369
				local v371 = workspace:GetAttribute("LuckyBlockFuseEnabled")
				if not v371 then
					v_u_1:CloseFrame(v_u_57)
				end
				v_u_369.Enabled = v371
			end
			local v373 = workspace:GetAttribute("LuckyBlockFuseEnabled")
			if not v373 then
				v_u_1:CloseFrame(v_u_57)
			end
			v_u_369.Enabled = v373
			workspace:GetAttributeChangedSignal("LuckyBlockFuseEnabled"):Connect(v372)
		else
			v_u_361.Touched:Connect(function(p374)
				-- upvalues: (ref) v_u_3, (ref) v_u_25, (ref) v_u_1, (copy) v_u_360, (ref) v_u_69, (ref) v_u_43, (ref) v_u_44
				if p374.Name == "HumanoidRootPart" then
					local v375 = p374.Parent
					if v375 then
						v375 = v_u_3:GetPlayerFromCharacter(p374.Parent)
					end
					if v375 and v375 == v_u_25 then
						v_u_1:OpenFrame(v_u_360 == v_u_69 and v_u_43 or v_u_44, true)
					end
				else
					return
				end
			end)
		end
		if v_u_360 ~= v_u_71 and (v_u_360 ~= v_u_72 and v_u_360 ~= v_u_73) then
			v_u_361.TouchEnded:Connect(function(p376)
				-- upvalues: (ref) v_u_3, (ref) v_u_25, (copy) v_u_361, (copy) v_u_360, (ref) v_u_74, (ref) v_u_30, (ref) v_u_75, (ref) v_u_1, (ref) v_u_69, (ref) v_u_43, (ref) v_u_73, (ref) v_u_57, (ref) v_u_44
				if p376.Name == "HumanoidRootPart" then
					local v377 = p376.Parent
					if v377 then
						v377 = v_u_3:GetPlayerFromCharacter(p376.Parent)
					end
					if v377 and v377 == v_u_25 then
						if v_u_25.Character and (v_u_25.Character:FindFirstChild("HumanoidRootPart") and table.find(v_u_361:GetTouchingParts(), v_u_25.Character.HumanoidRootPart)) then
							return
						elseif v_u_360 == v_u_74 then
							v_u_30.SellBillboard.Enabled = false
							v_u_75.Enabled = false
						else
							v_u_1:CloseFrame(v_u_360 == v_u_69 and v_u_43 or (v_u_360 == v_u_73 and v_u_57 or v_u_44))
						end
					else
						return
					end
				else
					return
				end
			end)
		end
	end
	for _, v378 in v_u_8:GetTagged("UIButton") do
		v_u_1:ButtonFunction(v378)
	end
	v_u_8:GetInstanceAddedSignal("UIButton"):Connect(function(p379)
		-- upvalues: (ref) v_u_1
		v_u_1:ButtonFunction(p379)
	end)
	v_u_78.OnClientEvent:Connect(function(p380, p381)
		-- upvalues: (ref) v_u_1
		local v382 = p381 or {}
		if v382.Type == "Lava" then
			v_u_1:LavaNotification(p380, 5, v382.Color)
			return
		elseif v382.Type == "LowGravity" then
			v_u_1:LowGravityNotification(p380, 5, v382.Color)
		else
			v_u_1:ShowNotification(p380, v382, 5)
		end
	end)
	v_u_84.OnClientEvent:Connect(function(p383)
		p383:Play()
	end)
	local v_u_384 = v_u_26:GetValueFromPathAsync("Upgrades/Speed")
	local v_u_385 = v_u_26:GetValueFromPathAsync("Upgrades/Jump")
	local v_u_386 = v_u_26:GetValueFromPathAsync(v_u_26.PathBuilder.OtherData.StarterPack)
	v_u_33.Text = "$" .. v_u_16(v_u_291)
	v_u_34.Text = v_u_16(v_u_384 + 16) .. " Speed"
	local v387 = v_u_35
	local v388 = v_u_16
	local v389 = v_u_385 * 0.3
	v387.Text = v388((math.round(v389))) .. " Jump"
	v_u_1:ChangeRebirths()
	v_u_1:ChangeSpeeds()
	v_u_1:ChangeCarry()
	v_u_53.Visible = not v_u_386
	v_u_26:GetPathSignal(v_u_26.PathBuilder.OtherData.StarterPack):Connect(function()
		-- upvalues: (ref) v_u_386, (ref) v_u_26, (ref) v_u_53
		v_u_386 = v_u_26:GetValueFromPathAsync(v_u_26.PathBuilder.OtherData.StarterPack)
		v_u_53.Visible = not v_u_386
	end)
	v_u_26:GetPathSignal("Cash"):Connect(function()
		-- upvalues: (ref) v_u_291, (ref) v_u_26, (ref) v_u_33, (ref) v_u_16
		v_u_291 = v_u_26:GetValueFromPathAsync("Cash")
		v_u_33.Text = "$" .. v_u_16(v_u_291)
	end)
	v_u_26:GetPathSignal("Upgrades/Speed"):Connect(function()
		-- upvalues: (ref) v_u_384, (ref) v_u_26, (ref) v_u_34, (ref) v_u_16
		v_u_384 = v_u_26:GetValueFromPathAsync("Upgrades/Speed")
		v_u_34.Text = v_u_16(v_u_384 + 16) .. " Speed"
	end)
	v_u_26:GetPathSignal("Upgrades/Jump"):Connect(function()
		-- upvalues: (ref) v_u_385, (ref) v_u_26, (ref) v_u_35, (ref) v_u_16
		v_u_385 = v_u_26:GetValueFromPathAsync("Upgrades/Jump")
		local v390 = v_u_35
		local v391 = v_u_16
		local v392 = v_u_385 * 0.3
		v390.Text = v391((math.round(v392))) .. " Jump"
	end)
	v_u_83.OnClientEvent:Connect(function(p393)
		-- upvalues: (ref) v_u_1
		v_u_1:ChangeIndex(p393)
	end)
	v_u_40.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_79, (ref) v_u_23, (ref) v_u_24
		if v_u_79:InvokeServer("Rebirth") then
			v_u_23:Play()
		else
			v_u_24:Play()
		end
	end)
	p_u_290:ChangeController(v_u_10.PreferredInput == Enum.PreferredInput.Gamepad)
	v_u_10.GamepadConnected:Connect(function()
		-- upvalues: (copy) p_u_290
		task.wait(1)
		p_u_290:ChangeController(true)
	end)
	v_u_10.GamepadDisconnected:Connect(function()
		-- upvalues: (copy) p_u_290
		task.wait(1)
		p_u_290:ChangeController(false)
	end)
	v_u_10.Changed:Connect(function()
		-- upvalues: (copy) p_u_290, (ref) v_u_10
		p_u_290:ChangeController(v_u_10.PreferredInput == Enum.PreferredInput.Gamepad)
	end)
	v_u_10.InputBegan:Connect(function(p394, p395)
		-- upvalues: (ref) v_u_90, (ref) v_u_1, (ref) v_u_2, (ref) v_u_101
		if p395 then
			return
		elseif p394.KeyCode == Enum.KeyCode.ButtonB then
			for _, v396 in table.clone(v_u_90) do
				v_u_1:CloseFrame(v396)
			end
			v_u_2.SelectedObject = nil
			return
		else
			local v397 = v_u_101[p394.KeyCode]
			if v397 then
				v_u_1:PressButton(v397)
			end
		end
	end)
	local function v398()
		-- upvalues: (ref) v_u_1
		v_u_1:ChangeRebirths()
		v_u_1:ChangeSpeeds()
		v_u_1:ChangeCarry()
	end
	v_u_26:GetPathSignal("Rebirths"):Connect(v398)
	v_u_26:GetPathSignal("Upgrades/Speed"):Connect(v398)
	v_u_26:GetPathSignal("Upgrades/Carry"):Connect(v398)
	v_u_1:CelestialTimer()
	workspace:GetAttributeChangedSignal("CelestialTimer"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:CelestialTimer()
	end)
	v_u_1:UpdateServerLuck()
	workspace:GetAttributeChangedSignal("LuckValue"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:UpdateServerLuck()
	end)
	workspace:GetAttributeChangedSignal("LuckBoost"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:UpdateServerLuck()
	end)
	workspace:GetAttributeChangedSignal("LuckTimer"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:UpdateServerLuck()
	end)
	workspace:GetAttributeChangedSignal("AdminLuckTimer"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:UpdateServerLuck()
	end)
	workspace:GetAttributeChangedSignal("AdminLuckBoost"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:UpdateServerLuck()
	end)
	workspace:GetAttributeChangedSignal("MoonTimer"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:MoonTimer()
	end)
	task.delay(15, function()
		-- upvalues: (ref) v_u_11
		local v399, v400 = pcall(function()
			-- upvalues: (ref) v_u_11
			return v_u_11:GetEventRsvpStatusAsync("3220658109739172491")
		end)
		if not v399 or v400 ~= Enum.RsvpStatus.Going then
			local _, _ = pcall(function()
				-- upvalues: (ref) v_u_11
				return v_u_11:PromptRsvpToEventAsync("3220658109739172491")
			end)
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_51, (ref) v_u_111
		local v401 = v_u_51.InsiderFrame.ScrollingFrame.LuckyBlock
		local v402 = v401.Timer
		while true do
			local v403 = 1772834400 - workspace:GetServerTimeNow()
			v402.Text = v_u_111(v403)
			if v403 < 0 then
				break
			end
			task.wait(1)
		end
		v401.Visible = false
	end)
	v_u_25.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_90, (ref) v_u_1
		for _, v404 in table.clone(v_u_90) do
			v_u_1:CloseFrame(v404)
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_17, (ref) v_u_11, (ref) v_u_25, (ref) v_u_5
		v_u_17.new():setImage("rbxasset://textures/ui/PlayerList/FriendIcon@3x.png"):setImageScale(0.5):bindEvent("deselected", function()
			-- upvalues: (ref) v_u_11, (ref) v_u_25
			local _, v405 = pcall(function()
				-- upvalues: (ref) v_u_11, (ref) v_u_25
				return v_u_11:CanSendGameInviteAsync(v_u_25)
			end)
			if v405 == true then
				v_u_11:PromptGameInvite(v_u_25)
			end
		end):oneClick()
		local v_u_406 = v_u_5.Musics
		local v_u_407 = v_u_5.Events
		local v_u_408 = v_u_17.new():setImage(11243591064, "Deselected"):setImage(14861956881, "Selected"):setRight(true):autoDeselect(false)
		v_u_408:bindEvent("selected", function()
			-- upvalues: (copy) v_u_406, (copy) v_u_408, (copy) v_u_407
			for _, v409 in v_u_406:GetChildren() do
				v409.Volume = v_u_408.isSelected and 0 or (v409:GetAttribute("DefaultVolume") or 0.5)
			end
			for _, v410 in v_u_407:GetChildren() do
				v410.Volume = v_u_408.isSelected and 0 or (v410:GetAttribute("DefaultVolume") or 0.5)
			end
		end)
		v_u_408:bindEvent("deselected", function()
			-- upvalues: (copy) v_u_406, (copy) v_u_408, (copy) v_u_407
			for _, v411 in v_u_406:GetChildren() do
				v411.Volume = v_u_408.isSelected and 0 or (v411:GetAttribute("DefaultVolume") or 0.5)
			end
			for _, v412 in v_u_407:GetChildren() do
				v412.Volume = v_u_408.isSelected and 0 or (v412:GetAttribute("DefaultVolume") or 0.5)
			end
		end)
		v_u_406.ChildAdded:Connect(function(p413)
			-- upvalues: (copy) v_u_408
			if p413:IsA("Sound") then
				p413.Volume = v_u_408.isSelected and 0 or (p413:GetAttribute("DefaultVolume") or 0.5)
			end
		end)
		v_u_407.ChildAdded:Connect(function(p414)
			-- upvalues: (copy) v_u_408
			if p414:IsA("Sound") then
				p414.Volume = v_u_408.isSelected and 0 or (p414:GetAttribute("DefaultVolume") or 0.5)
			end
		end)
	end)
end
return v_u_1
