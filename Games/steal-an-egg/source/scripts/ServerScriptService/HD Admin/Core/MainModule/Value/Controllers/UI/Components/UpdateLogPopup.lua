--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Popup = require(frontend.Components.Popup)
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)
local UpdateLog = require(frontend.Config.UpdateLog)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	visible: Fusion.Value<boolean>,
}


-- HELPERS
-- We convert lines starting with "- " into rows of bullets
local BULLET_GUTTER = 16

local function updateBodyBlocks(innerScope: Scope, body: string): {any}
	local bodyFont = innerScope:Computed(function(use)
		return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
	end)
	local blocks: {any} = {
		innerScope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},
	}
	local order = 0
	local paragraphLines: {string} = {}
	local function pushParagraph()
		if #paragraphLines == 0 then
			return
		end
		order += 1
		table.insert(blocks, innerScope:New "TextLabel" {
			Name = "Paragraph",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = bodyFont,
			LayoutOrder = order,
			RichText = true,
			Size = UDim2.new(1, 0, 0, 0),
			Text = table.concat(paragraphLines, "\n"),
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Body,
			TextTransparency = 0.1,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		})
		paragraphLines = {}
	end
	for line in string.gmatch(body .. "\n", "(.-)\n") do
		local bulletText = string.match(line, "^%s*%-%s+(.*)")
		if bulletText then
			pushParagraph()
			order += 1
			table.insert(blocks, innerScope:New "Frame" {
				Name = "Bullet",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = order,
				Size = UDim2.new(1, 0, 0, 0),
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					innerScope:New "TextLabel" {
						Name = "Point",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = bodyFont,
						LayoutOrder = 1,
						Size = UDim2.fromOffset(BULLET_GUTTER, 0),
						Text = "•",
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Body,
						TextTransparency = 0.1,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					},
					innerScope:New "TextLabel" {
						Name = "Text",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = bodyFont,
						LayoutOrder = 2,
						RichText = true,
						Size = UDim2.new(1, -BULLET_GUTTER, 0, 0),
						Text = bulletText,
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Body,
						TextTransparency = 0.1,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					},
				},
			})
		elseif line == "" then
			pushParagraph()
			order += 1
			table.insert(blocks, innerScope:New "Frame" {
				Name = "Gap",
				BackgroundTransparency = 1,
				LayoutOrder = order,
				Size = UDim2.new(1, 0, 0, 8),
			})
		else
			table.insert(paragraphLines, line)
		end
	end
	pushParagraph()
	return blocks
end

local function updateEntryChildren(innerScope: Scope, entry: UpdateLog.UpdateEntry): {any}
	local authorDateChildren: {any} = {
		innerScope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.None,
			VerticalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		},
	}
	if entry.AuthorName and entry.AuthorUserId then
		table.insert(authorDateChildren, innerScope:New "ImageLabel" {
			Name = "Avatar",
			BackgroundColor3 = Theme.Color.NeutralContent,
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(entry.AuthorUserId) .. "&w=48&h=48",
			LayoutOrder = 1,
			Size = UDim2.fromOffset(20, 20),
			[Children] = {
				innerScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
			},
		})
		table.insert(authorDateChildren, innerScope:New "TextLabel" {
			Name = "Name",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = innerScope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
			end),
			LayoutOrder = 2,
			Text = entry.AuthorName,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Small,
		})
	end
	table.insert(authorDateChildren, innerScope:New "TextLabel" {
		Name = "Date",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		FontFace = innerScope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		LayoutOrder = 3,
		Text = entry.Date,
		TextColor3 = Theme.Color.NeutralContentDark,
		TextSize = Theme.TextSize.Small,
	})

	local children: {any} = {
		innerScope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = UDim.new(0, 12),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},
		innerScope:New "Frame" {
			Name = "AuthorDate",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = authorDateChildren,
		},
	}
	if entry.Image then
		table.insert(children, innerScope:New "ImageLabel" {
			Name = "Banner",
			BackgroundTransparency = 1,
			Image = entry.Image,
			LayoutOrder = 2,
			ScaleType = Enum.ScaleType.Crop,
			Size = UDim2.new(1, 0, 0, 110),
			[Children] = {
				innerScope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			},
		})
	end
	table.insert(children, innerScope:New "Frame" {
		Name = "Body",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 4,
		Size = UDim2.new(1, 0, 0, 0),
		[Children] = updateBodyBlocks(innerScope, entry.Body),
	})
	return children
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local visible = props.visible

	-- Snap back to the newest entry whenever the log reopens
	local entryIndex: Fusion.Value<number> = scope:Value(1)
	scope:Observer(visible):onChange(function()
		if Fusion.peek(visible) then
			entryIndex:set(1)
		end
	end)

	-- Direction -1 pages toward newer entries, 1 toward older
	local function pageArrow(direction: number, layoutOrder: number): Instance
		local canGo = scope:Computed(function(use)
			local target = use(entryIndex) + direction
			return target >= 1 and target <= #UpdateLog
		end)
		return Pressable(scope, {
			name = if direction < 0 then "NewerButton" else "OlderButton",
			layoutOrder = layoutOrder,
			size = UDim2.fromOffset(20, 20),
			interactable = canGo,
			onActivate = function()
				local target = Fusion.peek(entryIndex) + direction
				if target >= 1 and target <= #UpdateLog then
					entryIndex:set(target)
				end
			end,
			[Children] = {
				scope:New "ImageLabel" {
					Name = "Icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = Icons.ArrowLeft,
					ImageColor3 = Theme.Color.BaseContent,
					ImageTransparency = scope:Computed(function(use)
						return if use(canGo) then 0 else 0.7
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Rotation = if direction > 0 then 180 else 0,
					Size = UDim2.fromOffset(13, 13),
				},
			},
		})
	end

	local updateLogTitle = scope:New "Frame" {
		Name = "UpdateLogTitle",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		[Children] = {
			-- Negative padding tucks the arrows slightly past the card's inset
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, -6),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalFlex = Enum.UIFlexAlignment.None,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			scope:New "Frame" {
				Name = "Arrows",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalFlex = Enum.UIFlexAlignment.None,
						VerticalFlex = Enum.UIFlexAlignment.None,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},
					pageArrow(-1, 1),
					pageArrow(1, 2),
				},
			},
			scope:New "TextLabel" {
				Name = "Title",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
				end),
				LayoutOrder = 3,
				Text = scope:Computed(function(use)
					local entry = UpdateLog[use(entryIndex)]
					return if entry then entry.Title else ""
				end),
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Subtitle,
			},
		},
	}

	local updateLogContent = scope:New "ScrollingFrame" {
		Name = "UpdateLogScroller",
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BottomImage = "rbxassetid://16547643439",
		CanvasSize = UDim2.new(),
		MidImage = "rbxassetid://16547330984",
		ScrollBarImageTransparency = 1,
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Size = UDim2.fromScale(1, 1),
		TopImage = "rbxassetid://16547667444",

		[Children] = {
			scope:Computed(function(use, innerScope)
				local entry = UpdateLog[use(entryIndex)]
				if not entry then
					return nil
				end
				return innerScope:New "Frame" {
					Name = "Entry",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0),
					[Children] = updateEntryChildren(innerScope, entry),
				}
			end),
		},
	}

	return Popup(scope, {
		visible = visible,
		title = "Update Log",
		titleContent = updateLogTitle,
		backdropTransparency = 1,
		cardSize = UDim2.fromScale(1, 1),
		content = { updateLogContent },
	})
end
