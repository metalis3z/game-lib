-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GiftingMenu, time of decompilation: Sun May  3 10:12:06 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local GetPlayerPortraitImageId = require(ReplicatedStorage.Source.Core.UI.GetPlayerPortraitImageId)
local DisplayNameWithIcons = require(ReplicatedStorage.Source.Core.UI.DisplayNameWithIcons)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local MonetizationSlice = require(ReplicatedStorage.Source.Features.Monetization.MonetizationSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)

local function getGiftablePlayers() -- line: 21
	-- upvalues: Players (copy)
	local t1 = {}

	for _, v25 in Players:GetPlayers() do
		if v25 ~= Players.LocalPlayer then
			table.insert(t1, v25)
		end
	end

	table.sort(t1, function(p1, p2) -- line: 29
		local v37 = string.lower(p1.DisplayName ~= "" and p1.DisplayName or p1.Name)
		local v38 = string.lower(p2.DisplayName ~= "" and p2.DisplayName or p2.Name)

		if v37 == v38 then
			return p1.UserId < p2.UserId
		end

		return v37 < v38
	end)

	return t1
end
local function useGiftablePlayers() -- line: 41
	-- upvalues: Vide (copy), getGiftablePlayers (copy), Players (copy)
	local v26 = Vide.source((getGiftablePlayers()))

	local function syncPlayers() -- line: 44
		-- upvalues: v26 (copy), getGiftablePlayers (copy)
		v26((getGiftablePlayers()))
	end

	local connection = Players.PlayerAdded:Connect(syncPlayers)
	local connection2 = Players.PlayerRemoving:Connect(syncPlayers)

	Vide.cleanup(function() -- line: 51
		-- upvalues: connection (copy), connection2 (copy)
		connection:Disconnect()
		connection2:Disconnect()
	end)

	return v26
end
local function PlayerCard(p3, n1: number) -- line: 59
	-- upvalues: Vide (copy), GetPlayerPortraitImageId (copy), StylizedFrame (copy), Frame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), DisplayNameWithIcons (copy), StylizedButton (copy), MonetizationSlice (copy), ErrorMessages (copy), MonetizationServiceClient (copy)
	local v32 = Vide.derive(function() -- line: 60
		-- upvalues: GetPlayerPortraitImageId (copy), p3 (copy)
		return GetPlayerPortraitImageId(p3().UserId)
	end)

	return StylizedFrame({
		Theme = "Grey",
		Size = UDim2.new(1, 0, 0, 92),
		LayoutOrder = n1,
		Frame({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageLabel({
				Name = "PortraitRing",
				Image = ImageIds.blackFrame,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(28, 22, 107, 100),
				Size = UDim2.fromOffset(68, 68),
				Position = UDim2.new(0, 12, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5)
			}),
			ImageLabel({
				Name = "Portrait",
				ClipsDescendants = true,
				Image = v32,
				Size = UDim2.fromOffset(58, 58),
				Position = UDim2.new(0, 17, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5)
			}),
			TextLabel({
				Name = "PlayerName",
				RichText = true,
				Text = function() --[[ Text ]] -- line: 94
					-- upvalues: DisplayNameWithIcons (copy), p3 (copy)
					return DisplayNameWithIcons(p3())
				end,
				Size = UDim2.new(0.54, 0, 0, 34),
				Position = UDim2.new(0, 92, 0.34, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 3
				},
				DropShadow = {}
			}),
			TextLabel({
				Name = "Username",
				TextSize = 18,
				Text = function() --[[ Text ]] -- line: 108
					-- upvalues: p3 (copy)
					return "@" .. p3().Name
				end,
				Size = UDim2.new(0.4, 0, 0, 24),
				Position = UDim2.new(0, 94, 0.68, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = Color3.fromRGB(220, 220, 220),
				Stroke = {
					Thickness = 2
				}
			}),
			StylizedButton({
				Theme = "Green",
				Text = "Gift",
				Size = UDim2.fromOffset(120, 50),
				Position = UDim2.new(1, -16, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Activated = function() --[[ Activated ]] -- line: 126
					-- upvalues: MonetizationSlice (copy), ErrorMessages (copy), MonetizationServiceClient (copy), p3 (copy)
					local v39 = MonetizationSlice.giftingProduct()

					if not v39 then
						ErrorMessages.add("Pick a product to gift first.")

						return
					end

					local v40, v41 = MonetizationServiceClient:promptGift(p3().UserId, v39)

					if not v40 then
						ErrorMessages.add(v41 or "Failed to send gift.")
					end
				end
			})
		})
	})
end
local function GiftingList() -- line: 143
	-- upvalues: useGiftablePlayers (copy), Vide (copy), Frame (copy), TextLabel (copy), ScrollingFrame (copy), PlayerCard (copy), UIListLayout (copy), UIPadding (copy)
	local v33 = useGiftablePlayers()
	local v34 = Vide.derive(function() -- line: 145
		-- upvalues: v33 (copy)
		return v33()
	end)

	return Frame({
		Name = "GiftingList",
		Size = UDim2.fromScale(1, 0.84),
		Position = UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundTransparency = 1,
		Vide.show(function() -- line: 156
			-- upvalues: v34 (copy)
			return #v34() == 0
		end, function() -- line: 158
			-- upvalues: Frame (copy), TextLabel (copy)
			return Frame({
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				TextLabel({
					Text = "No one else is in the server to gift right now.",
					Size = UDim2.fromScale(0.9, 0.2),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Stroke = {
						Thickness = 3
					},
					DropShadow = {}
				})
			})
		end),
		Vide.show(function() -- line: 174
			-- upvalues: v34 (copy)
			return #v34() > 0
		end, function() -- line: 176
			-- upvalues: ScrollingFrame (copy), Vide (copy), v34 (copy), PlayerCard (copy), UIListLayout (copy), UIPadding (copy)
			return ScrollingFrame({
				Size = UDim2.fromScale(1, 1),
				CanvasSize = UDim2.fromScale(0, 0),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ScrollBarThickness = 0,
				ScrollBarImageTransparency = 1,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				Vide.indexes(v34, function(p4, n2: number) -- line: 186
					-- upvalues: PlayerCard (copy)
					return PlayerCard(p4, n2)
				end),
				UIListLayout({
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center
				}),
				UIPadding({
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 4)
				})
			})
		end)
	})
end

return {
	menuId = "GiftingMenu",
	alwaysMounted = false,
	Component = function() --[[ GiftingMenu ]] -- line: 208
		-- upvalues: Menu (copy), MonetizationSlice (copy), TextLabel (copy), MonetizationServiceClient (copy), GiftingList (copy)
		return Menu.Component({
			menuId = "GiftingMenu",
			Title = "Gift",
			Scale = 0.92,
			OnClose = function() --[[ OnClose ]] -- line: 213
				-- upvalues: MonetizationSlice (copy), Menu (copy)
				MonetizationSlice.giftingProduct(nil)
				Menu.setOpenedMenu("Shop", true)
			end,
			TextLabel({
				TextSize = 24,
				Text = function() --[[ Text ]] -- line: 219
					-- upvalues: MonetizationSlice (copy), MonetizationServiceClient (copy)
					local v42 = MonetizationSlice.giftingProduct()

					if not v42 then
						return "Select who should receive this gift."
					end

					return `Choose a player to receive { MonetizationServiceClient:getProductInfo(v42).Name or "Gift" }.`
				end,
				Size = UDim2.new(1, -20, 0, 34),
				Position = UDim2.new(0.5, 0, 0, 42),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {
					Thickness = 3
				},
				DropShadow = {}
			}),
			GiftingList()
		})
	end
}
