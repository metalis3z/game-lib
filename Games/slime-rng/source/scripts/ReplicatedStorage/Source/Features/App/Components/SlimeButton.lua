-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeButton, time of decompilation: Sun May  3 10:11:14 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DropShadow = require(script.Parent.DropShadow)
local SlimeHoverInfo = require(script.Parent.SlimeHoverInfo)
local SlimeIcon = require(script.Parent.SlimeIcon)
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)

require(ReplicatedStorage.Source.Core.UI.Primitives.Button)

local t1 = {
	"SlimeData",
	"Amount",
	"ShowLevel",
	"IconScale",
	"IconPosition",
	"IconColor3",
	"IconTransparency",
	"ShowHoverInfo"
}

return function(p1) -- line: 42
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), TextLabel (copy), SlimeIcon (copy), InventoryServiceUtils (copy), Abbreviate (copy), OddsGradients (copy), DropShadow (copy), SlimeHoverInfo (copy), Button (copy)
	local v14 = RemoveKeys(p1, t1)
	local v15 = p1.ShowHoverInfo == nil or p1.ShowHoverInfo
	local v16 = Vide.source(1)
	local v17, v18 = Vide.spring(v16, 1, 0.3)

	local function v19() -- line: 47
		-- upvalues: Vide (copy), p1 (copy)
		return Vide.read(p1.SlimeData)
	end

	v14.Name = v14.Name or "SlimeButton"

	if p1.Amount or p1.ShowLevel then
		table.insert(v14, (TextLabel({
			Text = function() --[[ Text ]] -- line: 54
				-- upvalues: Vide (copy), p1 (copy)
				if Vide.read(p1.ShowLevel) then
					return `Lv. { Vide.read(p1.SlimeData).level }`
				end

				local v24 = Vide.read(p1.Amount)

				if v24 == nil or v24 == 0 then
					return ""
				end

				return `x{ v24 }`
			end,
			TextColor3 = function() --[[ TextColor3 ]] -- line: 66
				-- upvalues: Vide (copy), p1 (copy)
				if Vide.read(p1.ShowLevel) then
					return Color3.fromRGB(60, 144, 255)
				end

				return Color3.fromRGB(255, 255, 255)
			end,
			Stroke = {},
			Size = UDim2.fromScale(0.5, 0.2),
			TextXAlignment = Enum.TextXAlignment.Right,
			Position = UDim2.fromScale(1, 0),
			AnchorPoint = Vector2.new(1, 0)
		})))
	end

	local v20 = SlimeIcon({
		ZIndex = 0,
		SlimeData = p1.SlimeData,
		Size = function() --[[ Size ]] -- line: 85
			-- upvalues: Vide (copy), p1 (copy), v17 (copy)
			local v25 = Vide.read(p1.IconScale) or 1

			return UDim2.fromScale(v25, v25 * v17())
		end,
		Position = p1.IconPosition or UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		ImageColor3 = p1.IconColor3,
		ImageTransparency = p1.IconTransparency
	})
	local v21 = Vide.derive(function() -- line: 96
		-- upvalues: InventoryServiceUtils (copy), v19 (copy)
		return InventoryServiceUtils.getVisualOdds(v19())
	end)
	local v22 = TextLabel({
		Text = function() --[[ Text ]] -- line: 101
			-- upvalues: Abbreviate (copy), v21 (copy)
			return `1/{ Abbreviate((math.ceil(1 / v21()))) }`
		end,
		Size = UDim2.fromScale(0.75, 0.25),
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(1, 1),
		Stroke = {
			Thickness = 3,
			Color = Color3.fromRGB(61, 61, 61)
		},
		Gradient = {
			Rotation = 90,
			Color = function() --[[ Color ]] -- line: 111
				-- upvalues: OddsGradients (copy), v21 (copy)
				return OddsGradients.getGradient(v21())
			end
		}
	})
	local v23 = DropShadow({
		ZIndex = -3,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0.2)
	})

	function v14.OnEnter() -- line: 123
		-- upvalues: v15 (copy), SlimeHoverInfo (copy), Vide (copy), p1 (copy), v18 (copy)
		if v15 then
			SlimeHoverInfo.setSlimeData(Vide.read(p1.SlimeData))
		end

		v18({
			impulse = -2
		})
	end
	function v14.OnLeave() -- line: 130
		-- upvalues: v15 (copy), SlimeHoverInfo (copy), v16 (copy)
		if v15 then
			SlimeHoverInfo.setSlimeData(nil)
		end

		v16(1)
	end
	function v14.OnDown() -- line: 137
		-- upvalues: v16 (copy)
		v16(0.66)
	end
	function v14.OnUp() -- line: 141
		-- upvalues: v16 (copy)
		v16(1)
	end

	v14.HoverScale = 1
	table.insert(v14, v23)
	table.insert(v14, v22)
	table.insert(v14, v20)

	return Button(v14)
end
