-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OfflineEarningsMenu, time of decompilation: Sun May  3 10:12:13 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local OfflineEarningsSlice = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsSlice)
local OfflineEarningsServiceClient = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsServiceClient)
local OfflineEarningsServiceUtils = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsServiceUtils)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

local function RewardCard(t1: {[any]: any}) -- line: 24
	-- upvalues: StylizedFrame (copy), CurrencyLabel (copy)
	return StylizedFrame({
		Name = t1.Name,
		Theme = "Black",
		Size = UDim2.fromOffset(260, 118),
		Visible = t1.Visible,
		Position = t1.Position,
		AnchorPoint = Vector2.new(0.5, 0.5),
		CurrencyLabel({
			LayoutOrder = 2,
			Name = t1.Name .. "Amount",
			Currency = t1.Currency,
			Amount = t1.Amount,
			Size = UDim2.fromScale(1, 0.5),
			Position = UDim2.fromScale(0.5, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		})
	})
end

return {
	menuId = "offlineEarningsMenu",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 46
		-- upvalues: OfflineEarningsSlice (copy), Menu (copy), Vide (copy), OfflineEarningsServiceUtils (copy), OfflineEarningsServiceClient (copy), Frame (copy), TextLabel (copy), RewardCard (copy), StylizedButton (copy)
		local pendingReward = OfflineEarningsSlice.pendingReward
		local openedMenu = Menu.openedMenu
		local v16 = Vide.derive(function() -- line: 49
			-- upvalues: pendingReward (copy)
			local v20 = pendingReward()

			if v20 then
				return v20.coins
			end

			return 0
		end)
		local v17 = Vide.derive(function() -- line: 53
			-- upvalues: pendingReward (copy)
			local v21 = pendingReward()

			if v21 then
				return v21.goop
			end

			return 0
		end)
		local v18 = Vide.derive(function() -- line: 57
			-- upvalues: v17 (copy)
			return v17() > 0
		end)
		local u19 = openedMenu()

		Vide.effect(function() -- line: 62
			-- upvalues: openedMenu (copy), u19 (ref), OfflineEarningsServiceUtils (copy), pendingReward (copy), OfflineEarningsServiceClient (copy)
			local v22 = openedMenu()

			if u19 == "offlineEarningsMenu" and (v22 ~= "offlineEarningsMenu" and OfflineEarningsServiceUtils.hasReward(pendingReward())) then
				task.defer(function() -- line: 69
					-- upvalues: OfflineEarningsServiceClient (copy)
					OfflineEarningsServiceClient:claim()
				end)
			end

			u19 = v22
		end)

		return Menu.Component({
			menuId = "offlineEarningsMenu",
			Title = "Offline Earnings",
			Frame({
				Name = "OfflineEarningsContent",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				TextLabel({
					Name = "Subtitle",
					Text = "While you were away...",
					Size = UDim2.new(1, -40, 0, 54),
					Position = UDim2.new(0.5, 0, 0, 54),
					AnchorPoint = Vector2.new(0.5, 0),
					Stroke = {},
					DropShadow = {}
				}),
				Frame({
					Name = "RewardCards",
					Size = UDim2.fromOffset(544, 126),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					RewardCard({
						Name = "CoinsCard",
						Currency = "coins",
						Amount = v16,
						Position = function() --[[ Position ]] -- line: 107
							-- upvalues: v18 (copy)
							if v18() then
								return (UDim2.fromScale(0.25, 0.5))
							end

							return (UDim2.fromScale(0.5, 0.5))
						end
					}),
					RewardCard({
						Name = "GoopCard",
						Currency = "goop",
						Amount = v17,
						Visible = v18,
						Position = function() --[[ Position ]] -- line: 116
							return UDim2.fromScale(0.75, 0.5)
						end
					})
				}),
				StylizedButton({
					Name = "ClaimButton",
					Text = "CLAIM",
					HoverScale = 1.05,
					Theme = function() --[[ Theme ]] -- line: 124
						-- upvalues: OfflineEarningsServiceUtils (copy), pendingReward (copy)
						if OfflineEarningsServiceUtils.hasReward(pendingReward()) then
							return "Green"
						end

						return "Grey"
					end,
					Size = UDim2.fromOffset(230, 82),
					Position = UDim2.new(0.5, 0, 1, -38),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Activated = function() --[[ Activated ]] -- line: 132
						-- upvalues: Menu (copy)
						Menu.setOpenedMenu(nil)
					end
				})
			})
		})
	end
}
