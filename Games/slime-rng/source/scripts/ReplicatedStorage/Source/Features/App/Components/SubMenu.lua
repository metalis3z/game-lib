-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SubMenu, time of decompilation: Sun May  3 10:11:15 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local v13 = Vide.source(nil)
local u14 = nil
local u15 = nil
local t1 = {
	"Title",
	"subMenuId",
	"menuId",
	"Scale",
	"ShowTitle",
	"ShowCloseButton",
	"OnClose",
	"ParentMenuId",
	"ShownPosition",
	"HiddenPosition"
}

return {
	Component = function(p1) --[[ SubMenu ]] -- line: 70
		-- upvalues: Vide (copy), Menu (copy), screenCoveredSource (copy), v13 (copy), RemoveKeys (copy), t1 (copy), u14 (ref), u15 (ref), ImageLabel (copy), ImageIds (copy), Frame (copy), TextLabel (copy), Button (copy), ConsoleHint (copy), SlideFrame (copy)
		local v20 = assert(p1.subMenuId or p1.menuId, "SubMenu requires subMenuId or menuId")
		local v21 = Vide.derive(function() -- line: 72
			-- upvalues: Menu (copy), screenCoveredSource (copy), p1 (copy), v13 (copy), v20 (copy)
			local v29 = Menu.openedMenu()

			if v29 == nil or screenCoveredSource() then
				return false
			end

			if p1.ParentMenuId ~= nil and v29 ~= p1.ParentMenuId then
				return false
			end

			return v13() == v20
		end)

		local function closeSubMenu() -- line: 83
			-- upvalues: p1 (copy), v13 (copy), v20 (copy)
			if p1.OnClose then
				p1.OnClose()

				return
			end

			if v13() == v20 then
				v13(nil)
			end
		end

		local v23 = RemoveKeys(p1, t1, true)
		local v24 = p1.Scale or 1
		local v25 = type(p1.ZIndex) ~= "number" and 200 or p1.ZIndex

		v23.Shown = v21
		v23.Size = p1.Size or UDim2.fromOffset(544 * v24, 366 * v24)
		v23.AnchorPoint = p1.AnchorPoint or Vector2.new(0.5, 0.5)
		v23.ShownPosition = p1.ShownPosition or UDim2.fromScale(0.5, 0.5)
		v23.HiddenPosition = p1.HiddenPosition or UDim2.fromScale(0.5, 1.5)
		v23.Name = p1.Name or v20
		v23.ZIndex = p1.ZIndex or v25

		local t2 = {
			Name = "Content",
			Size = UDim2.new(1, -34, 1, -58),
			Position = UDim2.new(0.5, 0, 0, 20),
			AnchorPoint = Vector2.new(0.5, 0),
			ZIndex = v25 + 2
		}

		for v27, v28 in p1 do
			if typeof(v27) == "number" then
				table.insert(t2, v28)
			end
		end

		Vide.effect(function() -- line: 116
			-- upvalues: v21 (copy), u14 (ref), closeSubMenu (copy), u15 (ref), v20 (copy), Vide (copy)
			if not v21() then
				return
			end

			u14 = closeSubMenu
			u15 = v20
			Vide.cleanup(function() -- line: 124
				-- upvalues: u14 (ref), closeSubMenu (copy), u15 (ref)
				if u14 == closeSubMenu then
					u14 = nil
					u15 = nil
				end
			end)
		end)
		table.insert(v23, ImageLabel({
			Name = "Background",
			Image = ImageIds.subMenu,
			Size = UDim2.fromScale(1, 1),
			ZIndex = v25
		}))
		table.insert(v23, Frame(t2))
		table.insert(v23, TextLabel({
			Name = "Title",
			Visible = if p1.ShowTitle ~= nil then p1.ShowTitle else p1.Title ~= nil,
			Text = function() --[[ Text ]] -- line: 149
				-- upvalues: p1 (copy)
				return string.upper(p1.Title or "")
			end,
			Position = UDim2.fromOffset(-10, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.new(1, 0, 0, 60),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 4,
				LineJoinMode = Enum.LineJoinMode.Miter
			},
			DropShadow = {
				Offset = UDim2.fromOffset(5, 7)
			},
			ZIndex = v25 + 99
		}))
		table.insert(v23, Button({
			Image = ImageIds.xButton,
			Name = "CloseButton",
			Visible = p1.ShowCloseButton == nil or p1.ShowCloseButton,
			Size = UDim2.fromOffset(66, 69),
			Position = UDim2.new(1, -20, 0, 15),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = v25 + 99,
			Activated = closeSubMenu,
			ConsoleHint({
				KeyCode = Enum.KeyCode.ButtonB,
				Position = UDim2.fromScale(0.18, 0.2),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(28, 28),
				ZIndex = v25 + 100
			})
		}))

		return SlideFrame(v23)
	end,
	openedMenu = v13,
	setOpenedMenu = function(s1: string?) --[[ setOpenedMenu ]] -- line: 51
		-- upvalues: v13 (copy)
		if s1 == v13() then
			v13(nil)

			return
		end

		v13(s1)
	end,
	closeCurrentMenu = function() --[[ closeCurrentMenu ]] -- line: 59
		-- upvalues: u14 (ref), u15 (ref), v13 (copy)
		if u14 ~= nil and u15 == v13() then
			u14()

			return
		end

		if v13() ~= nil then
			v13(nil)
		end
	end
}
