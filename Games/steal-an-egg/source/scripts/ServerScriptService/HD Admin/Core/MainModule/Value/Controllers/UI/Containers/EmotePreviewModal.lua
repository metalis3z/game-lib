--!strict
-- LOCAL 
local Lighting = game:GetService("Lighting")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Viewport = require(frontend.Config.Viewport)
local EmotePreview = require(frontend.Config.EmotePreview)
local EmotePreviewBody = require(frontend.Components.EmotePreviewBody)
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type Props = {}


-- COMPONENT
-- The emote unlock popup
return function(scope: Scope, props: Props)
	local state = EmotePreview.getState()
	local isOpen = scope:Computed(function(use)
		return state ~= nil and use(state) ~= nil
	end)

	local backdropTransparency = scope:Computed(function(use)
		return if use(isOpen) then 0.2 else 1
	end)

	local blurSize = scope:Spring(scope:Computed(function(use)
		return if use(isOpen) then 18 else 0
	end), 30, 1)
	scope:New "BlurEffect" {
		Name = "HDEmotePreviewBlur",
		Parent = Lighting,
		Size = blurSize,
		Enabled = scope:Computed(function(use)
			return use(blurSize) > 0.1
		end),
	}

	local emotesFuse = (scope :: any):Fuse("everyone", "Emotes")
	local titleText = scope:Computed(function(use)
		local current = if state then use(state) else nil
		if not current then return "Emote" end
		if typeof(current.emoteName) == "string" and current.emoteName ~= "" then
			return current.emoteName
		end
		local catalog = use(emotesFuse)
		local record: any = if typeof(catalog) == "table" then (catalog :: any)[tostring(current.emoteId)] else nil
		return if record and record.name then record.name else "Emote"
	end)

	return scope:New "Frame" {
		Name = "EmotePreviewModal",
		Active = false,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = isOpen,
		ZIndex = 10,

		[Children] = {
			scope:New "TextButton" {
				Name = "Backdrop",
				Active = true,
				AutoButtonColor = false,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40),
				BackgroundTransparency = backdropTransparency,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Size = UDim2.fromScale(1, 1),
				Text = "",
				TextColor3 = Color3.new(),
				TextSize = 1,
				[Fusion.OnEvent "Activated"] = function()
					EmotePreview.close()
				end,
			},

			scope:New "Frame" {
				Name = "CardHolder",
				AnchorPoint = Vector2.new(0.5, 0.5),
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 0.5),

				[Children] = {
					scope:New "UIScale" { Scale = Viewport.Scale },

					scope:Computed(function(use, innerScope: Scope)
						local current = if state then use(state) else nil
						if not current then return nil end
						-- A TextButton (not a Frame) so clicks on the card sink here instead of
						-- falling through to the backdrop and closing the popup
						return innerScope:New "TextButton" {
							Name = "Card",
							AutoButtonColor = false,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundColor3 = Theme.Color.Base,
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
							Size = UDim2.fromOffset(320, 0),
							Text = "",
							TextColor3 = Color3.new(),
							TextSize = 1,

							[Children] = {
								innerScope:New "UICorner" { CornerRadius = UDim.new(0, 12) },
								innerScope:New "UIStroke" {
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Theme.Color.NeutralStroke,
									Transparency = 0.5,
								},
								innerScope:New "UIPadding" {
									PaddingBottom = UDim.new(0, 14),
									PaddingLeft = UDim.new(0, 14),
									PaddingRight = UDim.new(0, 14),
									PaddingTop = UDim.new(0, 12),
								},
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Vertical,
									HorizontalFlex = Enum.UIFlexAlignment.Fill,
									Padding = UDim.new(0, 12),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},

								innerScope:New "Frame" {
									Name = "TitleRow",
									BackgroundTransparency = 1,
									LayoutOrder = 1,
									Size = UDim2.new(1, 0, 0, 28),
									[Children] = {
										innerScope:New "TextLabel" {
											Name = "Title",
											AnchorPoint = Vector2.new(0.5, 0.5),
											BackgroundTransparency = 1,
											FontFace = innerScope:Computed(function(use)
												return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Bold))
											end),
											Position = UDim2.fromScale(0.5, 0.5),
											Size = UDim2.new(1, -64, 1, 0),
											Text = titleText,
											TextColor3 = Theme.Color.BaseContent,
											TextSize = Theme.TextSize.Title,
											TextTruncate = Enum.TextTruncate.AtEnd,
											TextXAlignment = Enum.TextXAlignment.Center,
										},
										Pressable(innerScope, {
											name = "Close",
											size = UDim2.fromOffset(28, 28),
											automaticSize = Enum.AutomaticSize.None,
											anchorPoint = Vector2.new(1, 0.5),
											position = UDim2.fromScale(1, 0.5),
											iconImage = Icons.Close,
											iconColor = Theme.Color.NeutralContentMain,
											iconSize = 16,
											onActivate = function()
												EmotePreview.close()
											end,
										}),
									},
								},

								EmotePreviewBody(innerScope, {
									emoteId = current.emoteId,
									animationId = current.animationId,
									layoutOrder = 2,
								}),
							},
						}
					end),
				},
			},
		},
	}
end
