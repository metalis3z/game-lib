-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Menu, time of decompilation: Sun May  3 10:11:11 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local NotificationBadge = require(ReplicatedStorage.Source.Features.App.Components.NotificationBadge)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local v17 = Vide.source(nil)
local u18 = nil
local menuId = nil
local t1 = {
	"Title",
	"menuId",
	"SideBarButtons",
	"CurrentPageSource",
	"Pages",
	"Scale",
	"SetCurrentPage",
	"ShowTitle",
	"ShowCloseButton",
	"OnClose"
}

local function getDefaultPageId(t2: {[any]: any}) -- line: 96
	if t2.SideBarButtons and t2.SideBarButtons[t2.menuId] ~= nil then
		return t2.menuId
	end

	if t2.Pages and t2.Pages[t2.menuId] ~= nil then
		return t2.menuId
	end

	local menuId2 = t2.menuId
	local n1 = 1e999

	if t2.SideBarButtons then
		for v28, v29 in t2.SideBarButtons do
			local v30 = v29.LayoutOrder or 1e999

			if v30 < n1 then
				n1 = v30
				menuId2 = v28
			end
		end

		return menuId2
	end

	if t2.Pages then
		for v31 in t2.Pages do
			return v31
		end
	end

	return menuId2
end
local function SideBarButtons(t3: {[any]: any}, p1: ((...any) -> ...any), p2: ((...any) -> ...any)) -- line: 127
	-- upvalues: Button (copy), ImageIds (copy), SlimeIcon (copy), ImageLabel (copy), TextLabel (copy), NotificationBadge (copy), Frame (copy), Vide (copy), UIListLayout (copy)
	local t4 = {}

	for v36, v37 in t3 do
		table.insert(t4, (Button({
			Image = function() --[[ Image ]] -- line: 131
				-- upvalues: p1 (copy), v36 (copy), ImageIds (copy)
				if p1() == v36 then
					return ImageIds.blackButtonWhiteOutline
				end

				return ImageIds.blackCheckeredButton
			end,
			LayoutOrder = v37.LayoutOrder,
			Size = UDim2.fromOffset(88, 92),
			Visible = v37.Visible,
			Activated = not v37.Activated and function() -- line: 143
				-- upvalues: p2 (copy), v36 (copy)
				p2(v36)
			end or v37.Activated,
			if v37.SlimeData == nil then ImageLabel({
				Image = v37.Image,
				Size = v37.ImageSize or UDim2.fromScale(0.65, 0.65),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.435),
				ScaleType = Enum.ScaleType.Fit
			}) else SlimeIcon({
				UseCanvasFrames = true,
				SlimeData = v37.SlimeData,
				Size = v37.ImageSize or UDim2.fromScale(0.72, 0.72),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.44)
			}),
			TextLabel({
				Text = v37.Text,
				Size = UDim2.fromScale(1, 0.24),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.fromScale(0.5, 0.85),
				Stroke = {},
				DropShadow = {}
			}),
			if not v37.NotificationCount then nil else NotificationBadge({
				ZIndex = 4,
				Count = v37.NotificationCount,
				Text = v37.NotificationBadgeText,
				Size = v37.NotificationBadgeSize or UDim2.fromOffset(20, 20),
				Position = v37.NotificationBadgePosition or UDim2.fromScale(0.18, 0.08),
				AnchorPoint = v37.NotificationBadgeAnchorPoint or Vector2.new(0.5, 0.5)
			})
		})))
	end

	return Frame({
		Size = UDim2.fromScale(0.12, 0.9),
		Position = UDim2.fromScale(0, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		Visible = function() --[[ Visible ]] -- line: 191
			-- upvalues: t3 (copy), Vide (copy)
			for _, v54 in t3 do
				if v54.Visible == nil or Vide.read(v54.Visible) then
					return true
				end
			end

			return false
		end,
		UIListLayout({
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 6)
		}),
		t4
	})
end

return {
	Component = function(t5: {[any]: any}) --[[ Menu ]] -- line: 212
		-- upvalues: Vide (copy), v17 (copy), screenCoveredSource (copy), getDefaultPageId (copy), RemoveKeys (copy), t1 (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), Button (copy), ConsoleHint (copy), u18 (ref), menuId (ref), SideBarButtons (copy), Frame (copy), SlideFrame (copy)
		local v39 = Vide.derive(function() -- line: 213
			-- upvalues: v17 (copy), t5 (copy), screenCoveredSource (copy)
			return v17() == t5.menuId and not screenCoveredSource()
		end)

		local function closeMenu() -- line: 216
			-- upvalues: t5 (copy), v17 (copy)
			if t5.OnClose then
				t5.OnClose()

				return
			end

			if v17() == t5.menuId then
				v17(nil)
			end
		end

		local v41 = Vide.source((getDefaultPageId(t5)))
		local v42 = RemoveKeys(t5, t1, true)
		local v43 = t5.Scale or 1

		v42.Shown = v39
		v42.Size = UDim2.fromOffset(871 * v43, 503.1 * v43)
		v42.AnchorPoint = Vector2.new(0.5, 0.5)
		v42.ShownPosition = UDim2.fromScale(0.5, 0.5)
		v42.HiddenPosition = UDim2.fromScale(0.5, 1.5)
		v42.Name = t5.menuId

		local v44 = ImageLabel({
			Name = "Background",
			ZIndex = 0,
			Image = ImageIds.menu,
			Size = UDim2.fromScale(1, 1)
		})
		local t6 = {
			Name = "Content",
			ZIndex = 2,
			Size = UDim2.new(1, -30, 1, -45),
			Position = UDim2.new(0.5, 0, 0, 10),
			AnchorPoint = Vector2.new(0.5, 0)
		}
		local v46 = TextLabel({
			Name = "Title",
			ZIndex = 99,
			Visible = t5.ShowTitle == nil or t5.ShowTitle,
			Text = function() --[[ Text ]] -- line: 267
				-- upvalues: t5 (copy), v41 (copy)
				if not t5.SideBarButtons then
					return t5.Title:upper()
				end

				local v56 = t5.SideBarButtons[if t5.CurrentPageSource == nil then v41() else t5.CurrentPageSource()]

				if v56 then
					return v56.Title or v56.Text:upper()
				end

				return t5.Title:upper()
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
			}
		})
		local v47 = Button({
			Image = ImageIds.xButton,
			Name = "CloseButton",
			Visible = t5.ShowCloseButton == nil or t5.ShowCloseButton,
			Size = UDim2.fromOffset(66, 69),
			Position = UDim2.new(1, -20, 0, 15),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 99,
			Activated = closeMenu,
			ConsoleHint({
				ZIndex = 100,
				KeyCode = Enum.KeyCode.ButtonB,
				Position = UDim2.fromScale(0.18, 0.2),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(28, 28)
			})
		})

		Vide.effect(function() -- line: 308
			-- upvalues: v39 (copy), u18 (ref), closeMenu (copy), menuId (ref), t5 (copy), Vide (copy)
			if not v39() then
				return
			end

			u18 = closeMenu
			menuId = t5.menuId
			Vide.cleanup(function() -- line: 316
				-- upvalues: u18 (ref), closeMenu (copy), menuId (ref)
				if u18 == closeMenu then
					u18 = nil
					menuId = nil
				end
			end)
		end)

		for v48, v49 in t5 do
			if typeof(v48) == "number" then
				table.insert(t6, v49)
			end
		end

		if t5.SideBarButtons then
			table.insert(v42, SideBarButtons(t5.SideBarButtons, function() --[[ page ]] -- line: 225
				-- upvalues: t5 (copy), v41 (copy)
				if t5.CurrentPageSource ~= nil then
					return t5.CurrentPageSource()
				end

				return v41()
			end, function(s1: string) --[[ setPage ]] -- line: 232
				-- upvalues: t5 (copy), v41 (copy)
				if t5.SetCurrentPage ~= nil then
					t5.SetCurrentPage(s1)

					return
				end

				v41(s1)
			end))
		end

		if t5.Pages then
			for v50, v51 in t5.Pages do
				local v52 = if type(v51) ~= "function" then v51 else v51()

				table.insert(v42, (Frame({
					Name = "Page" .. v50 .. "Content",
					Size = UDim2.new(1, -30, 1, -45),
					Position = UDim2.new(0.5, 0, 0, 10),
					AnchorPoint = Vector2.new(0.5, 0),
					ZIndex = 2,
					Visible = function() --[[ Visible ]] -- line: 343
						-- upvalues: t5 (copy), v41 (copy), v50 (copy)
						return ((if t5.CurrentPageSource == nil then v41() else t5.CurrentPageSource())) == v50
					end,
					v52
				})))
			end
		end

		table.insert(v42, v47)
		table.insert(v42, v46)
		table.insert(v42, v44)
		table.insert(v42, Frame(t6))

		return SlideFrame(v42)
	end,
	openedMenu = v17,
	setOpenedMenu = function(s2: string?, b1: boolean?) --[[ setOpenedMenu ]] -- line: 25
		-- upvalues: TutorialServiceClient (copy), ErrorMessages (copy), v17 (copy)
		if not TutorialServiceClient:canOpenMenu(s2) then
			if s2 ~= nil and not b1 then
				ErrorMessages.add("That menu is locked during the tutorial.")
			end

			return
		end

		if s2 == v17() then
			v17(nil)

			return
		end

		v17(s2)
	end,
	closeCurrentMenu = function() --[[ closeCurrentMenu ]] -- line: 40
		-- upvalues: u18 (ref), menuId (ref), v17 (copy)
		if u18 ~= nil and menuId == v17() then
			u18()

			return
		end

		if v17() ~= nil then
			v17(nil)
		end
	end
}
