-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeTile, time of decompilation: Sun May  3 10:11:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local appendNumberedChildren = require(ReplicatedStorage.Source.Core.UI.appendNumberedChildren)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local NotificationBadge = require(ReplicatedStorage.Source.Features.App.Components.NotificationBadge)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local UpgradeCounterUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeCounterUtils)
local UpgradeServiceClient = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local UpgradeTree = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UpgradeUIUtils = require(script.Parent.UpgradeUIUtils)

return function(p1, p2, p3, p4, p5) -- line: 23
	-- upvalues: Vide (copy), ImageIds (copy), UpgradeTree (copy), UpgradeServiceUtils (copy), UpgradeSlice (copy), UpgradeUIUtils (copy), appendNumberedChildren (copy), Button (copy), TutorialServiceClient (copy), ErrorMessages (copy), UpgradeServiceClient (copy), ImageLabel (copy), Frame (copy), TextLabel (copy), CurrencyLabel (copy), NotificationBadge (copy), UpgradeCounterUtils (copy)
	local v24 = Vide.source(0)
	local v25, v26 = Vide.spring(v24, 0.5, 0.6)
	local v27 = Vide.source(false)
	local u28 = nil
	local u29 = nil
	local v30 = Vide.source(ImageIds.upgradeHexBlue)
	local v31 = Vide.source(false)
	local v32 = Vide.source(false)
	local n1 = 0

	Vide.effect(function() -- line: 52
		-- upvalues: p1 (copy), p2 (copy), UpgradeTree (copy), UpgradeServiceUtils (copy), n1 (ref), v26 (copy), v32 (copy), v31 (copy), v30 (copy), ImageIds (copy)
		local n2 = 0
		local id = p1.id
		local v37 = p2()

		while not v37[id] do
			id = UpgradeTree[p1.parentTree][id].dependency
			n2 += 1

			if id == UpgradeServiceUtils.enums.originDependency then
				break
			end
		end

		if n1 == 2 and n2 <= 1 then
			v26({
				impulse = 0.15
			})
		elseif n1 == 3 and n2 == 2 then
			v26({
				position = 0,
				velocity = 0
			})
		end

		v32(n2 <= 1)
		v31(n2 <= 2)

		if n2 <= 1 and p1.tree then
			v30(if p1.tree ~= "main" then ImageIds.upgradeHexYellow else ImageIds.upgradeHexRed)
		elseif n2 == 1 then
			v30(ImageIds.upgradeHexBlack)
		elseif n2 > 1 then
			v30(ImageIds.upgradeHexBlank)
		else
			v30(ImageIds.upgradeHexBlue)
		end

		n1 = n2
	end)
	Vide.effect(function() -- line: 86
		-- upvalues: u28 (ref), u29 (ref), UpgradeSlice (copy), p1 (copy), v27 (copy), v24 (copy), UpgradeUIUtils (copy), v26 (copy), Vide (copy)
		if u28 then
			task.cancel(u28)
			u28 = nil
		end

		if u29 then
			task.cancel(u29)
			u29 = nil
		end

		if UpgradeSlice.shown() and UpgradeSlice.tree() == p1.parentTree then
			v27(true)
			u28 = task.delay(p1.layers * 0.1, function() -- line: 98
				-- upvalues: v24 (copy), UpgradeUIUtils (copy), v26 (copy), u28 (ref)
				v24(UpgradeUIUtils.HEX_SIZE)
				task.wait(0.5)
				v26({
					velocity = 0,
					position = UpgradeUIUtils.HEX_SIZE
				})
				u28 = nil
			end)
		else
			v24(0)
			u29 = task.delay(0.5, function() -- line: 106
				-- upvalues: v27 (copy), v26 (copy), u29 (ref)
				v27(false)
				v26({
					position = 0,
					velocity = 0
				})
				u29 = nil
			end)
		end

		Vide.cleanup(function() -- line: 113
			-- upvalues: u28 (ref), u29 (ref)
			if u28 then
				task.cancel(u28)
				u28 = nil
			end

			if u29 then
				task.cancel(u29)
				u29 = nil
			end
		end)
	end)

	local t1 = {
		Name = "Icon",
		ZIndex = 2,
		Visible = v32,
		Size = UDim2.fromScale(0.55, 0.755),
		Position = UDim2.fromScale(0.5, 0.45),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}

	appendNumberedChildren(p1.icon(), t1)

	return Button({
		Name = p1.id .. "Tile",
		Size = function() --[[ Size ]] -- line: 137
			-- upvalues: v25 (copy)
			return UDim2.fromScale(v25() * 0.66, v25() * 0.66)
		end,
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Position = UDim2.fromScale(0.5 + p1.coords.X * UpgradeUIUtils.HEX_SIZE, 0.5 + p1.coords.Y * UpgradeUIUtils.HEX_SIZE),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Visible = function() --[[ Visible ]] -- line: 146
			-- upvalues: v27 (copy), v31 (copy)
			return v27() and v31()
		end,
		OnEnter = function() --[[ OnEnter ]] -- line: 149
			-- upvalues: p1 (copy), UpgradeUIUtils (copy), p5 (copy), v32 (copy), UpgradeSlice (copy), p4 (copy)
			if p1.tree or (UpgradeUIUtils.isTouchPreferred(p5()) or not v32() or UpgradeSlice.moving()) then
				return
			end

			p4(p1)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 161
			-- upvalues: UpgradeUIUtils (copy), p5 (copy), p4 (copy), p1 (copy)
			if UpgradeUIUtils.isTouchPreferred(p5()) then
				return
			end

			if p4() == p1 then
				p4(nil)
			end
		end,
		Activated = function() --[[ Activated ]] -- line: 170
			-- upvalues: v32 (copy), UpgradeUIUtils (copy), p5 (copy), UpgradeSlice (copy), p1 (copy), TutorialServiceClient (copy), ErrorMessages (copy), p4 (copy), p2 (copy), UpgradeServiceClient (copy)
			if not v32() then
				return
			end

			local v38 = UpgradeUIUtils.isTouchPreferred(p5())

			if UpgradeSlice.moving() then
				return
			end

			if not v38 and tick() - UpgradeSlice.inputEndedTime() < 0.2 then
				return
			end

			if p1.tree then
				if not TutorialServiceClient:canOpenUpgradeTree() then
					ErrorMessages.add("That upgrade tree is locked during the tutorial.")

					return
				end

				p4(nil)
				UpgradeSlice.tree(p1.tree)

				return
			end

			if v38 then
				p4(p1)

				return
			end

			if not p2()[p1.id] then
				UpgradeServiceClient:unlockUpgrade(p1.id)
			end
		end,
		ImageLabel({
			Image = v30,
			ScaleType = Enum.ScaleType.Fit,
			Size = UDim2.fromScale(1.5151515151515151, 1.5151515151515151),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 0,
			Frame(t1),
			TextLabel({
				TextWrapped = true,
				ZIndex = 4,
				Text = p1.name,
				Visible = v32,
				Size = UDim2.fromScale(0.8, 0.16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {},
				DropShadow = {}
			}),
			if not p1.cost or UpgradeUIUtils.isFreeUpgrade(p1) then if not UpgradeUIUtils.isFreeUpgrade(p1) then if not p1.tree then nil else TextLabel({
				ZIndex = 4,
				Visible = v32,
				Text = p1.tree ~= "main" and "Open" or "Back",
				TextColor3 = if p1.tree ~= "main" then Color3.fromRGB(255, 239, 94) else Color3.fromRGB(255, 62, 62),
				Position = UDim2.fromScale(0.5, 0.66),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromScale(0.7, 0.175),
				Stroke = {}
			}) else TextLabel({
				Text = "Free",
				ZIndex = 4,
				Visible = function() --[[ Visible ]] -- line: 236
					-- upvalues: v32 (copy), p2 (copy), p1 (copy)
					return v32() and not p2()[p1.id]
				end,
				TextColor3 = Color3.fromRGB(165, 255, 165),
				Position = UDim2.fromScale(0.5, 0.66),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromScale(0.7, 0.175),
				Stroke = {}
			}) else CurrencyLabel({
				ZIndex = 4,
				Visible = function() --[[ Visible ]] -- line: 224
					-- upvalues: v32 (copy), p2 (copy), p1 (copy)
					return v32() and not p2()[p1.id]
				end,
				Currency = p1.cost.currency,
				Amount = p1.cost.amount,
				TextColor3 = function() --[[ getCostTextColor ]] -- line: 40
					-- upvalues: p1 (copy), p3 (copy)
					if not p1.cost then
						return Color3.fromRGB(255, 255, 255)
					end

					if p3(p1.cost.currency) >= p1.cost.amount then
						return Color3.fromRGB(255, 255, 255)
					end

					return Color3.fromRGB(255, 45, 73)
				end,
				Position = UDim2.fromScale(0.5, 0.66),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromScale(0.7, 0.175)
			}),
			if not p1.tree or p1.tree == "main" then nil else NotificationBadge({
				ZIndex = 3,
				Count = function() --[[ Count ]] -- line: 263
					-- upvalues: UpgradeCounterUtils (copy), p1 (copy), p2 (copy), p3 (copy)
					return UpgradeCounterUtils.countPurchasableInTree(p1.tree, p2(), p3)
				end,
				Size = UDim2.fromScale(0.22, 0.22),
				Position = UDim2.fromScale(0.87, 0.13),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
		})
	})
end
