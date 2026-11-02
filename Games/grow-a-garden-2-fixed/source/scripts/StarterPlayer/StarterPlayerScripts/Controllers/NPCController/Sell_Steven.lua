--credit to prince games studio
local Steven = workspace:WaitForChild("NPCS"):WaitForChild("Steven")
local ProximityPrompt = Steven:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt")
local v1 = require("../NPCDialogueController")
local TopText = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("TopText"))
local SellValueData = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("SellValueData"))
local FruitValueCalc = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"))

require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("MutationData"))

local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local BidOddModule = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("BidOddModule"))
local NumberUtils = require(game.ReplicatedStorage.SharedModules.NumberUtils)
local RunService = game:GetService("RunService")
local HarvestedFruitHandleController = require(script.Parent.Parent.HarvestedFruitHandleController)
local RadialFXController = require(script.Parent.Parent.RadialFXController)

require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler)

local ABTests = require(game:GetService("ReplicatedStorage").UserGenerated.ABTests)
local Animations = Steven:WaitForChild("Animations")
local Success = Animations:WaitForChild("Success")
local Idle = Animations:WaitForChild("Idle")

Animations:WaitForChild("Interact")

local Fail = Animations:WaitForChild("Fail")
local Buy = Animations:WaitForChild("Buy")
local PetData = require(game.ReplicatedStorage.SharedData.PetData)
local BargainSFX = game.SoundService.SFX.BargainSFX
local SellSFX = game.SoundService.SFX.SellSFX
local Normal = SellSFX.Normal
local Rainbow = SellSFX.Rainbow
local Accept = BargainSFX.Accept
local Decline = BargainSFX.Decline
local Animator = Steven:WaitForChild("Humanoid"):WaitForChild("Animator")
local v2 = Animator:LoadAnimation(Success)
local v3 = Animator:LoadAnimation(Idle)
local v4 = Animator:LoadAnimation(Fail)
local v5 = Animator:LoadAnimation(Buy)

v3:Play(0.1, 3, 1)

local DevProductController = require(script.Parent.Parent.DevProductController)
local NotificationController = require(script.Parent.Parent.NotificationController)
local v6 = 0

local function PromptSkipCooldown() --[[ PromptSkipCooldown | Line: 68 | Upvalues: DevProductController (copy) ]]
	local v1 = false
	local v2 = false
	local v3 = DevProductController.PurchaseComplete:Connect(function(p1) --[[ Line: 72 | Upvalues: v2 (ref), v1 (ref) ]]
		if p1 ~= "Standalone:Skip Cooldown:1" then
			return
		end

		v2 = true
		v1 = true
	end)
	local v4 = DevProductController.PurchaseFailed:Connect(function(p1, p2) --[[ Line: 75 | Upvalues: v1 (ref) ]]
		if p1 ~= "Standalone:Skip Cooldown:1" then
			return
		end

		v1 = true
	end)
	local v5 = DevProductController.PurchaseCancelled:Connect(function(p1) --[[ Line: 78 | Upvalues: v1 (ref) ]]
		if p1 ~= "Standalone:Skip Cooldown:1" then
			return
		end

		v1 = true
	end)
	local v6, v7 = DevProductController:PromptPurchase("Standalone:Skip Cooldown:1")

	if v6 then
		if v7 ~= "Prompted Robux" and not v1 then
			v2 = true
			v1 = true
		end
	else
		v1 = true
	end

	local v8 = os.clock()

	while not v1 and os.clock() - v8 < 60 do
		task.wait(0.1)
	end

	v3:Disconnect()
	v4:Disconnect()
	v5:Disconnect()

	return v2
end

local function PlayStevenLegendaryParticles() --[[ PlayStevenLegendaryParticles | Line: 105 | Upvalues: Steven (copy) ]]
	local HumanoidRootPart = Steven:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	for v1, v2 in HumanoidRootPart:GetDescendants() do
		if v2:IsA("ParticleEmitter") then
			local v3 = v2:GetAttribute("EmitCount")

			if v3 and v3 > 0 then
				v2:Emit(v3)
			end
		end
	end
end

Networking.NPCS.LegendaryFx.OnClientEvent:Connect(PlayStevenLegendaryParticles)

local function Coins(p1) --[[ Coins | Line: 126 | Upvalues: NumberUtils (copy) ]]
	return NumberUtils.Abbreviate(p1) .. "\194\162"
end

local function WaitForChoice(p1, p2) --[[ WaitForChoice | Line: 130 | Upvalues: TopText (copy) ]]
	local v1 = TopText.ShowChoices(p1, p2)
	local v2 = nil
	local t = {}

	if #v1 == 0 then
		return nil, "__DISMISSED__"
	end

	local function AnyChoiceAlive() --[[ AnyChoiceAlive | Line: 139 | Upvalues: v1 (copy) ]]
		for v12, v2 in v1 do
			if v2 and v2.Parent then
				return true
			end
		end

		return false
	end

	for v3, v4 in v1 do
		local Frame = v4:FindFirstChild("Frame")

		if Frame then
			local ImageButton = Frame:FindFirstChild("ImageButton")

			if ImageButton then
				table.insert(t, ImageButton.MouseButton1Click:Connect(function() --[[ Line: 153 | Upvalues: v2 (ref), v3 (copy) ]]
					v2 = v3
				end))
			end
		end
	end

	local v5 = TopText.ConnectChoiceKeyboard(v1, function(p1) --[[ Line: 159 | Upvalues: v2 (ref) ]]
		if v2 ~= nil then
			return
		end

		v2 = p1
	end)

	while v2 == nil do
		local v6 = false

		for v7, v8 in v1 do
			if v8 and v8.Parent then
				v6 = true

				break
			end
		end

		if v6 then
			task.wait(0.05)
		else
			for v9, v10 in t do
				v10:Disconnect()
			end

			v5()

			return nil, "__DISMISSED__"
		end
	end

	for v11, v12 in t do
		v12:Disconnect()
	end

	v5()
	TopText.RemovePlayerSideFrame(p1)

	if p1.Character then
		TopText.PlayerResponse(p1.Character, p2[v2], true)
	end

	return v2, p2[v2]
end

local function WaitForChoiceWithCooldown(p1, p2, p3, p4, p5, p6) --[[ WaitForChoiceWithCooldown | Line: 187 | Upvalues: TopText (copy) ]]
	local v1 = if os.clock() < p4 then true else false
	local v2 = nil
	local t = {}
	local v3 = table.clone(p2)

	if v1 then
		v3[p3] = string.format("%s <font color=\"#888888\">[%.1fs]</font>", p2[p3], (math.max(0, p4 - os.clock())))
	end

	local v6 = TopText.ShowChoices(p1, v3)

	if #v6 == 0 then
		return nil, "__DISMISSED__"
	end

	local function AnyChoiceAlive() --[[ AnyChoiceAlive | Line: 206 | Upvalues: v6 (copy) ]]
		for v1, v2 in v6 do
			if v2 and v2.Parent then
				return true
			end
		end

		return false
	end

	local v7 = nil

	if v1 then
		local v8 = v6[p3]
		local v9 = v8 and v8:FindFirstChild("Frame")
		local v10 = if v9 then v9:FindFirstChild("Frame") else v9
		local v12 = if v10 then v10:FindFirstChild("Text_Element") else v10

		if v12 and v12:IsA("TextLabel") then
			v7 = task.spawn(function() --[[ Line: 225 | Upvalues: v2 (ref), v6 (copy), p4 (copy), v12 (ref), p2 (copy), p3 (copy), p6 (copy) ]]
				while v2 == nil do
					local v1 = false

					for v22, v3 in v6 do
						if v3 and v3.Parent then
							v1 = true

							break
						end
					end

					if not v1 then
						break
					end

					local v4 = p4 - os.clock()

					if v4 <= 0 then
						v12.Text = "[\"" .. p2[p3] .. "\"]"

						if not p6 then
							break
						end

						local v5 = v6[p6]

						if v5 then
							v5:Destroy()

							return
						end

						break
					end

					v12.Text = string.format("[\"%s <font color=\"#888888\">[%.1fs]</font>\"]", p2[p3], v4)
					task.wait(0.1)
				end
			end)
		end
	end

	local t2 = {}

	if p5 then
		for k, v in pairs(p5) do
			local v13 = v6[k]

			if v13 then
				local Frame = v13:FindFirstChild("Frame")
				local v14 = if Frame then Frame:FindFirstChild("Frame") else Frame
				local v15 = v14 and v14:FindFirstChild("Text_Element")

				if v15 then
					local function f17() --[[ Line: 261 | Upvalues: v2 (ref), v6 (copy), v15 (copy), v (copy), TopText (ref) ]]
						local sum = 0

						while v2 == nil do
							local v1 = false

							for v22, v3 in v6 do
								if v3 and v3.Parent then
									v1 = true

									break
								end
							end

							if not v1 then
								break
							end

							sum = sum + task.wait(0.04)

							if not (v15 and v15.Parent) then
								break
							end

							v15.Text = "[\"" .. v.before .. TopText.BuildRainbowText(v.colored, sum) .. v.after .. "\"]"
						end
					end

					table.insert(t2, task.spawn(f17))
				end
			end
		end
	end

	for i, v in ipairs(v6) do
		local Frame = v:FindFirstChild("Frame")

		if Frame then
			local ImageButton = Frame:FindFirstChild("ImageButton")

			if ImageButton then
				table.insert(t, ImageButton.MouseButton1Click:Connect(function() --[[ Line: 279 | Upvalues: v2 (ref), i (copy) ]]
					v2 = i
				end))
			end
		end
	end

	local v18 = TopText.ConnectChoiceKeyboard(v6, function(p1) --[[ Line: 288 | Upvalues: v2 (ref) ]]
		if v2 ~= nil then
			return
		end

		v2 = p1
	end)

	local function Cleanup() --[[ Cleanup | Line: 294 | Upvalues: v7 (ref), t (copy), t2 (copy), v18 (copy) ]]
		if v7 then
			task.cancel(v7)
		end

		for v1, v2 in t do
			v2:Disconnect()
		end

		for v3, v4 in t2 do
			task.cancel(v4)
		end

		v18()
	end

	while v2 == nil do
		local v19 = false

		for v20, v21 in v6 do
			if v21 and v21.Parent then
				v19 = true

				break
			end
		end

		if not v19 then
			Cleanup()

			return nil, "__DISMISSED__"
		end

		task.wait(0.05)
	end

	Cleanup()
	TopText.RemovePlayerSideFrame(p1)

	if v1 and (v2 == p3 and os.clock() < p4) then
		return p3, "__COOLDOWN__"
	end

	if p6 and v2 == p6 then
		return v2, p2[v2]
	end

	local v22 = p2[v2]

	if p1.Character then
		TopText.PlayerResponse(p1.Character, v22, true)
	end

	return v2, v22
end

local function IsPlayerNearSteven(p1) --[[ IsPlayerNearSteven | Line: 328 | Upvalues: Steven (copy) ]]
	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local HumanoidRootPart = Steven:FindFirstChild("HumanoidRootPart")

	if not (v1 and HumanoidRootPart) then
		return false
	end

	return (v1.Position - HumanoidRootPart.Position).Magnitude <= 15
end

local function GetHeldFruitInfo(p1) --[[ GetHeldFruitInfo | Line: 336 | Upvalues: SellValueData (copy), FruitValueCalc (copy) ]]
	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Tool") else Character

	if not v1 then
		return nil, "You aren\'t holding anything!"
	end

	if v1:GetAttribute("PottedPlant") == true then
		local t = { "I don\'t buy potted plants, just the fruits!", "I only want harvested fruits, not the whole plant." }

		return nil, t[math.random(#t)]
	end

	local v2 = v1:GetAttribute("FruitName")

	if v2 then
		local v3 = v1:GetAttribute("Id")

		if not v3 then
			return nil, "I can\'t tell what that is.."
		end

		if SellValueData[v2] then
			local v4 = v1:GetAttribute("DecayAlpha")

			return {
				Tool = v1,
				FruitName = v2,
				FruitId = v3,
				BaseValue = FruitValueCalc(v2, v1:GetAttribute("SizeMultiplier"), v1:GetAttribute("Mutation"), p1, v4),
				DecayAlpha = v4
			}
		end

		return nil, "I\'ve never seen that before"
	end

	if v1:GetAttribute("Pet") then
		return "Pet", {
			PetID = v1:GetAttribute("PetId"),
			Tool = v1,
			PetName = v1:GetAttribute("Pet")
		}
	end

	if v1.Name == "Shovel" then
		local t = { "I don\'t want your shovel.", "Bring me a fruit, not a shovel..", "I only want plants!" }

		return nil, t[math.random(#t)]
	end

	local t = { "That isn\'t a plant..", "What am I meant to do with that?", "Plants only, please.." }

	return nil, t[math.random(#t)]
end

local function DestroyAllFruitTools(p1) --[[ DestroyAllFruitTools | Line: 388 | Upvalues: RunService (copy) ]]
	local v1 = p1.Character and p1.Character:FindFirstChildOfClass("Tool")

	if v1 and v1:GetAttribute("FruitName") then
		v1:Destroy()
	end

	local Backpack = p1:FindFirstChild("Backpack")

	if not Backpack then
		return
	end

	local t = {}

	for v2, v3 in Backpack:GetChildren() do
		if v3:IsA("Tool") and v3:GetAttribute("FruitName") then
			table.insert(t, v3)
		end
	end

	if not (#t > 0) then
		return
	end

	task.spawn(function() --[[ Line: 402 | Upvalues: t (copy), RunService (ref) ]]
		local v1 = 1

		while v1 <= #t do
			local v3 = math.min(#t, v1 + 100 - 1)

			for i = v1, v3 do
				local v4 = t[i]

				if v4 and v4.Parent then
					v4:Destroy()
				end
			end

			RunService.Heartbeat:Wait()
			v1 = v3 + 1
		end
	end)
end

local function SafeDestroyTool(p1) --[[ SafeDestroyTool | Line: 421 ]]
	if not (p1 and p1.Parent) then
		return
	end

	p1:Destroy()
end

local function RunInventoryBargainLoop(p1, p2, p3) --[[ RunInventoryBargainLoop | Line: 433 | Upvalues: Networking (copy), TopText (copy), Steven (copy), v6 (ref), BidOddModule (copy), v2 (copy), Accept (copy), RadialFXController (copy), NumberUtils (copy), Decline (copy), v4 (copy), WaitForChoiceWithCooldown (copy), NotificationController (copy), PromptSkipCooldown (copy), HarvestedFruitHandleController (copy), v5 (copy), Rainbow (copy), Coins (copy), Normal (copy) ]]
	local v1 = Networking.NPCS.CheckDailyDeal:Fire()
	local v22 = if v1 then v1.Available else v1
	local v3 = p2.TotalValue * 5

	TopText.NpcText(Steven, "Let me reconsider everything...", true)
	task.wait(0.5)

	local v42 = Networking.NPCS.AskBidAll:Fire()

	if v42 and v42.Success then
		local NewTotalOffer = v42.NewTotalOffer

		v6 = os.clock() + BidOddModule.BID_COOLDOWN

		local v52

		if (v42.IncreasedCount or 0) > 0 then
			v2:Play(0.2, 10, 1)

			if v42.HadLegendary then
				local t = {
					{ "LEGENDARY " .. string.upper(p1.DisplayName) .. "! I offer you... ", "!" }
				}

				Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Accept.TimePosition = 0
				Accept.Playing = true
				RadialFXController:PlayFX("Rainbow")

				local v62 = t[math.random(#t)]

				TopText.RainbowNpcText(Steven, v62[1], NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162", v62[2], true)
				task.wait(1)
				v52 = true
			else
				Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Accept.TimePosition = 0
				Accept.Playing = true
				RadialFXController:PlayFX("Green")
				TopText.NpcText(Steven, string.format("I can do <font color=\'#00FF00\'>%s</font> now. %d higher, %d unchanged.", NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162", v42.IncreasedCount or 0, v42.SameCount or 0), true)
				task.wait(1)
				v52 = false
			end
		else
			v52 = false
			RadialFXController:PlayFX("Red")

			local v7 = if v42.RefusedAll then "No deal. I\'m not raising any of these right now." else "Still <font color=\'#FFFF00\'>%s</font>. Nothing went higher this time."

			TopText.NpcText(Steven, if v42.RefusedAll and v7 then v7 else string.format(v7, NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162"), true)
			Decline.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Decline.Playing = true
			v4:Play(0.2, 10, 1)
			task.wait(1)
		end

		while true do
			local v10
			local v13 = string.format("Ask for more <font color=\"#FF4444\">[COST: %s]</font>", NumberUtils.Abbreviate((math.floor(NewTotalOffer * (BidOddModule.CostMultiplier - 1)))) .. "\194\162")
			local t = { v52 and string.format("Deal [SELL: %s]", NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162") or string.format("Deal <font color=\"#FFFF00\">[SELL: %s]</font>", NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162"), v13 }
			local v15 = nil
			local v16 = nil
			local v17 = if os.clock() < v6 then true else false

			if v17 then
				v15 = #t
			end

			if v22 then
				local format = string.format

				table.insert(t, format("Daily Deal [SELL: %s]", NumberUtils.Abbreviate(v3) .. "\194\162"))
				v16 = #t
			end

			table.insert(t, "Nevermind")

			local t2 = {}

			if v52 then
				t2[1] = {
					before = "Deal ",
					after = "",
					colored = "[SELL: " .. (NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162") .. "]"
				}
			end

			if v22 and v16 then
				t2[v16] = {
					before = "Daily Deal ",
					after = "",
					colored = "[SELL: " .. (NumberUtils.Abbreviate(v3) .. "\194\162") .. "]"
				}
			end

			if next(t2) == nil then
				t2 = nil
			end

			local v19, v20 = WaitForChoiceWithCooldown(p1, t, 2, v6, t2, v15)

			if v20 == "__COOLDOWN__" then
				NotificationController:CreateNotification(("Please wait %*s"):format((math.ceil((math.max(0, v6 - os.clock()))))), false, 2)
			else
				if v15 and v19 == v15 then
					if PromptSkipCooldown() then
						v6 = 0
					end

					task.wait(0.3)

					continue
				end

				if v20 == "__DISMISSED__" then
					task.wait(0.2)

					return
				end

				if v19 == 2 then
					task.wait(0.5)
					TopText.NpcText(Steven, "Let me reconsider everything...", true)
					task.wait(0.5)

					local v23 = Networking.NPCS.AskBidAll:Fire()

					if v23 and v23.Success then
						NewTotalOffer = v23.NewTotalOffer
						v6 = os.clock() + BidOddModule.BID_COOLDOWN

						if (v23.IncreasedCount or 0) > 0 then
							v2:Play(0.2, 10, 1)

							if v23.HadLegendary then
								local t3 = {
									{ "LEGENDARY " .. string.upper(p1.DisplayName) .. "! I offer you... ", "!" }
								}

								Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Accept.TimePosition = 0
								Accept.Playing = true
								RadialFXController:PlayFX("Rainbow")

								local v24 = t3[math.random(#t3)]

								TopText.RainbowNpcText(Steven, v24[1], NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162", v24[2], true)
								task.wait(1)
								v52 = true

								continue
							end

							Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
							Accept.TimePosition = 0
							Accept.Playing = true
							RadialFXController:PlayFX("Green")
							TopText.NpcText(Steven, string.format("I can do <font color=\'#00FF00\'>%s</font> now. %d higher, %d unchanged.", NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162", v23.IncreasedCount or 0, v23.SameCount or 0), true)
							task.wait(1)
							v52 = false
						else
							v52 = false
							RadialFXController:PlayFX("Red")

							local v25 = if v23.RefusedAll then "No deal. I\'m not raising any of these right now." else "Still <font color=\'#FFFF00\'>%s</font>. Nothing went higher this time."

							v10 = if v23.RefusedAll and v25 then v25 else string.format(v25, NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162")
							TopText.NpcText(Steven, v10, true)
							Decline.PlaybackSpeed = 1 + math.random(-15, 15) / 100
							Decline.Playing = true
							v4:Play(0.2, 10, 1)
							task.wait(1)
						end

						continue
					end

					if v23 and v23.Reason == "Cooldown" then
						TopText.NpcText(Steven, string.format("Slow down! Ask me again in %d seconds.", v23.Remaining), true)
						v6 = os.clock() + v23.Remaining
					elseif v23 and v23.Reason == "NoMoney" then
						TopText.NpcText(Steven, "You can\'t afford my appraisal fee for all of this!", true)
					else
						TopText.NpcText(Steven, "I can\'t do that right now.", true)
					end
				else
					if v19 == 1 then
						if v52 and p1.Character then
							TopText.RainbowPlayerResponse(p1.Character, "Deal ", "[SELL: " .. (NumberUtils.Abbreviate(NewTotalOffer) .. "\194\162") .. "]", "", true)
						end

						task.wait(0.5)

						if p2.FruitCount > 100 then
							TopText.NpcText(Steven, "Calculating...", true)
							task.wait(1)
						end

						task.wait(0.25)
						TopText.NpcText(Steven, "Let me get your payment...", true)
						task.wait(0.5)

						local v27 = Networking.NPCS.SellAll:Fire()

						if not (v27 and v27.Success) then
							TopText.NpcText(Steven, "Something went wrong.. try again.", true)
						else
							HarvestedFruitHandleController:DisconnectAllFruitTools()
							v5:Play(0.2, 10, 1)

							if v52 then
								Rainbow.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Rainbow.TimePosition = 0
								Rainbow.Playing = true
								Networking.NPCS.LegendaryFx:Fire()
								TopText.NpcCountUp(Steven, {
									TextBefore = "Here\'s ",
									Rainbow = true,
									ShouldDisappear = false,
									TextAfter = string.format(" for %d items!", v27.SoldCount),
									FinalAmount = v27.SellPrice,
									Format = Coins
								})
							else
								Normal.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Normal.TimePosition = 0
								Normal.Playing = true
								TopText.NpcCountUp(Steven, {
									TextBefore = "Here\'s ",
									Color = "#00FF00",
									ShouldDisappear = false,
									TextAfter = string.format(" for %d items!", v27.SoldCount),
									FinalAmount = v27.SellPrice,
									Format = Coins
								})
							end
						end
					else
						if not v22 or v19 ~= v16 then
							task.wait(0.5)

							return
						end

						task.wait(0.5)

						if p2.FruitCount > 100 then
							TopText.NpcText(Steven, "Calculating...", true)
							task.wait(1)
						end

						task.wait(0.25)
						TopText.NpcText(Steven, "Daily deal it is! Let me get your payment...", true)
						task.wait(0.5)

						local v28 = Networking.NPCS.UseDailyDealAll:Fire()

						if v28 and v28.Success then
							HarvestedFruitHandleController:DisconnectAllFruitTools()
							v5:Play(0.2, 10, 1)
							Rainbow.PlaybackSpeed = 1 + math.random(-15, 15) / 100
							Rainbow.TimePosition = 0
							Rainbow.Playing = true
							TopText.NpcCountUp(Steven, {
								TextBefore = "DAILY DEAL! Here\'s ",
								Rainbow = true,
								ShouldDisappear = false,
								TextAfter = string.format(" for %d items!", v28.SoldCount),
								FinalAmount = v28.SellPrice,
								Format = Coins
							})
						elseif v28 and v28.Reason == "NotAvailable" then
							TopText.NpcText(Steven, "That deal expired.. sorry!", true)
						else
							TopText.NpcText(Steven, "Something went wrong.. try again.", true)
						end
					end

					return
				end

				task.wait(1)
			end

			if not v17 then
				break
			end
		end
	else
		if v42 and v42.Reason == "Cooldown" then
			TopText.NpcText(Steven, string.format("Slow down! Ask me again in %d seconds.", v42.Remaining), true)
			v6 = os.clock() + v42.Remaining
		elseif v42 and v42.Reason == "NoMoney" then
			TopText.NpcText(Steven, "You can\'t afford my appraisal fee for all of this!", true)
		else
			TopText.NpcText(Steven, "I can\'t do that right now.", true)
		end

		task.wait(1)
	end
end

local function RunSingleBargainLoop(p1, p2, p3) --[[ RunSingleBargainLoop | Line: 752 | Upvalues: Networking (copy), TopText (copy), Steven (copy), v6 (ref), BidOddModule (copy), v2 (copy), Accept (copy), NumberUtils (copy), RadialFXController (copy), Decline (copy), v4 (copy), WaitForChoiceWithCooldown (copy), NotificationController (copy), PromptSkipCooldown (copy), GetHeldFruitInfo (copy), Rainbow (copy), v5 (copy), Coins (copy), Normal (copy) ]]
	local v1 = Networking.NPCS.CheckDailyDeal:Fire()
	local v22 = if v1 then v1.Available else v1
	local v3 = p2.BaseValue * 5

	TopText.NpcText(Steven, "Let me reconsider...", true)
	task.wait(0.5)

	local v42 = Networking.NPCS.AskBid:Fire(p2.FruitId)

	if v42 and v42.Success then
		local NewOffer = v42.NewOffer

		v6 = os.clock() + BidOddModule.BID_COOLDOWN

		local v52

		if v42.Won then
			v2:Play(0.2, 10, 1)

			if v42.Multiplier == 20 then
				local t = {
					{ "LEGENDARY " .. string.upper(p1.DisplayName) .. "! I offer you... ", "!" }
				}

				Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Accept.TimePosition = 0
				Accept.Playing = true

				local v62 = t[math.random(#t)]

				TopText.RainbowNpcText(Steven, v62[1], NumberUtils.Abbreviate(NewOffer) .. "\194\162", v62[2], true)
				RadialFXController:PlayFX("Rainbow")
				task.wait(1)
				v52 = true
			else
				local t = { "Actually, I can do <font color=\'#00FF00\'>%s</font>!", "On second thought.. <font color=\'#00FF00\'>%s</font>!", "You drive a hard bargain. <font color=\'#00FF00\'>%s</font>." }

				Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				Accept.TimePosition = 0
				Accept.Playing = true
				TopText.NpcText(Steven, t[math.random(#t)]:format(NumberUtils.Abbreviate(NewOffer) .. "\194\162"), true)
				RadialFXController:PlayFX("Green")
				task.wait(1)
				v52 = false
			end
		else
			local t = { "Sorry, <font color=\'#FFFF00\'>%s</font> is the best I can do.", "I thought about it.. <font color=\'#FFFF00\'>%s</font>. Can\'t go higher.", "No luck. Still <font color=\'#FFFF00\'>%s</font>." }

			Decline.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Decline.TimePosition = 0
			Decline.Playing = true
			v4:Play(0.2, 10, 1)
			TopText.NpcText(Steven, t[math.random(#t)]:format(NumberUtils.Abbreviate(NewOffer) .. "\194\162"), true)
			RadialFXController:PlayFX("Red")
			task.wait(1)
			v52 = false
		end

		while true do
			local v9 = string.format("Ask for more <font color=\"#FF4444\">[COST: %s]</font>", NumberUtils.Abbreviate((math.floor(NewOffer * (BidOddModule.CostMultiplier - 1)))) .. "\194\162")
			local t = { v52 and string.format("Deal [SELL: %s]", NumberUtils.Abbreviate(NewOffer) .. "\194\162") or string.format("Deal <font color=\"#FFFF00\">[SELL: %s]</font>", NumberUtils.Abbreviate(NewOffer) .. "\194\162"), v9 }
			local v11 = nil
			local v12 = nil
			local v13 = if os.clock() < v6 then true else false

			if v13 then
				table.insert(t, "<font color=\"#00FF00\">Skip Cooldown 3R$</font>")
				v11 = #t
			end

			if v22 then
				local format = string.format

				table.insert(t, format("Daily Deal [SELL: %s]", NumberUtils.Abbreviate(v3) .. "\194\162"))
				v12 = #t
			end

			table.insert(t, "Nevermind")

			local t2 = {}

			if v52 then
				t2[1] = {
					before = "Deal ",
					after = "",
					colored = "[SELL: " .. (NumberUtils.Abbreviate(NewOffer) .. "\194\162") .. "]"
				}
			end

			if v22 and v12 then
				t2[v12] = {
					before = "Daily Deal ",
					after = "",
					colored = "[SELL: " .. (NumberUtils.Abbreviate(v3) .. "\194\162") .. "]"
				}
			end

			if next(t2) == nil then
				t2 = nil
			end

			local v15, v16 = WaitForChoiceWithCooldown(p1, t, 2, v6, t2, v11)

			if v16 == "__COOLDOWN__" then
				NotificationController:CreateNotification(("Please wait %*s"):format((math.ceil((math.max(0, v6 - os.clock()))))), false, 2)
			else
				if v11 and v15 == v11 then
					if PromptSkipCooldown() then
						v6 = 0
					end

					task.wait(0.3)

					continue
				end

				if v16 == "__DISMISSED__" then
					task.wait(0.2)

					return
				end

				if v15 == 2 then
					task.wait(0.5)
					TopText.NpcText(Steven, "Let me reconsider...", true)
					task.wait(0.5)

					local v19, v20 = GetHeldFruitInfo(p1)

					if v19 then
						local v21 = Networking.NPCS.AskBid:Fire(v19.FruitId)

						if v21 and v21.Success then
							NewOffer = v21.NewOffer
							v6 = os.clock() + BidOddModule.BID_COOLDOWN

							if v21.Won then
								v2:Play(0.2, 10, 1)

								if v21.Multiplier == 20 then
									local t3 = {
										{ "LEGENDARY " .. string.upper(p1.DisplayName) .. "! I offer you... ", "!" }
									}

									Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
									Accept.TimePosition = 0
									Accept.Playing = true

									local v222 = t3[math.random(#t3)]

									TopText.RainbowNpcText(Steven, v222[1], NumberUtils.Abbreviate(NewOffer) .. "\194\162", v222[2], true)
									RadialFXController:PlayFX("Rainbow")
									task.wait(1)
									v52 = true

									continue
								end

								local t3 = { "Actually, I can do <font color=\'#00FF00\'>%s</font>!", "On second thought.. <font color=\'#00FF00\'>%s</font>!", "You drive a hard bargain. <font color=\'#00FF00\'>%s</font>." }

								Accept.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Accept.TimePosition = 0
								Accept.Playing = true
								TopText.NpcText(Steven, t3[math.random(#t3)]:format(NumberUtils.Abbreviate(NewOffer) .. "\194\162"), true)
								RadialFXController:PlayFX("Green")
							else
								local t3 = { "Sorry, <font color=\'#FFFF00\'>%s</font> is the best I can do.", "I thought about it.. <font color=\'#FFFF00\'>%s</font>. Can\'t go higher.", "No luck. Still <font color=\'#FFFF00\'>%s</font>." }

								Decline.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Decline.TimePosition = 0
								Decline.Playing = true
								v4:Play(0.2, 10, 1)
								TopText.NpcText(Steven, t3[math.random(#t3)]:format(NumberUtils.Abbreviate(NewOffer) .. "\194\162"), true)
								RadialFXController:PlayFX("Red")
							end

							task.wait(1)
							v52 = false

							continue
						end

						if v21 and v21.Reason == "Cooldown" then
							TopText.NpcText(Steven, string.format("Slow down! Ask me again in %d seconds.", v21.Remaining), true)
							v6 = os.clock() + v21.Remaining
						elseif v21 and v21.Reason == "NoMoney" then
							TopText.NpcText(Steven, "You can\'t afford my appraisal fee!", true)
						elseif v21 and v21.Reason == "Favorited" then
							TopText.NpcText(Steven, "You cannot bargain favorited fruit!", true)
						else
							TopText.NpcText(Steven, "I can\'t do that right now.", true)
						end
					else
						TopText.NpcText(Steven, v20, true)
					end
				else
					if v15 == 1 then
						if v52 and p1.Character then
							TopText.RainbowPlayerResponse(p1.Character, "Deal ", "[SELL: " .. (NumberUtils.Abbreviate(NewOffer) .. "\194\162") .. "]", "", true)
						end

						task.wait(0.5)

						local v23, v24 = GetHeldFruitInfo(p1)

						if not v23 then
							TopText.NpcText(Steven, v24, true)
						else
							local Tool = v23.Tool

							task.wait(0.25)
							TopText.NpcText(Steven, "Let me get your payment...", true)
							task.wait(0.5)

							local v25 = Networking.NPCS.SellFruit:Fire(v23.FruitId)

							if v25 and v25.Success then
								if v52 then
									Networking.NPCS.LegendaryFx:Fire()
									Rainbow.PlaybackSpeed = 1 + math.random(-15, 15) / 100
									Rainbow.TimePosition = 0
									Rainbow.Playing = true

									local t3 = {
										{ "Pleasure doing business! Here\'s ", "." },
										{ "Sold! ", ", all yours." },
										{ "Done deal. ", " coming your way!" }
									}
									local v26 = t3[math.random(#t3)]

									v5:Play(0.2, 10, 1)
									TopText.NpcCountUp(Steven, {
										Rainbow = true,
										ShouldDisappear = true,
										TextBefore = v26[1],
										TextAfter = v26[2],
										FinalAmount = v25.SellPrice,
										Format = Coins
									})
								else
									Normal.PlaybackSpeed = 1 + math.random(-15, 15) / 100
									Normal.TimePosition = 0
									Normal.Playing = true

									local t3 = {
										{ "Pleasure doing business! Here\'s ", "." },
										{ "Sold! ", ", all yours." },
										{ "Done deal. ", " coming your way!" }
									}
									local v27 = t3[math.random(#t3)]

									v5:Play(0.2, 10, 1)
									TopText.NpcCountUp(Steven, {
										Color = "#00FF00",
										ShouldDisappear = true,
										TextBefore = v27[1],
										TextAfter = v27[2],
										FinalAmount = v25.SellPrice,
										Format = Coins
									})
								end

								if Tool and Tool.Parent then
									Tool:Destroy()
								end
							elseif v25 and v25.Reason == "Favorited" then
								TopText.NpcText(Steven, "You cannot sell favorited fruit!", true)
							else
								TopText.NpcText(Steven, "Something went wrong.. try again.", true)
							end
						end
					else
						if not v22 or v15 ~= v12 then
							task.wait(0.5)

							return
						end

						task.wait(0.5)

						local v28, v29 = GetHeldFruitInfo(p1)

						if not v28 then
							TopText.NpcText(Steven, v29, true)
						else
							local Tool = v28.Tool

							task.wait(0.25)
							TopText.NpcText(Steven, "Daily deal! Let me get your payment...", true)
							task.wait(0.5)

							local v30 = Networking.NPCS.UseDailyDealSingle:Fire(v28.FruitId)

							if v30 and v30.Success then
								v5:Play(0.2, 10, 1)
								Rainbow.PlaybackSpeed = 1 + math.random(-15, 15) / 100
								Rainbow.TimePosition = 0
								Rainbow.Playing = true
								TopText.NpcCountUp(Steven, {
									TextBefore = "DAILY DEAL! Here\'s ",
									TextAfter = "!",
									Rainbow = true,
									ShouldDisappear = false,
									FinalAmount = v30.SellPrice,
									Format = Coins
								})

								if Tool and Tool.Parent then
									Tool:Destroy()
								end
							elseif v30 and v30.Reason == "NotAvailable" then
								TopText.NpcText(Steven, "That deal expired.. sorry!", true)
							elseif v30 and v30.Reason == "Favorited" then
								TopText.NpcText(Steven, "You cannot sell favorited fruit!", true)
							else
								TopText.NpcText(Steven, "Something went wrong.. try again.", true)
							end
						end
					end

					return
				end

				task.wait(1)
			end

			if not v13 then
				break
			end
		end
	else
		if v42 and v42.Reason == "Cooldown" then
			TopText.NpcText(Steven, string.format("Slow down! Ask me again in %d seconds.", v42.Remaining), true)
			v6 = os.clock() + v42.Remaining
		elseif v42 and v42.Reason == "NoMoney" then
			TopText.NpcText(Steven, "You can\'t afford my appraisal fee!", true)
		elseif v42 and v42.Reason == "Favorited" then
			TopText.NpcText(Steven, "You cannot bargain favorited fruit!", true)
		else
			TopText.NpcText(Steven, "I can\'t do that right now.", true)
		end

		task.wait(1)
	end
end

return function() --[[ Line: 1082 | Upvalues: ABTests (copy), RunService (copy), v1 (copy), ProximityPrompt (copy), Steven (copy), Networking (copy), TopText (copy), HarvestedFruitHandleController (copy), v5 (copy), Normal (copy), Coins (copy), GetHeldFruitInfo (copy), BidOddModule (copy), NumberUtils (copy), WaitForChoice (copy), RunInventoryBargainLoop (copy), RunSingleBargainLoop (copy), PetData (copy) ]]
	local LocalPlayer = game.Players.LocalPlayer
	local v12 = ABTests.GetAttributeAsync(LocalPlayer, "Sell.Bargain.Enabled", true)

	if type(v12) ~= "boolean" then
		v12 = true
	end

	if RunService:IsStudio() then
		v12 = true
	end

	local t = {}

	local function RebuildPromptList() --[[ RebuildPromptList | Line: 1093 | Upvalues: v12 (ref), LocalPlayer (copy), t (copy) ]]
		local v1 = v12
		local v2 = LocalPlayer:GetAttribute("BargainABOverride")

		if type(v2) == "boolean" then
			v1 = v2
		end

		table.clear(t)
		table.insert(t, "Sell Inventory!")
		table.insert(t, "Sell This!")
		table.insert(t, "How much is this worth?")

		if not v1 then
			local v6

			v6 = t
			table.insert(t, "Nevermind")

			return
		end

		table.insert(t, "Bargain!")
		table.insert(t, "Nevermind")
	end

	local v2 = v12
	local v3 = LocalPlayer:GetAttribute("BargainABOverride")

	if type(v3) == "boolean" then
		v2 = v3
	end

	table.clear(t)
	table.insert(t, "Sell Inventory!")
	table.insert(t, "Sell This!")
	table.insert(t, "How much is this worth?")

	if v2 then
		table.insert(t, "Bargain!")
	end

	table.insert(t, "Nevermind")
	LocalPlayer:GetAttributeChangedSignal("BargainABOverride"):Connect(RebuildPromptList)
	v1:DoDialogue({
		ExitLine = "Goodbye!",
		ProximityPrompt = ProximityPrompt,
		SpeakingNPC = Steven,
		PromptList = t,
		OperationMap = {
			["Sell Inventory!"] = function() --[[ Line: 1122 | Upvalues: Networking (ref), TopText (ref), Steven (ref), HarvestedFruitHandleController (ref), v5 (ref), Normal (ref), Coins (ref) ]]
				local LocalPlayer = game.Players.LocalPlayer
				local v1 = Networking.NPCS.PreviewSellAll:Fire()

				if v1 and (v1.FruitCount or 0) > 100 then
					TopText.NpcText(Steven, "Calculating...", true)
					task.wait(0.5)
				end

				if not v1 or (v1.FruitCount or 0) <= 0 then
					TopText.NpcText(Steven, "You don\'t have anything to sell!", true)
				else
					task.wait(0.25)
					TopText.NpcText(Steven, "Let me get your payment...", true)
					task.wait(0.5)

					local v2 = Networking.NPCS.SellAll:Fire()

					if v2 and v2.Success then
						HarvestedFruitHandleController:DisconnectAllFruitTools()
						v5:Play(0.2, 10, 1)
						Normal.PlaybackSpeed = 1 + math.random(-15, 15) / 100
						Normal.TimePosition = 0
						Normal.Playing = true
						TopText.NpcCountUp(Steven, {
							TextBefore = "Here\'s ",
							Color = "#00FF00",
							ShouldDisappear = false,
							TextAfter = string.format(" for %d items!", v2.SoldCount),
							FinalAmount = v2.SellPrice,
							Format = Coins
						})
					else
						TopText.NpcText(Steven, "Something went wrong.. try again.", true)
					end
				end

				task.wait(1)
			end,
			["Sell This!"] = function() --[[ Line: 1165 | Upvalues: GetHeldFruitInfo (ref), TopText (ref), Steven (ref), Networking (ref), v5 (ref), Normal (ref), Coins (ref) ]]
				task.wait(0.5)

				local v1, v2 = GetHeldFruitInfo(game.Players.LocalPlayer)

				if not v1 then
					TopText.NpcText(Steven, v2, true)
				elseif v1 == "Pet" then
					local Tool = v2.Tool
					local v3 = Networking.NPCS.SellPet:Fire(v2.PetID)

					if v3 and v3.Success then
						v5:Play(0.2, 10, 1)
						Normal.PlaybackSpeed = 1 + math.random(-15, 15) / 100
						Normal.TimePosition = 0
						Normal.Playing = true
						TopText.NpcCountUp(Steven, {
							TextBefore = "Here\'s ",
							TextAfter = "!",
							Color = "#00FF00",
							ShouldDisappear = false,
							FinalAmount = v3.SellPrice,
							Format = Coins
						})

						if Tool and Tool.Parent then
							Tool:Destroy()
						end
					else
						TopText.NpcText(Steven, "Something went wrong.. try again.", true)
					end
				else
					local Tool = v1.Tool
					local v4 = Networking.NPCS.SellFruit:Fire(v1.FruitId)

					if v4 and v4.Success then
						v5:Play(0.2, 10, 1)
						Normal.PlaybackSpeed = 1 + math.random(-15, 15) / 100
						Normal.TimePosition = 0
						Normal.Playing = true
						TopText.NpcCountUp(Steven, {
							TextBefore = "Here\'s ",
							TextAfter = "!",
							Color = "#00FF00",
							ShouldDisappear = false,
							FinalAmount = v4.SellPrice,
							Format = Coins
						})

						if Tool and Tool.Parent then
							Tool:Destroy()
						end
					elseif v4 and v4.Reason == "Favorited" then
						TopText.NpcText(Steven, "You cannot sell favorited fruit!", true)
					else
						TopText.NpcText(Steven, "Something went wrong.. try again.", true)
					end
				end

				task.wait(1)
			end,
			["Bargain!"] = function() --[[ Line: 1229 | Upvalues: Networking (ref), BidOddModule (ref), GetHeldFruitInfo (ref), TopText (ref), Steven (ref), NumberUtils (ref), WaitForChoice (ref), RunInventoryBargainLoop (ref), RunSingleBargainLoop (ref) ]]
				task.wait(0.5)

				local LocalPlayer = game.Players.LocalPlayer
				local v1 = Networking.NPCS.PreviewSellAll:Fire()
				local v2 = if v1 then if (v1.FruitCount or 0) > 0 then true else false else v1
				local v3 = v2 and v1.TotalValue or 0
				local v5 = math.floor(v3 * (BidOddModule.CostMultiplier - 1))
				local v6 = GetHeldFruitInfo(LocalPlayer)
				local v7 = if v6 == nil then false else true
				local v8

				if v7 then
					local v9 = Networking.NPCS.GetFruitBid:Fire(v6.FruitId)

					v8 = v6.BaseValue

					if v9 and v9.BidPrice > 0 then
						v8 = v9.CurrentOffer
					end
				else
					v8 = 0
				end

				local v11 = math.floor(v8 * (BidOddModule.CostMultiplier - 1))

				if not (v2 or v7) then
					TopText.NpcText(Steven, "You don\'t have anything to bargain with!", true)
					task.wait(1)

					return
				end

				TopText.NpcText(Steven, "What would you like to bargain over?", true)
				task.wait(0.1)

				local t = {}
				local v12 = nil
				local v13

				if v2 then
					local format = string.format

					table.insert(t, format("Bargain Inventory <font color=\"#FF4444\">[COST: %s]</font>", NumberUtils.Abbreviate(v5) .. "\194\162"))
					v13 = #t
				else
					v13 = nil
				end

				if v7 then
					local format = string.format

					table.insert(t, format("Bargain This <font color=\"#FF4444\">[COST: %s]</font>", NumberUtils.Abbreviate(v11) .. "\194\162"))
					v12 = #t
				end

				table.insert(t, "Nevermind")

				local v16, v17 = WaitForChoice(LocalPlayer, t)

				if v17 == "__DISMISSED__" then
					task.wait(0.2)

					return
				end

				if v13 and v16 == v13 then
					RunInventoryBargainLoop(LocalPlayer, v1, v3)

					return
				end

				if v12 and v16 == v12 then
					RunSingleBargainLoop(LocalPlayer, v6, v8)
				else
					task.wait(0.5)
				end
			end,
			["How much is this worth?"] = function() --[[ Line: 1301 | Upvalues: TopText (ref), Steven (ref), GetHeldFruitInfo (ref), PetData (ref), NumberUtils (ref), Networking (ref) ]]
				task.wait(0.5)
				TopText.NpcText(Steven, "Let me take a look...", true)
				task.wait(1)

				local v1, v2 = GetHeldFruitInfo(game.Players.LocalPlayer)

				if not v1 then
					TopText.NpcText(Steven, v2, true)
				elseif v1 == "Pet" then
					local t = { "I\'ll give you <font color=\'#FFFF00\'>%s</font> for that", "I\'d value it at <font color=\'#FFFF00\'>%s</font>", "Best I can do is <font color=\'#FFFF00\'>%s</font>", "I could do <font color=\'#FFFF00\'>%s</font>", "That is worth about <font color=\'#FFFF00\'>%s</font>", "You\'re looking at about <font color=\'#FFFF00\'>%s</font> for that", "I\'d pay no more than <font color=\'#FFFF00\'>%s</font>", "Very cute, I\'d give you <font color=\'#FFFF00\'>%s</font>" }

					TopText.NpcText(Steven, t[math.random(#t)]:format(NumberUtils.Abbreviate(PetData[v2.PetName].BasePrice * 0.5) .. "\194\162"), true)
				else
					local v4 = Networking.NPCS.GetFruitBid:Fire(v1.FruitId)
					local BaseValue = v1.BaseValue

					if v4 and v4.BidPrice > 0 then
						BaseValue = v4.CurrentOffer
					end

					local t = { "I\'ll give you <font color=\'#FFFF00\'>%s</font> for that", "I\'d value it at <font color=\'#FFFF00\'>%s</font>", "Best I can do is <font color=\'#FFFF00\'>%s</font>", "I could do <font color=\'#FFFF00\'>%s</font>", "That is worth about <font color=\'#FFFF00\'>%s</font>", "You\'re looking at about <font color=\'#FFFF00\'>%s</font> for that", "I\'d pay no more than <font color=\'#FFFF00\'>%s</font>" }

					TopText.NpcText(Steven, t[math.random(#t)]:format(NumberUtils.Abbreviate(BaseValue) .. "\194\162"), true)
				end

				task.wait(1)
			end,
			Nevermind = function() --[[ Line: 1356 ]]
				task.wait(0.5)
			end
		},
		IntroLines = { "Got anything to sell?" }
	})
end