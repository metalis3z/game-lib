-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingIngredientSlot, time of decompilation: Sun May  3 10:12:27 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local SlimeHoverInfo = require(ReplicatedStorage.Source.Features.App.Components.SlimeHoverInfo)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	"RequiredSlimeData",
	"SelectedSlimeData",
	"Discovered",
	"EmptyText",
	"ShowLevel"
}

return function(p1) -- line: 26
	-- upvalues: RemoveKeys (copy), t1 (copy), ImageIds (copy), Vide (copy), SlimeHoverInfo (copy), SlimeButton (copy), Button (copy), SlimeIcon (copy), TextLabel (copy)
	local v12 = RemoveKeys(p1, t1)

	v12.Image = v12.Image or ImageIds.blackCheckeredButton
	v12.HoverScale = v12.HoverScale or 1.02

	local v13 = Vide.derive(function() -- line: 31
		-- upvalues: Vide (copy), p1 (copy)
		return Vide.read(p1.RequiredSlimeData)
	end)
	local v14 = Vide.derive(function() -- line: 34
		-- upvalues: p1 (copy), Vide (copy)
		if p1.SelectedSlimeData then
			return (Vide.read(p1.SelectedSlimeData))
		end

		return nil
	end)
	local v15 = Vide.derive(function() -- line: 37
		-- upvalues: v14 (copy)
		return v14() ~= nil
	end)
	local v16 = Vide.derive(function() -- line: 40
		-- upvalues: p1 (copy), Vide (copy)
		if p1.Discovered == nil then
			return true
		end

		return Vide.read(p1.Discovered)
	end)
	local v17 = Vide.derive(function() -- line: 47
		-- upvalues: p1 (copy), Vide (copy)
		return p1.ShowLevel ~= nil and Vide.read(p1.ShowLevel) == true
	end)

	function v12.OnEnter() -- line: 51
		-- upvalues: v16 (copy), v15 (copy), SlimeHoverInfo (copy), v14 (copy), v13 (copy), p1 (copy)
		if v16() and v15() then
			SlimeHoverInfo.setSlimeData(v14() or v13())
		else
			SlimeHoverInfo.setSlimeData(nil)
		end

		if p1.OnEnter then
			p1.OnEnter()
		end
	end
	function v12.OnLeave() -- line: 63
		-- upvalues: SlimeHoverInfo (copy), p1 (copy)
		SlimeHoverInfo.setSlimeData(nil)

		if p1.OnLeave then
			p1.OnLeave()
		end
	end

	v12.Name = v12.Name or "CraftingIngredientSlot"

	return Vide.show(v15, function() -- line: 72
		-- upvalues: SlimeButton (copy), v12 (copy), v14 (copy), v13 (copy), v17 (copy)
		return SlimeButton({
			IconScale = 0.72,
			Name = v12.Name,
			Image = v12.Image,
			Size = v12.Size,
			Position = v12.Position,
			AnchorPoint = v12.AnchorPoint,
			LayoutOrder = v12.LayoutOrder,
			ZIndex = v12.ZIndex,
			Visible = v12.Visible,
			Activated = v12.Activated,
			Rotation = v12.Rotation,
			BackgroundTransparency = v12.BackgroundTransparency,
			ImageColor3 = v12.ImageColor3,
			ImageTransparency = v12.ImageTransparency,
			Selectable = v12.Selectable,
			IconPosition = UDim2.fromScale(0.5, 0.76),
			SlimeData = function() --[[ SlimeData ]] -- line: 90
				-- upvalues: v14 (copy), v13 (copy)
				return v14() or v13()
			end,
			Amount = function() --[[ Amount ]] -- line: 93
				-- upvalues: v17 (copy)
				if v17() then
					return 1
				end

				return nil
			end,
			ShowLevel = v17
		})
	end, function() -- line: 102
		-- upvalues: Button (copy), v12 (copy), SlimeIcon (copy), v13 (copy), v16 (copy), TextLabel (copy), Vide (copy), p1 (copy)
		return Button({
			Name = v12.Name,
			Image = v12.Image,
			Size = v12.Size,
			Position = v12.Position,
			AnchorPoint = v12.AnchorPoint,
			LayoutOrder = v12.LayoutOrder,
			ZIndex = v12.ZIndex,
			Visible = v12.Visible,
			Activated = v12.Activated,
			HoverScale = v12.HoverScale,
			OnEnter = v12.OnEnter,
			OnLeave = v12.OnLeave,
			OnDown = v12.OnDown,
			OnUp = v12.OnUp,
			Rotation = v12.Rotation,
			BackgroundTransparency = v12.BackgroundTransparency,
			ImageColor3 = v12.ImageColor3,
			ImageTransparency = v12.ImageTransparency,
			Selectable = v12.Selectable,
			SlimeIcon({
				ZIndex = 1,
				SlimeData = v13,
				Size = UDim2.fromScale(0.72, 0.72),
				Position = UDim2.fromScale(0.5, 0.76),
				AnchorPoint = Vector2.new(0.5, 1),
				ImageColor3 = function() --[[ ImageColor3 ]] -- line: 129
					-- upvalues: v16 (copy)
					if v16() then
						return Color3.fromRGB(255, 255, 255)
					end

					return Color3.fromRGB(0, 0, 0)
				end,
				ImageTransparency = function() --[[ ImageTransparency ]] -- line: 136
					-- upvalues: v16 (copy)
					if v16() then
						return 0.5
					end

					return 0.7
				end
			}),
			TextLabel({
				Text = "+",
				BackgroundTransparency = 1,
				TextSize = 44,
				ZIndex = 4,
				Size = UDim2.new(1, 0, 0, 34),
				Position = UDim2.fromScale(0.5, 0.48),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {},
				DropShadow = {}
			}),
			TextLabel({
				TextWrapped = true,
				ZIndex = 4,
				Text = function() --[[ Text ]] -- line: 159
					-- upvalues: Vide (copy), p1 (copy)
					return Vide.read(p1.EmptyText) or "SLIME NEEDED"
				end,
				Size = UDim2.new(1, -8, 0, 34),
				Position = UDim2.new(0.5, 0, 1, -38),
				AnchorPoint = Vector2.new(0.5, 0),
				TextColor3 = Color3.fromRGB(255, 32, 80),
				Stroke = {}
			})
		})
	end)
end
