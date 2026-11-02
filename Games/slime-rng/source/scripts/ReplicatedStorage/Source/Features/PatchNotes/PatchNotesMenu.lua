-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PatchNotesMenu, time of decompilation: Sun May  3 10:12:21 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local VersionUtils = require(ReplicatedStorage.Source.Core.Util.VersionUtils)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local PatchNotes = require(ReplicatedStorage.Source.Features.PatchNotes.PatchNotes)
local indexes = Vide.indexes
local create = Vide.create
local v12 = Vide.source(1)
local t1 = {}

for v14, v15 in PatchNotes do
	table.insert(t1, {
		ver = v14,
		note = v15
	})
end

table.sort(t1, function(t2: {[any]: any}, t3: {[any]: any}) -- line: 37
	-- upvalues: VersionUtils (copy)
	return VersionUtils.newerThan(t2.ver, t3.ver)
end)

local function PatchNoteButton(t4: {[any]: any}) -- line: 41
	-- upvalues: Button (copy), v12 (copy), StylizedFrame (copy), TextLabel (copy)
	return Button({
		Name = `PatchNoteButton_{ t4.Order }`,
		Size = UDim2.new(0.9, 0, 0, 72),
		BackgroundTransparency = 1,
		HoverScale = 0.98,
		LayoutOrder = t4.Order,
		Activated = function() --[[ Activated ]] -- line: 48
			-- upvalues: v12 (copy), t4 (copy)
			v12(t4.Order)
		end,
		StylizedFrame({
			Theme = "Black",
			Size = UDim2.fromScale(1, 1.08),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageColor3 = function() --[[ ImageColor3 ]] -- line: 57
				-- upvalues: v12 (copy), t4 (copy)
				if v12() == t4.Order then
					return Color3.fromRGB(255, 255, 255)
				end

				return Color3.fromRGB(89, 90, 95)
			end,
			TextLabel({
				ZIndex = 2,
				Text = t4.Entry.note.title,
				Size = UDim2.fromScale(0.82, 0.42),
				Position = UDim2.fromScale(0.5, 0.12),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {
					Thickness = 2
				},
				DropShadow = {}
			}),
			TextLabel({
				TextSize = 18,
				ZIndex = 2,
				Text = "V " .. t4.Entry.ver,
				Size = UDim2.fromScale(0.9, 0.26),
				Position = UDim2.fromScale(0.5, 0.78),
				AnchorPoint = Vector2.new(0.5, 1),
				Stroke = {
					Thickness = 2
				}
			})
		})
	})
end
local function PatchNoteSelector() -- line: 88
	-- upvalues: t1 (copy), PatchNoteButton (copy), StylizedFrame (copy), create (copy)
	local t5 = {}

	for i, v in ipairs(t1) do
		table.insert(t5, PatchNoteButton({
			Entry = v,
			Order = i
		}))
	end

	return StylizedFrame({
		Theme = "Black",
		Name = "PatchNoteSelector",
		Size = UDim2.fromScale(0.33, 0.9),
		Position = UDim2.fromScale(0.01, 0.05),
		AnchorPoint = Vector2.new(0, 0),
		create("ScrollingFrame")({
			Name = "PatchNoteSelectorList",
			Size = UDim2.fromScale(0.96, 0.96),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 0,
			ScrollBarImageTransparency = 1,
			create("UIPadding")({
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4)
			}),
			create("UIListLayout")({
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top
			}),
			t5
		})
	})
end
local function PatchNoteDetailLine(p1, n1: number) -- line: 139
	-- upvalues: TextLabel (copy)
	return TextLabel({
		TextWrapped = true,
		TextSize = 20,
		ZIndex = 2,
		Text = function() --[[ Text ]] -- line: 141
			-- upvalues: p1 (copy)
			return "- " .. p1()
		end,
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = n1,
		Stroke = {
			Thickness = 1
		}
	})
end
local function NoteDetails() -- line: 156
	-- upvalues: Vide (copy), t1 (copy), v12 (copy), Frame (copy), TextLabel (copy), create (copy), indexes (copy), PatchNoteDetailLine (copy)
	local v28 = Vide.derive(function() -- line: 157
		-- upvalues: t1 (copy), v12 (copy)
		if #t1 == 0 then
			return nil
		end

		return t1[math.clamp(v12(), 1, #t1)]
	end)
	local v29 = Vide.derive(function() -- line: 165
		-- upvalues: v28 (copy)
		local v30 = v28()

		if v30 == nil then
			return {}
		end

		return v30.note.notes
	end)

	return Frame({
		Name = "PatchNoteDetails",
		Visible = function() --[[ Visible ]] -- line: 176
			-- upvalues: v28 (copy)
			return v28() ~= nil
		end,
		Size = UDim2.fromScale(0.63, 0.9),
		Position = UDim2.fromScale(0.98, 0.05),
		AnchorPoint = Vector2.new(1, 0),
		TextLabel({
			ZIndex = 2,
			Text = function() --[[ Text ]] -- line: 184
				-- upvalues: v28 (copy)
				local v31 = v28()

				if v31 then
					return v31.note.title
				end

				return ""
			end,
			Size = UDim2.fromScale(0.82, 0.1),
			Position = UDim2.fromScale(0.5, 0.015),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2
			},
			DropShadow = {}
		}),
		TextLabel({
			TextSize = 20,
			ZIndex = 2,
			Text = function() --[[ Text ]] -- line: 197
				-- upvalues: v28 (copy)
				local v32 = v28()

				if v32 == nil then
					return ""
				end

				return `{ v32.note.date }    V{ v32.ver }`
			end,
			Size = UDim2.fromScale(0.9, 0.075),
			Position = UDim2.fromScale(0.5, 0.105),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2
			}
		}),
		create("ScrollingFrame")({
			Name = "PatchNoteDetailsList",
			Size = UDim2.fromScale(0.95, 0.78),
			Position = UDim2.fromScale(0.5, 0.57),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			CanvasSize = UDim2.fromScale(0, 2),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 0,
			ScrollBarImageTransparency = 1,
			create("UIListLayout")({
				Padding = UDim.new(0, 14),
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			}),
			create("UIPadding")({
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8)
			}),
			indexes(v29, PatchNoteDetailLine)
		})
	})
end

return {
	menuId = "patchNotes",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 244
		-- upvalues: Menu (copy), PatchNoteSelector (copy), NoteDetails (copy)
		return Menu.Component({
			menuId = "patchNotes",
			Title = "Update Log",
			PatchNoteSelector(),
			NoteDetails()
		})
	end
}
