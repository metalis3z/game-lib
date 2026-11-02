-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:39
-- Luau version 6, Types version 3
-- Time taken: 0.004909 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TradeListFrame";
	_debounce = 0;
})
any_new_result1._playerInfos = {}
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local var10_upvw
local var11_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Main_2 = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("TradeListFrame"):WaitForChild("Main")
local List_upvr = Main_2:WaitForChild("List")
local Holder_upvr = List_upvr:WaitForChild("Holder")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.createPlayers(arg1) -- Line 47
	--[[ Upvalues[10]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: Assets_upvr (readonly)
		[5]: var11_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var5_upvw (read and write)
		[9]: var4_upvw (read and write)
		[10]: var7_upvw (read and write)
	]]
	for _, v_upvr in Players_upvr:GetPlayers() do
		if v_upvr ~= LocalPlayer_upvr and not Holder_upvr:FindFirstChild(v_upvr.Name) then
			local clone = Assets_upvr.UI.TradeListPlayer:Clone()
			local Main = clone.Main
			local Icon_upvr = Main.PlayerIcon.Icon
			Main.Username.Text = `@{v_upvr.Name}`
			Main.DisplayName.Text = `{v_upvr.DisplayName}`
			task.spawn(function() -- Line 68
				--[[ Upvalues[3]:
					[1]: Icon_upvr (readonly)
					[2]: var11_upvw (copied, read and write)
					[3]: v_upvr (readonly)
				]]
				Icon_upvr.Image = var11_upvw.getUserHeadshot(v_upvr.UserId)
			end)
			clone.Name = v_upvr.Name
			clone.Visible = true
			clone.Parent = Holder_upvr
			var10_upvw.new(Main.State):buttonUp(function() -- Line 77
				--[[ Upvalues[5]:
					[1]: var6_upvw (copied, read and write)
					[2]: var5_upvw (copied, read and write)
					[3]: var4_upvw (copied, read and write)
					[4]: v_upvr (readonly)
					[5]: var7_upvw (copied, read and write)
				]]
				if var6_upvw:getFFlag("trading") == false then
					var5_upvw:createMessagePopup({
						fFlagDisabled = true;
						reOpen = "TradeListFrame";
					})
				else
					if var4_upvw.data.hasTradesFrom[v_upvr.Name] then
						var7_upvw.acceptTrade:Fire(v_upvr.Name)
						return
					end
					var7_upvw.sendTradeRequest:Fire(v_upvr.Name)
				end
			end)
			var5_upvw:createInfoHoverOnGuiStateChange(Icon_upvr.Click, {
				hoverType = "tradeList";
				username = v_upvr.Name;
			})
		end
	end
end
function any_new_result1.removePlayer(arg1, arg2) -- Line 98
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	local SOME_5 = Holder_upvr:FindFirstChild(arg2.Name)
	if not SOME_5 then
	else
		SOME_5:Destroy()
	end
end
function any_new_result1.update(arg1, arg2) -- Line 107
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: Players_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var11_upvw (read and write)
	]]
	local data_3 = var4_upvw.data
	for i_2, v_2 in arg2 do
		local SOME_3_upvr = Players_upvr:FindFirstChild(i_2)
		if SOME_3_upvr then
			local SOME = Holder_upvr:FindFirstChild(i_2)
			local var50
			if SOME then
				local State = SOME.Main.State
				local var52_upvw = false
				local pcall_result1, pcall_result2_2 = pcall(function() -- Line 125
					--[[ Upvalues[3]:
						[1]: var52_upvw (read and write)
						[2]: LocalPlayer_upvr (copied, readonly)
						[3]: SOME_3_upvr (readonly)
					]]
					var52_upvw = LocalPlayer_upvr:IsFriendsWith(SOME_3_upvr.UserId)
				end)
				if not pcall_result1 then
					local errMsg = `Kunde inte få om '{i_2}' är vänner ({pcall_result2_2})`
					var11_upvw.print(errMsg, warn)
				end
			-- Fixed: INLINED_5/6/7/8 had side-effects on var50 during condition evaluation.
			-- The compound condition determined whether the Trade button shows.
			-- Reconstructed: can trade if not locked, not already trading, and
			-- either tradeSetting=1 (anyone) or tradeSetting=2 AND is friend,
			-- OR there's no pending sent request.
			local canTrade
			local notLocked = not v_2.tradesLocked
			local notTrading = not v_2.isTrading
			local anyoneSetting = v_2.tradeSetting == 1
			local friendSetting = v_2.tradeSetting == 2 and var52_upvw
			local noSentRequest = data_3.sentTradeRequests[i_2] == nil
			if (notLocked and notTrading and (anyoneSetting or friendSetting)) or noSentRequest then
				if data_3.hasTradesFrom[i_2] ~= nil then
					canTrade = false
				else
					canTrade = true
				end
			else
				canTrade = false
			end
			State.Trade.Visible = canTrade
			local sentVisible = data_3.sentTradeRequests[i_2]
			if sentVisible then
				sentVisible = not data_3.hasTradesFrom[i_2]
			end
			State.Sent.Visible = sentVisible
			State.InTrade.Visible = v_2.isTrading
			State.Accept.Visible = data_3.hasTradesFrom[i_2]
			if not v_2.tradesLocked then
				if v_2.tradeSetting ~= 3 then
					if v_2.tradeSetting == 2 then
					end
				end
			end
			State.Disabled.Visible = not var52_upvw
		end
		end
	end
end
function any_new_result1.sendUpdatePlayerList(arg1) -- Line 140
	--[[ Upvalues[1]:
		[1]: var7_upvw (read and write)
	]]
	if tick() - (arg1._playerListdebounce or 0) < 2 then
	else
		arg1._playerListdebounce = tick()
		var7_upvw.updatePlayerList:Fire()
	end
end
local Locked_upvr = Main_2:WaitForChild("Locked")
function any_new_result1.showTradesLocked(arg1) -- Line 150
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: List_upvr (readonly)
		[3]: Locked_upvr (readonly)
	]]
	local data_2 = var4_upvw.data
	List_upvr.Visible = not data_2.tradesLocked
	Locked_upvr.Visible = data_2.tradesLocked
end
function any_new_result1.opened(arg1) -- Line 157
	arg1:sendUpdatePlayerList()
	arg1:createPlayers()
	arg1:showTradesLocked()
end
function any_new_result1.Start(arg1) -- Line 163
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: Players_upvr (readonly)
	]]
	arg1:opened()
	var5_upvw:listenToOpen("TradeListFrame"):Connect(function() -- Line 165
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var7_upvw.updatePlayerList:Connect(function(...) -- Line 169
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update(...)
	end)
	Players_upvr.PlayerRemoving:Connect(function(...) -- Line 173
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:removePlayer(...)
	end)
end
function any_new_result1.Construct(arg1) -- Line 178
	--[[ Upvalues[8]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
	]]
	var7_upvw = Knit_upvr.GetService("TradeService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1