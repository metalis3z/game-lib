-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:07
-- Luau version 6, Types version 3
-- Time taken: 0.007997 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "LeaderboardController";
	_topPlayers = {};
	_connections = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.setTopPlayer(arg1, arg2) -- Line 40
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: var11_upvw (read and write)
	]]
	local Character_3 = arg2.Character
	if not Character_3 then
	else
		local Head_3 = Character_3:FindFirstChild("Head")
		if not Head_3 then return end
		local TopPlayer_3 = Head_3:FindFirstChild("TopPlayer")
		if not TopPlayer_3 then
			local clone_3 = Assets_upvr.Billboards.TopPlayer:Clone()
			clone_3.Parent = Head_3
			TopPlayer_3 = clone_3
		end
		TopPlayer_3.PlayerName.Text = arg2.DisplayName
		local var46 = "clanTag"
		local attribute_2 = arg2:GetAttribute(var46)
		if attribute_2 == nil then
			var46 = false
		else
			var46 = true
		end
		TopPlayer_3.ClanTag.Visible = var46
		TopPlayer_3.ClanTag.Text = `[{attribute_2}]` or ""
		for _, v_12 in TopPlayer_3.List:GetChildren() do
			if v_12:IsA("Frame") then
				v_12.Visible = false
				local var51 = arg1._topPlayers[var11_upvw.toCamel(v_12.Name)]
				if var51 then
					for i_13, v_13 in var51 do
						if v_13.userInfos.Id == arg2.UserId then
							v_12.Icon.Rank.Text = `#{i_13}`
							v_12.Visible = true
						end
					end
				end
			end
		end
	end
end
function any_CreateController_result1.toggleTopPlayer(arg1, arg2) -- Line 87
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	for _, v in Players_upvr:GetPlayers() do
		local Character_2 = v.Character
		if Character_2 then
			local Head_2 = Character_2:FindFirstChild("Head")
			if Head_2 then
				local TopPlayer_2 = Head_2:FindFirstChild("TopPlayer")
				if TopPlayer_2 then
					TopPlayer_2.Enabled = arg2
				end
			end
		end
	end
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.getLeaderboardModels(arg1, arg2) -- Line 108
	--[[ Upvalues[2]:
		[1]: CollectionService_upvr (readonly)
		[2]: var11_upvw (read and write)
	]]
	local module = {}
	for _, v_2 in CollectionService_upvr:GetTagged("Leaderboard"), nil do
		if v_2.Name == var11_upvw.toPascal(arg2) and v_2:FindFirstChild("Show") then
			module[#module + 1] = v_2
		end
	end
	return module
end
function any_CreateController_result1.clearModel(arg1, arg2) -- Line 129
	for _, v_3 in pairs(arg2) do
		for _, v_4 in v_3.Show.Show.SurfaceGui:GetChildren() do
			for _, v_5 in v_4.Stats:GetChildren() do
				if v_5:IsA("Frame") then
					v_5:Destroy()
					task.wait()
				end
			end
		end
	end
end
function any_CreateController_result1.updateLeaderboard(arg1, arg2, arg3) -- Line 144
	--[[ Upvalues[6]:
		[1]: Players_upvr (readonly)
		[2]: var12_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: var11_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getLeaderboardModels_result1 = arg1:getLeaderboardModels(arg2)
	arg1:clearModel(any_getLeaderboardModels_result1)
	arg1._topPlayers[arg2] = arg3[1]
	for _, v_6 in Players_upvr:GetChildren() do
		arg1:setTopPlayer(v_6)
	end
	local var125 = var12_upvw[arg2]
	for i_7, v_7 in var125.values do
		for i_8, v_8 in arg3[i_7] do
			local value = v_8.value
			for _, v_9 in any_getLeaderboardModels_result1 do
				local clone = Assets_upvr.UI.Leaderboard:Clone()
				local Val = clone.Val
				local Icon = Val.Icon
				local DisplayName = clone.Player.DisplayName
				local var134
				if var125.isClan then
					local clanData = v_8.clanData
					var134 = `[{clanData.tag or "FAILED"}]`
					DisplayName.Text = var134
					var134 = 0.243
					DisplayName.Position = UDim2.fromScale(var134, 0.5)
					clone.Player.Username.Visible = false
					var134 = "rbxassetid://"
					clone.Player.Headshot.Image = var134..(clanData.image or "16987069167")
			else
					local userInfos_upvr = v_8.userInfos
					local hasVerified = userInfos_upvr.HasVerifiedBadge
					local displayNameText
					if hasVerified then
						displayNameText = `{userInfos_upvr.DisplayName}{utf8.char(57344)}`
					else
						displayNameText = `{userInfos_upvr.DisplayName}`
					end
					DisplayName.Text = displayNameText
					clone.Player.Username.Text = `@{userInfos_upvr.Username}`
					local Headshot_upvr = clone.Player.Headshot
					local function loadHeadshot()
						--[[ Upvalues[3]:
							[1]: Headshot_upvr (readonly)
							[2]: var11_upvw (copied, read and write)
							[3]: userInfos_upvr (readonly)
						]]
						Headshot_upvr.Image = var11_upvw.getUserHeadshot(userInfos_upvr.Id)
					end
					task.spawn(loadHeadshot)
				end
				local countryRegion = v_8.countryRegion or "SE"
				local countryData = var13_upvw[countryRegion]
				if not countryData or not countryData.decal then
					countryData = var13_upvw.SE
				end
				clone.Country.Image = countryData.decal
				clone.Rank.Label.Text = `#{i_8}`
				local labelText = var11_upvw.suffixes(value)
				if v_7.getText then
					labelText = v_7.getText(value)
				end
				Val.Label.Text = labelText
				if v_7.getIcon and v_7.getIcon(value) then
					Icon.Image = v_7.getIcon(value)
					Icon.Visible = true
				end
				if v_7.getInfoHoverItem then
					var6_upvw:createInfoHoverOnGuiStateChange(Icon, {
						hoverType = "lbAura";
						item = v_7.getInfoHoverItem(value);
					})
				end
				if i_8 <= 3 then
					local UIStroke = clone.UIStroke
					UIStroke.Transparency = 0
					UIStroke.Color = Color3.fromRGB(153, 153, 153)
					clone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					clone.BackgroundTransparency = 0
					clone[i_8].Enabled = true
					UIStroke[i_8].Enabled = true
				end
				clone.LayoutOrder = i_8
				clone.Visible = true
				clone.Parent = v_9.Show.Show.SurfaceGui[i_7].Stats
				task.wait()
			end
		end
	end
end
function any_CreateController_result1.weeklyReward(arg1, arg2) -- Line 241
	--[[ Upvalues[4]:
		[1]: var10_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: Knit_upvr (readonly)
		[4]: var6_upvw (read and write)
	]]
	local tbl = {}
	for _, v_10 in arg2 do
		tbl[#tbl + 1] = var10_upvw.itemUtils.createItemFromData(v_10)
	end
	var5_upvw:preloadSounds({"Weekly Reward"})
	repeat
		Knit_upvr.listenToUpdate:Wait()
		Knit_upvr.listenToUpdate:Wait()
		Knit_upvr.listenToUpdate:Wait()
	until var6_upvw:isFrameOpen() or _G.introFinished
	var6_upvw:createMessagePopup({
		title = "Congrats!";
		message = "Rewards from weekly leaderboard!";
		messageSize = UDim2.fromScale(1, 0.361);
		sound = "Weekly Reward";
		items = tbl;
	})
end
function any_CreateController_result1.KnitStart(arg1) -- Line 267
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Players_upvr (readonly)
		[4]: var7_upvw (read and write)
	]]
	task.spawn(function() -- Line 268
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: arg1 (readonly)
			[4]: Players_upvr (copied, readonly)
		]]
		var4_upvw:waitForData()
		if LocalPlayer_upvr:HasAppearanceLoaded() then
			arg1:setTopPlayer(LocalPlayer_upvr)
		end
		LocalPlayer_upvr.CharacterAdded:Connect(function() -- Line 274
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: LocalPlayer_upvr (copied, readonly)
			]]
			arg1:setTopPlayer(LocalPlayer_upvr)
		end)
		for _, v_11 in Players_upvr:GetChildren() do
			arg1:setTopPlayer(v_11)
		end
	end)
	var7_upvw.updateLeaderboard:Connect(function(...) -- Line 283
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateLeaderboard(...)
	end)
	var7_upvw.weeklyReward:Connect(function(...) -- Line 286
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:weeklyReward(...)
	end)
	Players_upvr.PlayerAdded:Connect(function(arg1_2) -- Line 290
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1_2.CharacterAdded:Connect(function() -- Line 291
			--[[ Upvalues[2]:
				[1]: arg1_2 (readonly)
				[2]: arg1 (copied, readonly)
			]]
			arg1_2.Character:WaitForChild("Head")
			arg1:setTopPlayer(arg1_2)
		end)
	end)
end
function any_CreateController_result1.KnitInit(arg1) -- Line 298
	--[[ Upvalues[10]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var11_upvw (read and write)
		[9]: var12_upvw (read and write)
		[10]: var13_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("LeaderboardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Leaderboards)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Countries)
end
return any_CreateController_result1