-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeHoverInfo, time of decompilation: Sun May  3 10:11:13 2026 ]]
local _select = select

local function v97(tbl, idx, ...)
	local va = { ... }

	for i = 1, _select("#", ...) do
		tbl[idx + i - 1] = va[i]
	end
end

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local preferredInputSource = require(ReplicatedStorage.Source.Core.UI.Sources.preferredInputSource)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local RarityTiers = require(ReplicatedStorage.Source.Game.Items.RarityTiers)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)
local v22 = Vide.source(nil)
local vector2 = Vector2.new(2, 2)
local vector2_2 = Vector2.new(12, 0)
local vector2_3 = Vector2.new(220, 180)
local color3 = Color3.fromRGB(48, 48, 48)

local function getHoveredSlimeButton() -- line: 61
	-- upvalues: UserInputService (copy)
	local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

	if PlayerGui == nil then
		return nil
	end

	local MouseLocation = UserInputService:GetMouseLocation()

	for _, v41 in (PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y)) do
		local v42 = v41

		while true do
			if v42 == nil then
				v42 = nil

				break
			end

			if v42 ~= nil and (v42:IsA("GuiButton") and (v42.Name == "SlimeButton" or string.sub(v42.Name, 1, 14) == "InventorySlime")) then
				break
			end

			v42 = v42.Parent
		end

		if v42 ~= nil and v42:IsDescendantOf(PlayerGui) then
			return v42
		end
	end

	return nil
end
local function getPointerPosition(p1) -- line: 89
	-- upvalues: preferredInputSource (copy), GuiService (copy), getHoveredSlimeButton (copy), Workspace (copy), vector2_2 (copy), vector2_3 (copy), UserInputService (copy), vector2 (copy)
	if preferredInputSource() == Enum.PreferredInput.Gamepad then
		local SelectedObject = GuiService.SelectedObject
		local g46 = nil

		while SelectedObject ~= nil do
			if SelectedObject ~= nil and (SelectedObject:IsA("GuiButton") and (SelectedObject.Name == "SlimeButton" or string.sub(SelectedObject.Name, 1, 14) == "InventorySlime")) then
				g46 = true
			end

			if g46 then
				break
			end

			SelectedObject = SelectedObject.Parent
		end

		if not g46 then
			SelectedObject = nil
		end

		g46 = false

		if not SelectedObject then
			SelectedObject = getHoveredSlimeButton()
		end

		if SelectedObject ~= nil then
			local CurrentCamera = Workspace.CurrentCamera
			local v48 = if not CurrentCamera then Vector2.new(1920, 1080) else CurrentCamera.ViewportSize
			local v49 = math.min(SelectedObject.AbsolutePosition.X + SelectedObject.AbsoluteSize.X + vector2_2.X, (math.max(v48.X - vector2_3.X - 8, 0)))
			local v50 = math.clamp(SelectedObject.AbsolutePosition.Y + SelectedObject.AbsoluteSize.Y * 0.5 - vector2_3.Y * 0.5, 8, (math.max(v48.Y - vector2_3.Y - 8, 8)))

			return Vector2.new(v49, v50)
		end
	end

	local GuiInset = GuiService:GetGuiInset()

	return ((if not p1 then UserInputService:GetMouseLocation() else Vector2.new(p1.Position.X, p1.Position.Y))) - GuiInset + vector2
end
local function Divider(n1: number) -- line: 126
	-- upvalues: Frame (copy), UIGradient (copy)
	return Frame({
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		LayoutOrder = n1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.7, 0, 0, 5),
		UIGradient({
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.4, 0),
				NumberSequenceKeypoint.new(0.6, 0),
				NumberSequenceKeypoint.new(1, 1)
			})
		})
	})
end
local function StatLabel(t1: {[any]: any}) -- line: 153
	-- upvalues: TextLabel (copy)
	return TextLabel({
		TextSize = 28,
		Name = t1.Name,
		Text = t1.Text,
		Size = UDim2.new(0.86, 0, 0, 30),
		LayoutOrder = t1.LayoutOrder,
		Stroke = {},
		Prefix = {
			Image = t1.Icon,
			Size = UDim2.fromScale(0.8, 0.8),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Padding = UDim.new(0, 8)
		}
	})
end
local function getXpBarTransparency(n2: number) -- line: 170
	local v56 = math.clamp(n2, 0, 1)

	if v56 <= 0 then
		return NumberSequence.new(1)
	end

	if v56 >= 1 then
		return NumberSequence.new(0)
	end

	local v57 = math.max(v56 - 0.001, 0)
	local v58 = math.min(v56 + 0.001, 1)

	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(v57, 0),
		NumberSequenceKeypoint.new(v58, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
end
local function XpBar(p2: ((...any) -> ...any)) -- line: 189
	-- upvalues: Frame (copy), UIGradient (copy), UICorner (copy), UIStroke (copy), TextLabel (copy), Abbreviate (copy), getXpBarTransparency (copy)
	return Frame({
		Name = "XpBarBack",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Size = UDim2.new(0.731, 0, 0, 18),
		Position = UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		ClipsDescendants = true,
		BorderSizePixel = 0,
		LayoutOrder = 32,
		UIGradient({
			Rotation = 90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 49, 54)),
				ColorSequenceKeypoint.new(0.3, Color3.fromRGB(92, 100, 112)),
				ColorSequenceKeypoint.new(0.9, Color3.fromRGB(92, 100, 112)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 49, 54))
			})
		}),
		UICorner({
			CornerRadius = UDim.new(1, 0)
		}),
		UIStroke({
			Thickness = 2,
			Color = Color3.fromRGB(0, 0, 0)
		}),
		TextLabel({
			Name = "XpLabel",
			TextSize = 16,
			ZIndex = 9,
			Text = function() --[[ Text ]] -- line: 224
				-- upvalues: p2 (copy), Abbreviate (copy)
				local v88 = p2()

				return `{ Abbreviate(v88.xp) }/{ Abbreviate(v88.xpRequired) } XP`
			end,
			Size = UDim2.new(1, 0, 0, 16),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		}),
		Frame({
			Name = "XpBarFill",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0,
			Size = UDim2.fromScale(1, 1),
			BorderSizePixel = 0,
			UICorner({
				CornerRadius = UDim.new(1, 0)
			}),
			UIGradient({
				Rotation = 0,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 220, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 255, 255))
				}),
				Transparency = function() --[[ Transparency ]] -- line: 253
					-- upvalues: getXpBarTransparency (copy), p2 (copy)
					return getXpBarTransparency(p2().progress)
				end
			})
		})
	})
end
local function HoverInfo() -- line: 261
	-- upvalues: Vide (copy), v22 (copy), Slimes (copy), InventoryServiceUtils (copy), OddsGradients (copy), RarityTiers (copy), getPointerPosition (copy), UserInputService (copy), RunService (copy), preferredInputSource (copy), ImageLabel (copy), ImageIds (copy), vector2_3 (copy), Frame (copy), TextLabel (copy), Mutations (copy), Abbreviate (copy), color3 (copy), Divider (copy), StatLabel (copy), XpBar (copy), UIListLayout (copy)
	local v60 = Vide.source(v22())

	Vide.effect(function() -- line: 263
		-- upvalues: v22 (copy), v60 (copy)
		local v89 = v22()

		if v89 == nil then
			return
		end

		v60(v89)
	end)

	local v61 = Vide.source(UDim2.fromOffset(0, 0))
	local v62 = Vide.derive(function() -- line: 273
		-- upvalues: Slimes (copy), v60 (copy)
		return Slimes.getSlime(v60().id)
	end)
	local v63 = Vide.derive(function() -- line: 277
		-- upvalues: InventoryServiceUtils (copy), v60 (copy)
		return InventoryServiceUtils.getVisualOdds(v60())
	end)
	local v64 = Vide.derive(function() -- line: 280
		-- upvalues: OddsGradients (copy), v63 (copy)
		return OddsGradients.getGradient(v63())
	end)
	local v65 = Vide.derive(function() -- line: 283
		-- upvalues: RarityTiers (copy), v63 (copy)
		return RarityTiers.getTier(v63())
	end)
	local v66 = Vide.derive(function() -- line: 286
		-- upvalues: InventoryServiceUtils (copy), v60 (copy)
		return InventoryServiceUtils.getSlimeStatsFromData(v60())
	end)
	local v67 = Vide.derive(function() -- line: 289
		-- upvalues: InventoryServiceUtils (copy), v60 (copy)
		return InventoryServiceUtils.getLevelProgress(v60())
	end)
	local v68 = getPointerPosition(nil)

	v61(UDim2.fromOffset(v68.X, v68.Y))

	local connection = UserInputService.InputChanged:Connect(function(input) -- line: 300
		-- upvalues: getPointerPosition (copy), v61 (copy)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v93 = getPointerPosition(input)

		v61(UDim2.fromOffset(v93.X, v93.Y))
	end)
	local connection2 = UserInputService.InputBegan:Connect(function(input) -- line: 311
		-- upvalues: getPointerPosition (copy), v61 (copy)
		if input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v95 = getPointerPosition(input)

		v61(UDim2.fromOffset(v95.X, v95.Y))
	end)
	local connection3 = RunService.RenderStepped:Connect(function() -- line: 319
		-- upvalues: preferredInputSource (copy), getPointerPosition (copy), v61 (copy)
		if preferredInputSource() == Enum.PreferredInput.Gamepad then
			local v96 = getPointerPosition(nil)

			v61(UDim2.fromOffset(v96.X, v96.Y))
		end
	end)

	Vide.cleanup(function() -- line: 325
		-- upvalues: connection (copy), connection2 (copy), connection3 (copy)
		connection:Disconnect()
		connection2:Disconnect()
		connection3:Disconnect()
	end)

	local v72 = ImageLabel
	local t2 = {
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(28, 22, 107, 100),
		Size = UDim2.fromOffset(vector2_3.X, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = v61,
		ZIndex = 9999999
	}
	local t3 = {
		Size = 3,
		LayoutOrder = 1
	}
	local v75 = Frame({
		Size = UDim2.new(1, 0, 0, t3.Size),
		LayoutOrder = t3.LayoutOrder
	})
	local v76 = TextLabel({
		Name = "SlimeName",
		LayoutOrder = 2,
		Text = function() --[[ Text ]] -- line: 344
			-- upvalues: Mutations (copy), v62 (copy), v60 (copy)
			return Mutations.getDisplayName(v62().name, v60().mutations)
		end,
		Size = UDim2.new(1, 0, 0, 32),
		Stroke = {}
	})
	local v77 = TextLabel({
		Name = "Odds",
		LayoutOrder = 10,
		Text = function() --[[ Text ]] -- line: 354
			-- upvalues: Abbreviate (copy), v63 (copy)
			return `1/{ Abbreviate((math.ceil(1 / v63()))) }`
		end,
		Size = UDim2.new(1, 0, 0, 26),
		Stroke = {
			Color = color3
		},
		Gradient = {
			Rotation = 90,
			Color = v64
		}
	})
	local v78 = TextLabel({
		Name = "Rarity",
		LayoutOrder = 12,
		Text = function() --[[ Text ]] -- line: 365
			-- upvalues: v65 (copy)
			return v65().name
		end,
		Size = UDim2.new(1, 0, 0, 24),
		Stroke = {
			Color = color3
		},
		Gradient = {
			Rotation = 90,
			Color = function() --[[ Color ]] -- line: 372
				-- upvalues: v65 (copy)
				return v65().gradient
			end
		}
	})
	local v79 = Divider(18)
	local t4 = {
		Size = 6,
		LayoutOrder = 20
	}
	local v81 = Frame({
		Size = UDim2.new(1, 0, 0, t4.Size),
		LayoutOrder = t4.LayoutOrder
	})
	local v82 = StatLabel({
		Name = "Damage",
		LayoutOrder = 24,
		Text = function() --[[ Text ]] -- line: 385
			-- upvalues: Abbreviate (copy), InventoryServiceUtils (copy), v66 (copy)
			return Abbreviate((math.round((InventoryServiceUtils.getDpsFromStats(v66())))))
		end,
		Icon = ImageIds.damageIcon
	})
	local v83 = StatLabel({
		Name = "Health",
		LayoutOrder = 26,
		Text = function() --[[ Text ]] -- line: 394
			-- upvalues: Abbreviate (copy), v66 (copy)
			return Abbreviate(v66().maxHealth)
		end,
		Icon = ImageIds.healthIcon
	})
	local v84 = TextLabel({
		Name = "Level",
		LayoutOrder = 30,
		TextSize = 20,
		Text = function() --[[ Text ]] -- line: 403
			-- upvalues: v67 (copy)
			return `Level { v67().level }`
		end,
		Size = UDim2.new(0.86, 0, 0, 30),
		Stroke = {}
	})
	local v85 = Vide.show(function() -- line: 412
		-- upvalues: v67 (copy)
		return v67().showBar
	end, function() -- line: 414
		-- upvalues: XpBar (copy), v67 (copy)
		return XpBar(v67)
	end)
	local t5 = {
		Size = 36,
		LayoutOrder = 999
	}
	local v87 = Frame({
		Size = UDim2.new(1, 0, 0, t5.Size),
		LayoutOrder = t5.LayoutOrder
	})

	t2[1] = v75
	t2[2] = v76
	t2[3] = v77
	t2[4] = v78
	t2[5] = v79
	t2[6] = v81
	t2[7] = v82
	t2[8] = v83
	t2[9] = v84
	t2[10] = v85
	t2[11] = v87
	v97(t2, 12, UIListLayout({
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 0)
	}))

	return v72(t2)
end

return {
	Component = function() --[[ Component ]] -- line: 428
		-- upvalues: Vide (copy), v22 (copy), HoverInfo (copy)
		return Vide.show(v22, HoverInfo)
	end,
	setSlimeData = function(p3) --[[ setSlimeData ]] -- line: 31
		-- upvalues: v22 (copy)
		v22(p3)
	end
}
