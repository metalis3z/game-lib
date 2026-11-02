-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OfflineEarningsServiceClient, time of decompilation: Sun May  3 10:12:11 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local Networker = require(ReplicatedStorage.Packages.Networker)
local OfflineEarningsSlice = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsSlice)
local TopBarHudState = require(ReplicatedStorage.Source.Features.Hud.TopBarHudState)
local OfflineEarningsServiceUtils = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	["No offline earnings to claim"] = true
}

return {
	_applyHiddenReward = function(_, p2) --[[ _applyHiddenReward ]] -- line: 68
		-- upvalues: OfflineEarningsServiceUtils (copy), TopBarHudState (copy)
		local v27 = OfflineEarningsServiceUtils.reconcileRewardData(p2)

		TopBarHudState.setHiddenAmount("coins", not v27 and 0 or v27.coins)
		TopBarHudState.setHiddenAmount("goop", not v27 and 0 or v27.goop)
	end,
	_openMenuIfNeeded = function(_, p4) --[[ _openMenuIfNeeded ]] -- line: 77
		-- upvalues: OfflineEarningsServiceUtils (copy), Menu (copy)
		if not OfflineEarningsServiceUtils.hasReward(p4) then
			return
		end

		if Menu.openedMenu() ~= "offlineEarningsMenu" then
			Menu.setOpenedMenu("offlineEarningsMenu", true)
		end
	end,
	init = function(p5) --[[ init ]] -- line: 90
		-- upvalues: Networker (copy), OfflineEarningsServiceUtils (copy), client (copy), OfflineEarningsSlice (copy)
		p5.networker = Networker.client.new("OfflineEarningsService", p5)
		p5.releaseToken = 0

		if p5.pendingRewardChangedConn then
			p5.pendingRewardChangedConn:Disconnect()
		end

		local v31 = OfflineEarningsServiceUtils.reconcileRewardData(client:get("offlineEarnings"))

		OfflineEarningsSlice.actions.setPendingReward(v31)
		p5.pendingRewardChangedConn = client:getChangedSignal("offlineEarnings"):Connect(function(p6) -- line: 100
			-- upvalues: OfflineEarningsServiceUtils (copy), OfflineEarningsSlice (copy), p5 (copy)
			local v54 = OfflineEarningsServiceUtils.reconcileRewardData(p6)

			OfflineEarningsSlice.actions.setPendingReward(v54)

			if v54 then
				p5:_applyHiddenReward(v54)
				p5:_openMenuIfNeeded(v54)
			end
		end)
		p5:_applyHiddenReward(v31)
		task.defer(function() -- line: 111
			-- upvalues: p5 (copy), v31 (copy)
			p5:_openMenuIfNeeded(v31)
		end)
	end,
	claim = function(p7) --[[ claim ]] -- line: 116
		-- upvalues: OfflineEarningsServiceUtils (copy), client (copy), Menu (copy), ErrorMessages (copy), t1 (copy), OfflineEarningsSlice (copy), TopBarHudState (copy)
		local v33 = OfflineEarningsServiceUtils.reconcileRewardData(client:get("offlineEarnings"))

		if p7.isReleasing then
			return true, nil, v33
		end

		if not v33 then
			if Menu.openedMenu() == "offlineEarningsMenu" then
				Menu.setOpenedMenu(nil)
			end

			return false, "No offline earnings to claim", nil
		end

		local v34, v35, v36 = p7.networker:fetch("requestClaim")

		if not v34 then
			if v35 == "No offline earnings to claim" then
				ErrorMessages.add("There aren't any offline earnings to claim right now.")
			else
				ErrorMessages.add(v35 or "Offline earnings couldn't be claimed.")
			end

			if not t1[v35] then
				warn("Failed to claim offline earnings:", v35)
			end

			return false, v35, nil
		end

		p7.isReleasing = true
		p7.releaseToken = p7.releaseToken + 1

		local releaseToken = p7.releaseToken
		local t2 = {}

		if v33.coins > 0 then
			local t3 = {
				currencyPath = "coins",
				amount = v33.coins
			}
			local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
			local v41

			if not PlayerGui then
				v41 = nil
			else
				local Root = PlayerGui:FindFirstChild("Root")

				v41 = if not Root or not Root:IsA("ScreenGui") then nil else Root
			end

			local v43

			if not v41 then
				v43 = nil
			else
				local CoinsCard = v41:FindFirstChild("CoinsCard", true)

				v43 = if not CoinsCard or (not CoinsCard:IsA("GuiObject") or not (CoinsCard.AbsoluteSize.Magnitude > 0)) then nil else CoinsCard.AbsolutePosition + CoinsCard.AbsoluteSize / 2
			end

			t3.startPosition = if not v43 then UDim2.fromScale(0.42, 0.47) else UDim2.fromOffset(v43.X, v43.Y)
			table.insert(t2, t3)
		end

		if v33.goop > 0 then
			local t4 = {
				currencyPath = "goop",
				amount = v33.goop
			}
			local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
			local v47

			if not PlayerGui then
				v47 = nil
			else
				local Root = PlayerGui:FindFirstChild("Root")

				v47 = if not Root or not Root:IsA("ScreenGui") then nil else Root
			end

			local v49

			if not v47 then
				v49 = nil
			else
				local GoopCard = v47:FindFirstChild("GoopCard", true)

				v49 = if not GoopCard or (not GoopCard:IsA("GuiObject") or not (GoopCard.AbsoluteSize.Magnitude > 0)) then nil else GoopCard.AbsolutePosition + GoopCard.AbsoluteSize / 2
			end

			t4.startPosition = if not v49 then UDim2.fromScale(0.58, 0.47) else UDim2.fromOffset(v49.X, v49.Y)
			table.insert(t2, t4)
		end

		if #t2 > 0 then
			OfflineEarningsSlice.actions.triggerBurst(t2)
		end

		OfflineEarningsSlice.actions.clearPendingReward()

		for _, v52 in t2 do
			task.delay(1, function() -- line: 170
				-- upvalues: p7 (copy), releaseToken (copy), TopBarHudState (copy), v52 (copy)
				if p7.releaseToken ~= releaseToken then
					return
				end

				TopBarHudState.consumeHiddenAmount(v52.currencyPath, v52.amount)
				TopBarHudState.notifyCurrencyCollected(v52.currencyPath, v52.amount)
			end)
		end

		task.delay(1.2, function() -- line: 179
			-- upvalues: p7 (copy), releaseToken (copy)
			if p7.releaseToken ~= releaseToken then
				return
			end

			p7.isReleasing = false
		end)

		if Menu.openedMenu() == "offlineEarningsMenu" then
			Menu.setOpenedMenu(nil)
		end

		return true, nil, v36 or v33
	end
}
