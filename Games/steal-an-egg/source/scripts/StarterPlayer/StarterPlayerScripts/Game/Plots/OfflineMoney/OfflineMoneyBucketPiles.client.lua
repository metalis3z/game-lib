-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ActiveAssetsController = require(script.Parent.Parent.ActiveAssetsController)
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local CurrencyItem = require(ReplicatedStorage.Library.Items.CurrencyItem)
local Currency = require(ReplicatedStorage.Library.Types.Currency)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Item = require(ReplicatedStorage.Library.Client.NotificationCmds.Item)
local OfflineAssets = require(ReplicatedStorage.Library.Types.OfflineAssets)
local ClaimVisual = require(script.ClaimVisual)
local Player = require(ReplicatedStorage.Library.Player)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local OfflineAssets2 = Network.NET_MAP.OfflineAssets
local MIN_CLAIM_MONEY = Constants.OFFLINE_ASSETS.MIN_CLAIM_MONEY
local Money = Currency.AllCurrencyTypes.Money
local LocalPlayer = Players.LocalPlayer
local v1 = nil
local v2 = 0
local v3 = nil
local t = {}

local function readSummary(p1) --[[ readSummary | Line: 54 | Upvalues: OfflineAssets (copy) ]]
	if OfflineAssets.OfflineClaimSummary(p1) then
		return p1
	end

	return nil
end

local function readRedeemResult(p1) --[[ readRedeemResult | Line: 62 | Upvalues: OfflineAssets (copy) ]]
	if OfflineAssets.OfflineRedeemResult(p1) then
		return p1
	end

	return nil
end

local function hasReadiness() --[[ hasReadiness | Line: 70 | Upvalues: Save (copy) ]]
	return Save.IsLocalDataLoaded()
end

local function currentClaimAmount() --[[ currentClaimAmount | Line: 74 | Upvalues: v1 (ref), MIN_CLAIM_MONEY (copy) ]]
	local v12 = v1
	local v2 = if v12 then math.max(v12.TotalAmount, 0) else 0

	if MIN_CLAIM_MONEY <= v2 then
		return v2
	end

	return 0
end

local function clearSession(p1) --[[ clearSession | Line: 80 | Upvalues: v3 (ref) ]]
	local v1 = v3

	if p1 ~= nil and v1 ~= p1 then
		return
	end

	v3 = nil

	if not v1 then
		return
	end

	v1.trove:Destroy()
end

local function feetInsideSession(p1) --[[ feetInsideSession | Line: 93 | Upvalues: Player (copy), LocalPlayer (copy) ]]
	local v1 = Player.Optional.FeetCFrame(LocalPlayer)

	return if v1 == nil then false else p1.visual:ContainsWorldPosition(v1.Position)
end

local function requestSummary() --[[ requestSummary | Line: 98 | Upvalues: v2 (ref), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), v1 (ref), t (copy) ]]
	v2 = v2 + 1

	local v12 = v2

	task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v12 (copy), v2 (ref), v1 (ref), t (ref) ]]
		local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
		local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

		if v12 ~= v2 then
			return
		end

		if not v22 then
			t.Sync()

			return
		end

		v1 = v22
		t.Sync()
	end)
end

local function showOfflineMoneyNotification(p1) --[[ showOfflineMoneyNotification | Line: 114 | Upvalues: CurrencyItem (copy), Money (copy), Item (copy) ]]
	if not (p1 <= 0) then
		Item.Bottom({
			Item = CurrencyItem(Money):SetAmount((math.round(p1)))
		})
	end
end

local function claim(p1) --[[ claim | Line: 125 | Upvalues: v1 (ref), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), CurrencyItem (copy), Money (copy), Item (copy), v3 (ref), v2 (ref), t (copy) ]]
	if not (p1.amount <= 0) then
		p1.claimLock(function() --[[ Line: 130 | Upvalues: v1 (ref), p1 (copy), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
			v1 = {
				ClaimableAmount = 0,
				ReservedAmount = 0,
				TotalAmount = 0,
				IsMultiplierPurchasePending = false
			}
			p1.visual:PlayClaim()

			local v122, _, v22 = Network.Invoke(OfflineAssets2.REQUEST_REDEEM, {
				Kind = "Claim"
			})
			local v32 = if OfflineAssets.OfflineRedeemResult(v22) then v22 else nil

			if v122 ~= true or v32 == nil then
				v2 = v2 + 1

				local v4 = v2

				task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v4 (copy), v2 (ref), v1 (ref), t (ref) ]]
					local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
					local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

					if v4 ~= v2 then
						return
					end

					if not v22 then
						t.Sync()

						return
					end

					v1 = v22
					t.Sync()
				end)

				return
			end

			local AwardedAmount = v32.AwardedAmount

			if not (AwardedAmount <= 0) then
				Item.Bottom({
					Item = CurrencyItem(Money):SetAmount((math.round(AwardedAmount)))
				})
			end

			local v6 = p1
			local v7 = v3

			if v6 ~= nil and v7 ~= v6 then
				return
			end

			v3 = nil

			if not v7 then
				return
			end

			v7.trove:Destroy()
		end)
	end
end

local function updateClaimEntry(p1) --[[ updateClaimEntry | Line: 154 | Upvalues: Player (copy), LocalPlayer (copy), v1 (ref), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), CurrencyItem (copy), Money (copy), Item (copy), v3 (ref), v2 (ref), t (copy) ]]
	local v12 = Player.Optional.FeetCFrame(LocalPlayer)
	local v22 = if v12 == nil then false else p1.visual:ContainsWorldPosition(v12.Position)
	local feetInside = p1.feetInside

	p1.feetInside = v22
	p1.visual:SetBillboardEnabled(not v22)

	if not v22 or feetInside then
		return
	end

	if p1.amount <= 0 then
		return
	end

	p1.claimLock(function() --[[ Line: 130 | Upvalues: v1 (ref), p1 (copy), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
		v1 = {
			ClaimableAmount = 0,
			ReservedAmount = 0,
			TotalAmount = 0,
			IsMultiplierPurchasePending = false
		}
		p1.visual:PlayClaim()

		local v122, _, v22 = Network.Invoke(OfflineAssets2.REQUEST_REDEEM, {
			Kind = "Claim"
		})
		local v32 = if OfflineAssets.OfflineRedeemResult(v22) then v22 else nil

		if v122 ~= true or v32 == nil then
			v2 = v2 + 1

			local v4 = v2

			task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v4 (copy), v2 (ref), v1 (ref), t (ref) ]]
				local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
				local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

				if v4 ~= v2 then
					return
				end

				if not v22 then
					t.Sync()

					return
				end

				v1 = v22
				t.Sync()
			end)

			return
		end

		local AwardedAmount = v32.AwardedAmount

		if not (AwardedAmount <= 0) then
			Item.Bottom({
				Item = CurrencyItem(Money):SetAmount((math.round(AwardedAmount)))
			})
		end

		local v6 = p1
		local v7 = v3

		if v6 ~= nil and v7 ~= v6 then
			return
		end

		v3 = nil

		if not v7 then
			return
		end

		v7.trove:Destroy()
	end)
end

local function sessionFor(p1, p2, p3) --[[ sessionFor | Line: 165 | Upvalues: Trove (copy), ClaimVisual (copy), Lock (copy), RunService (copy), Player (copy), LocalPlayer (copy), v1 (ref), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), CurrencyItem (copy), Money (copy), Item (copy), v3 (ref), v2 (ref), t (copy) ]]
	local v12 = Trove.new()
	local v22 = ClaimVisual.new(p1, p2, p3)
	local t2 = {
		feetInside = false,
		trove = v12,
		amount = p1,
		visual = v22,
		claimLock = Lock()
	}

	v12:Add(function() --[[ Line: 176 | Upvalues: v22 (copy) ]]
		v22:Destroy()
	end)
	v12:Add(RunService.Heartbeat:Connect(function() --[[ Line: 179 | Upvalues: t2 (copy), Player (ref), LocalPlayer (ref), v1 (ref), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
		local v12 = t2
		local v22 = Player.Optional.FeetCFrame(LocalPlayer)
		local v32 = if v22 == nil then false else v12.visual:ContainsWorldPosition(v22.Position)
		local feetInside = v12.feetInside

		v12.feetInside = v32
		v12.visual:SetBillboardEnabled(not v32)

		if not v32 or feetInside then
			return
		end

		if v12.amount <= 0 then
			return
		end

		v12.claimLock(function() --[[ Line: 130 | Upvalues: v1 (ref), v12 (copy), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
			v1 = {
				ClaimableAmount = 0,
				ReservedAmount = 0,
				TotalAmount = 0,
				IsMultiplierPurchasePending = false
			}
			v12.visual:PlayClaim()

			local v122, _, v22 = Network.Invoke(OfflineAssets2.REQUEST_REDEEM, {
				Kind = "Claim"
			})
			local v32 = if OfflineAssets.OfflineRedeemResult(v22) then v22 else nil

			if v122 ~= true or v32 == nil then
				v2 = v2 + 1

				local v4 = v2

				task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v4 (copy), v2 (ref), v1 (ref), t (ref) ]]
					local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
					local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

					if v4 ~= v2 then
						return
					end

					if not v22 then
						t.Sync()

						return
					end

					v1 = v22
					t.Sync()
				end)

				return
			end

			local AwardedAmount = v32.AwardedAmount

			if not (AwardedAmount <= 0) then
				Item.Bottom({
					Item = CurrencyItem(Money):SetAmount((math.round(AwardedAmount)))
				})
			end

			local v6 = v12
			local v7 = v3

			if v6 ~= nil and v7 ~= v6 then
				return
			end

			v3 = nil

			if not v7 then
				return
			end

			v7.trove:Destroy()
		end)
	end))

	return t2
end

local function tryInitialize() --[[ tryInitialize | Line: 186 | Upvalues: Save (copy), v2 (ref), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), v1 (ref), t (copy) ]]
	if Save.IsLocalDataLoaded() then
		v2 = v2 + 1

		local v12 = v2

		task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v12 (copy), v2 (ref), v1 (ref), t (ref) ]]
			local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
			local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

			if v12 ~= v2 then
				return
			end

			if not v22 then
				t.Sync()

				return
			end

			v1 = v22
			t.Sync()
		end)
		t.Sync()
	end
end

function t.Sync() --[[ Sync | Line: 199 | Upvalues: Save (copy), v1 (ref), MIN_CLAIM_MONEY (copy), v3 (ref), AssetCmds (copy), LocalPlayer (copy), PlotCmds (copy), sessionFor (copy), Player (copy), Network (copy), OfflineAssets2 (copy), OfflineAssets (copy), CurrencyItem (copy), Money (copy), Item (copy), v2 (ref), t (copy) ]]
	if not Save.IsLocalDataLoaded() then
		return
	end

	local v12 = v1
	local v22 = if v12 then math.max(v12.TotalAmount, 0) else 0
	local v32 = if MIN_CLAIM_MONEY <= v22 then v22 else 0

	if v32 <= 0 then
		local v4 = v3

		v3 = nil

		if not v4 then
			return
		end

		v4.trove:Destroy()
	else
		local v5 = AssetCmds.ResolveAssetArea(LocalPlayer)

		if v5 == nil then
			local v6 = v3

			v3 = nil

			if not v6 then
				return
			end

			v6.trove:Destroy()
		else
			local v7 = PlotCmds.GetPlotData()
			local v8 = if v7 then v7.PlotFolder else workspace
			local v9 = v3

			if v9 == nil then
				local v10 = sessionFor(v32, v5, v8)

				v3 = v10

				local v11 = Player.Optional.FeetCFrame(LocalPlayer)
				local v122 = if v11 == nil then false else v10.visual:ContainsWorldPosition(v11.Position)
				local feetInside = v10.feetInside

				v10.feetInside = v122
				v10.visual:SetBillboardEnabled(not v122)

				if not v122 or feetInside then
					return
				end

				if v10.amount <= 0 then
					return
				end

				v10.claimLock(function() --[[ Line: 130 | Upvalues: v1 (ref), v10 (copy), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
					v1 = {
						ClaimableAmount = 0,
						ReservedAmount = 0,
						TotalAmount = 0,
						IsMultiplierPurchasePending = false
					}
					v10.visual:PlayClaim()

					local v122, _, v22 = Network.Invoke(OfflineAssets2.REQUEST_REDEEM, {
						Kind = "Claim"
					})
					local v32 = if OfflineAssets.OfflineRedeemResult(v22) then v22 else nil

					if v122 ~= true or v32 == nil then
						v2 = v2 + 1

						local v4 = v2

						task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v4 (copy), v2 (ref), v1 (ref), t (ref) ]]
							local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
							local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

							if v4 ~= v2 then
								return
							end

							if not v22 then
								t.Sync()

								return
							end

							v1 = v22
							t.Sync()
						end)

						return
					end

					local AwardedAmount = v32.AwardedAmount

					if not (AwardedAmount <= 0) then
						Item.Bottom({
							Item = CurrencyItem(Money):SetAmount((math.round(AwardedAmount)))
						})
					end

					local v6 = v10
					local v7 = v3

					if v6 ~= nil and v7 ~= v6 then
						return
					end

					v3 = nil

					if not v7 then
						return
					end

					v7.trove:Destroy()
				end)
			else
				v9.amount = v32
				v9.visual:Update(v32, v5)

				local v14 = Player.Optional.FeetCFrame(LocalPlayer)
				local v15 = if v14 == nil then false else v9.visual:ContainsWorldPosition(v14.Position)
				local feetInside = v9.feetInside

				v9.feetInside = v15
				v9.visual:SetBillboardEnabled(not v15)

				if not v15 or feetInside then
					return
				end

				if v9.amount <= 0 then
					return
				end

				v9.claimLock(function() --[[ Line: 130 | Upvalues: v1 (ref), v9 (copy), Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), CurrencyItem (ref), Money (ref), Item (ref), v3 (ref), v2 (ref), t (ref) ]]
					v1 = {
						ClaimableAmount = 0,
						ReservedAmount = 0,
						TotalAmount = 0,
						IsMultiplierPurchasePending = false
					}
					v9.visual:PlayClaim()

					local v122, _, v22 = Network.Invoke(OfflineAssets2.REQUEST_REDEEM, {
						Kind = "Claim"
					})
					local v32 = if OfflineAssets.OfflineRedeemResult(v22) then v22 else nil

					if v122 ~= true or v32 == nil then
						v2 = v2 + 1

						local v4 = v2

						task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v4 (copy), v2 (ref), v1 (ref), t (ref) ]]
							local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
							local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

							if v4 ~= v2 then
								return
							end

							if not v22 then
								t.Sync()

								return
							end

							v1 = v22
							t.Sync()
						end)

						return
					end

					local AwardedAmount = v32.AwardedAmount

					if not (AwardedAmount <= 0) then
						Item.Bottom({
							Item = CurrencyItem(Money):SetAmount((math.round(AwardedAmount)))
						})
					end

					local v6 = v9
					local v7 = v3

					if v6 ~= nil and v7 ~= v6 then
						return
					end

					v3 = nil

					if not v7 then
						return
					end

					v7.trove:Destroy()
				end)
			end
		end
	end
end
Network.Fired(OfflineAssets2.SUMMARY_UPDATED):Connect(function(p1) --[[ Line: 235 | Upvalues: OfflineAssets (copy), v1 (ref), t (copy) ]]
	local v12 = if OfflineAssets.OfflineClaimSummary(p1) then p1 else nil

	if not v12 then
		return
	end

	v1 = v12
	t.Sync()
end)
Network.Fired(OfflineAssets2.CLAIMED_EVENT):Connect(function(p1) --[[ Line: 243 | Upvalues: OfflineAssets (copy), v3 (ref), v2 (ref), Network (copy), OfflineAssets2 (copy), v1 (ref), t (copy) ]]
	local v12 = if OfflineAssets.OfflineRedeemResult(p1) then p1 else nil

	if not v12 then
		return
	end

	local v22 = v3

	v3 = nil

	if v22 then
		v22.trove:Destroy()
	end

	v2 = v2 + 1

	local v32 = v2

	task.spawn(function() --[[ Line: 102 | Upvalues: Network (ref), OfflineAssets2 (ref), OfflineAssets (ref), v32 (copy), v2 (ref), v1 (ref), t (ref) ]]
		local v13 = Network.Invoke(OfflineAssets2.GET_SUMMARY)
		local v22 = if OfflineAssets.OfflineClaimSummary(v13) then v13 else nil

		if v32 ~= v2 then
			return
		end

		if not v22 then
			t.Sync()

			return
		end

		v1 = v22
		t.Sync()
	end)
end)
AssetCmds.AssetAreaAvailabilityChanged:Connect(function(p1) --[[ Line: 250 | Upvalues: LocalPlayer (copy), t (copy) ]]
	if p1 ~= LocalPlayer then
		return
	end

	t.Sync()
end)
PlotCmds.OnLocalPlotUpdated:Connect(t.Sync)
ActiveAssetsController.ItemAdded:Connect(requestSummary)
ActiveAssetsController.ItemRemoved:Connect(requestSummary)
ActiveAssetsController.CashCollected:Connect(requestSummary)
ActiveAssetsController.InitialLoadCompleted:Connect(tryInitialize)
Save.LoadedStats:Connect(tryInitialize)
task.defer(tryInitialize)