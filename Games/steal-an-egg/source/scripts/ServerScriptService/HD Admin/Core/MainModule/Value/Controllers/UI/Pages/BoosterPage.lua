--!strict
-- CONFIG
local OFFER_DURATION = 900 -- matches the server's discount window
local UNLOCK_SPIN_SPEED = 240 -- degrees per second the unlock outline turns
local HERO_COUNT = 50 -- the "50+" figure that counts up on open
local HERO_DURATION = 0.7 -- seconds the count-up takes
local BODY_LIFT = 4


-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Panels = require(frontend.Config.Panels)
local Pressable = require(frontend.Components.Pressable)
local OutfitsButton = require(frontend.Components.OutfitsButton)
local Prompt = require(modules.Prompt)
local products = require(modules.References.products)
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
local Children = Fusion.Children

local SELLING_POINTS = {
	{icon = Icons.ZapFill, text = "Unlock exclusive fun commands"},
	{icon = Icons.GlobeFill, text = "Use in thousands of Roblox games"},
	{icon = Icons.HeartFill, text = "Support this game and HD Admin", subMessage = "(40% of your purchase goes to this game)"},
}

-- Deliberately off-theme so the button pops, the two ends match so the spin never seams
local UNLOCK_RAINBOW = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 84, 175)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 205, 84)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(84, 224, 255)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(150, 120, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 175)),
})


-- PRICE CACHE
-- Warmed at module load so the first open usually already has them
local cachedFullPrice: number? = nil
local cachedDiscountPrice: number? = nil
local pricesReady = false
local function fetchBoosterPricesOnce()
	if pricesReady then
		return
	end
	local function fetchPrice(assetId: number): number?
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
		end)
		if ok and typeof(info) == "table" then
			return tonumber((info :: any).PriceInRobux)
		end
		return nil
	end
	local full = fetchPrice(products.Booster.id)
	local discounted = fetchPrice(products.BoosterDiscount.id)
	-- Locked only once both resolved, so a failed fetch retries next open
	if full and discounted then
		cachedFullPrice = full
		cachedDiscountPrice = discounted
		pricesReady = true
	end
end
task.spawn(fetchBoosterPricesOnce)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	idle: UsedAs<boolean>?,
}


-- HELPERS
local function makeSellingPoint(scope: Scope, layoutOrder: number, point: {icon: string, text: string, subMessage: string?})
	-- Width is fixed (28 chip + 12 gap) so the text wraps instead of clipping
	local textChildren: {any} = {
		scope:New "UIListLayout" {
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},
		scope:New "TextLabel" {
			Name = "Line",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 0),
			Text = point.text,
			TextColor3 = Theme.Color.NeutralContentMain,
			TextSize = Theme.TextSize.Label,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
	}
	if point.subMessage then
		table.insert(textChildren, scope:New "TextLabel" {
			Name = "SubMessage",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			LayoutOrder = 2,
			Size = UDim2.fromScale(1, 0),
			Text = point.subMessage,
			TextColor3 = Theme.Color.NeutralContentDark,
			TextSize = Theme.TextSize.Small,
			TextTransparency = 0.45,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end
	return scope:New "Frame" {
		Name = "Point",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromScale(1, 0),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalFlex = Enum.UIFlexAlignment.None,
				Padding = UDim.new(0, 12),
				SortOrder = Enum.SortOrder.LayoutOrder,
				-- A multi-line row pins the chip to the top so it sits by the first line
				VerticalAlignment = if point.subMessage then Enum.VerticalAlignment.Top else Enum.VerticalAlignment.Center,
			},
			scope:New "Frame" {
				Name = "IconChip",
				BackgroundColor3 = Theme.Color.Primary,
				BackgroundTransparency = 0.82,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(28, 28),
				[Children] = {
					scope:New "UICorner" {
						CornerRadius = UDim.new(0, 6),
					},
					scope:New "ImageLabel" {
						Name = "Icon",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = point.icon,
						ImageColor3 = Theme.Color.Primary,
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(16, 16),
					},
				},
			},
			scope:New "Frame" {
				Name = "Text",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = UDim2.new(1, -40, 0, 0),
				[Children] = textChildren,
			},
		},
	}
end

local function makeSecondaryButton(scope: Scope, layoutOrder: number, label: string, onActivate: () -> (), size: UDim2?)
	return Pressable(scope, {
		name = label .. "Button",
		backgroundColor = Theme.Color.Neutral,
		size = size or UDim2.new(1, 0, 0, 44),
		automaticSize = Enum.AutomaticSize.None,
		layoutOrder = layoutOrder,
		onActivate = onActivate,
		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
				Transparency = 0.5,
			},
			scope:New "TextLabel" {
				Name = "Label",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
				end),
				Position = UDim2.fromScale(0.5, 0.5),
				Text = label,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Subtitle,
			},
		},
	})
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local offerStartFuse = scope:Fuse("perm", "OfferStartTime")
	local timeNow = scope:Value(os.time())
	local offerSecondsLeft = scope:Computed(function(use): number
		local startTime = use(offerStartFuse)
		if typeof(startTime) ~= "number" or startTime <= 0 then
			return 0
		end
		return math.max(0, OFFER_DURATION - (use(timeNow) - startTime))
	end)
	local offerActive = scope:Computed(function(use)
		return use(offerSecondsLeft) > 0
	end)

	local destroyed = false

	-- An ease-out lands exactly on 50, a spring's slow tail hangs a beat short
	local heroValue = scope:Value(0)
	do
		local elapsed = 0
		local connection: RBXScriptConnection
		connection = RunService.Heartbeat:Connect(function(deltaTime: number)
			if destroyed then
				connection:Disconnect()
				return
			end
			elapsed += deltaTime
			local alpha = math.min(elapsed / HERO_DURATION, 1)
			heroValue:set(HERO_COUNT * (1 - (1 - alpha) ^ 3))
			if alpha >= 1 then
				heroValue:set(HERO_COUNT)
				connection:Disconnect()
			end
		end)
		table.insert(scope, connection)
	end

	task.spawn(function()
		while not destroyed do
			task.wait(1)
			if not destroyed and Fusion.peek(offerActive) then
				timeNow:set(os.time())
			end
		end
	end)

	local fullPrice: Fusion.Value<number?> = scope:Value(cachedFullPrice)
	local discountPrice: Fusion.Value<number?> = scope:Value(cachedDiscountPrice)
	if not pricesReady then
		task.spawn(function()
			fetchBoosterPricesOnce()
			if not destroyed and pricesReady then
				fullPrice:set(cachedFullPrice)
				discountPrice:set(cachedDiscountPrice)
			end
		end)
	end

	local payPrice = scope:Computed(function(use): number?
		if use(offerActive) then
			return use(discountPrice) or use(fullPrice)
		end
		return use(fullPrice)
	end)
	local newPriceText = scope:Computed(function(use)
		local price = use(payPrice)
		return if price then tostring(price) else "..."
	end)
	local fullPriceText = scope:Computed(function(use)
		local full = use(fullPrice)
		return if full then tostring(full) else "..."
	end)
	local strikeColor = scope:Computed(function(use)
		return use(Theme.Color.Primary):Lerp(Color3.new(0, 0, 0), 0.28)
	end)
	local heroText = scope:Computed(function(use)
		return `{math.round(use(heroValue))}+`
	end)
	local heroTextSize = scope:Computed(function(use)
		return use(Theme.TextSize.Label) * 1.5
	end)
	local timerText = scope:Computed(function(use)
		local seconds = use(offerSecondsLeft)
		local clock = string.format("%d:%02d", math.floor(seconds / 60), seconds % 60)
		local primary = use(Theme.Color.Primary)
		local hex = string.format("%02X%02X%02X", math.floor(primary.R * 255 + 0.5), math.floor(primary.G * 255 + 0.5), math.floor(primary.B * 255 + 0.5))
		return `<font color="#{hex}" weight="Heavy">20% OFF!</font> Offer ends in {clock}`
	end)

	local function purchase()
		local productName: products.ProductName = if Fusion.peek(offerActive) then "BoosterDiscount" else "Booster"
		task.spawn(function()
			local success, warning = promptPurchaseAsync(productName)
			if not success and typeof(warning) == "string" and warning ~= "" then
				Prompt.warn(warning)
			end
		end)
	end

	local function viewCommands()
		Panels.openCommands(nil, true)
	end

	-- The gradient turns directly so the per-frame rotation stays off the Fusion graph
	local unlockGradient = scope:New "UIGradient" {
		Color = UNLOCK_RAINBOW,
	}
	local spin = 0
	table.insert(scope, RunService.Heartbeat:Connect(function(deltaTime: number)
		if not unlockGradient.Parent then
			return
		end
		spin = (spin + deltaTime * UNLOCK_SPIN_SPEED) % 360
		unlockGradient.Rotation = spin
	end))

	-- idle means the menu closed on another page so this wasn't the dismissal, and
	-- a silent close is a reopen rather than a walk-away
	table.insert(scope, function()
		destroyed = true
		local idle = if props.idle ~= nil then Fusion.peek(props.idle) else false
		if idle or Panels.consumeBoosterSilentClose() then
			return
		end
		Panels.notifyBoosterStackClosed("booster")
	end)

	return scope:New "Frame" {
		Name = "BoosterPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "Frame" {
				Name = "Background",
				BackgroundColor3 = Theme.Color.Base,
				ClipsDescendants = true,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 0,
				[Children] = {
					scope:New "UICorner" {
						CornerRadius = UDim.new(0, 6),
					},
					-- A darker floor so the card and CTA read as raised
					scope:New "Frame" {
						Name = "Recess",
						BackgroundColor3 = Theme.Color.NeutralDark,
						BackgroundTransparency = 0.35,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 0,
						[Children] = {
							scope:New "UICorner" {
								CornerRadius = UDim.new(0, 6),
							},
						},
					},
					-- A warm Primary glow bleeding down from the top
					scope:New "Frame" {
						Name = "Glow",
						BackgroundColor3 = Theme.Color.Primary,
						Size = UDim2.fromScale(1, 0.55),
						ZIndex = 1,
						[Children] = {
							scope:New "UICorner" {
								CornerRadius = UDim.new(0, 6),
							},
							scope:New "UIGradient" {
								Rotation = 90,
								Transparency = NumberSequence.new({
									NumberSequenceKeypoint.new(0, 0.72),
									NumberSequenceKeypoint.new(0.6, 0.9),
									NumberSequenceKeypoint.new(1, 1),
								}),
							},
						},
					},
				},
			},

			scope:New "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 14),
						PaddingBottom = UDim.new(0, 14),
						PaddingLeft = UDim.new(0, 14),
						PaddingRight = UDim.new(0, 14),
					},
					scope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						VerticalFlex = Enum.UIFlexAlignment.None,
						Padding = UDim.new(0, 14),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "Frame" {
						Name = "Header",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.fromScale(1, 0),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Center,
								Padding = UDim.new(0, 8),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "ImageLabel" {
								Name = "Logo",
								BackgroundTransparency = 1,
								Image = Icons.LogoGlyph,
								LayoutOrder = 1,
								Size = UDim2.fromOffset(24, 24),
							},
							scope:New "TextLabel" {
								Name = "Title",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
								end),
								LayoutOrder = 2,
								Text = "Extra",
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Title,
							},
						},
					},

					scope:New "Frame" {
						Name = "Body",
						BackgroundTransparency = 1,
						LayoutOrder = 2,
						Size = UDim2.fromScale(1, 0),
						[Children] = {
							scope:New "UIFlexItem" {
								FlexMode = Enum.UIFlexMode.Fill,
							},
							scope:New "UIPadding" {
								PaddingBottom = UDim.new(0, BODY_LIFT * 2),
							},
							scope:New "UIListLayout" {
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								VerticalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 12),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},

							scope:New "Frame" {
								Name = "HeroStat",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 1,
								Size = UDim2.fromScale(1, 0),
								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Horizontal,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
										Padding = UDim.new(0, 6),
										SortOrder = Enum.SortOrder.LayoutOrder,
										VerticalAlignment = Enum.VerticalAlignment.Center,
									},
									scope:New "TextLabel" {
										Name = "Count",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
										end),
										LayoutOrder = 1,
										Text = heroText,
										TextColor3 = Theme.Color.Primary,
										TextSize = heroTextSize,
									},
									scope:New "TextLabel" {
										Name = "CountLabel",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										LayoutOrder = 2,
										Text = "chat commands",
										TextColor3 = Theme.Color.NeutralContentDark,
										TextSize = heroTextSize,
									},
								},
							},

							scope:New "Frame" {
								Name = "SellingPoints",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundColor3 = Theme.Color.Neutral,
								LayoutOrder = 2,
								Size = UDim2.fromScale(1, 0),
								[Children] = {
									scope:New "UICorner" {
										CornerRadius = UDim.new(0, 9),
									},
									scope:New "UIStroke" {
										ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
										Color = Theme.Color.NeutralContent,
										Transparency = 0.5,
									},
									scope:New "UIPadding" {
										PaddingTop = UDim.new(0, 14),
										PaddingBottom = UDim.new(0, 14),
										PaddingLeft = UDim.new(0, 14),
										PaddingRight = UDim.new(0, 14),
									},
									scope:New "UIListLayout" {
										HorizontalFlex = Enum.UIFlexAlignment.Fill,
										VerticalFlex = Enum.UIFlexAlignment.None,
										Padding = UDim.new(0, 20),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									(function()
										local points: {any} = {}
										for index, point in SELLING_POINTS do
											table.insert(points, makeSellingPoint(scope, index, point))
										end
										return points
									end)(),
								},
							},
						},
					},

					scope:New "Frame" {
						Name = "Actions",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 3,
						Size = UDim2.fromScale(1, 0),
						[Children] = {
							scope:New "UIListLayout" {
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								VerticalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 10),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},

							scope:New "Frame" {
								Name = "Timer",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 1,
								Size = UDim2.fromScale(1, 0),
								Visible = offerActive,
								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Horizontal,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
										Padding = UDim.new(0, 4),
										SortOrder = Enum.SortOrder.LayoutOrder,
										VerticalAlignment = Enum.VerticalAlignment.Center,
									},
									scope:New "ImageLabel" {
										Name = "Hourglass",
										BackgroundTransparency = 1,
										Image = Icons.HourglassHalfOutline,
										ImageColor3 = Theme.Color.BaseContent,
										LayoutOrder = 1,
										Size = UDim2.fromOffset(14, 14),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
										end),
										LayoutOrder = 2,
										RichText = true,
										Text = timerText,
										TextColor3 = Theme.Color.BaseContent,
										TextSize = Theme.TextSize.Label,
									},
								},
							},

							Pressable(scope, {
								name = "UnlockButton",
								backgroundColor = Theme.Color.Primary,
								size = UDim2.new(1, 0, 0, 44),
								automaticSize = Enum.AutomaticSize.None,
								layoutOrder = 2,
								onActivate = purchase,
								[Children] = {
									scope:New "UICorner" {
										CornerRadius = UDim.new(0, 6),
									},
									-- The rainbow outline is a discount-only flourish
									scope:New "UIStroke" {
										ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
										Enabled = offerActive,
										LineJoinMode = Enum.LineJoinMode.Round,
										Color = Color3.new(1, 1, 1),
										Thickness = 2,
										Transparency = 0.35,
										[Children] = {
											unlockGradient,
										},
									},
									scope:New "Frame" {
										Name = "Content",
										AnchorPoint = Vector2.new(0.5, 0.5),
										AutomaticSize = Enum.AutomaticSize.X,
										BackgroundTransparency = 1,
										Position = UDim2.fromScale(0.5, 0.5),
										Size = UDim2.fromScale(0, 1),
										[Children] = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Horizontal,
												HorizontalAlignment = Enum.HorizontalAlignment.Center,
												Padding = UDim.new(0, 6),
												SortOrder = Enum.SortOrder.LayoutOrder,
												VerticalAlignment = Enum.VerticalAlignment.Center,
											},
											scope:New "TextLabel" {
												Name = "Label",
												AutomaticSize = Enum.AutomaticSize.XY,
												BackgroundTransparency = 1,
												FontFace = scope:Computed(function(use)
													return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
												end),
												LayoutOrder = 1,
												Text = "Unlock",
												TextColor3 = Theme.Color.PrimaryContent,
												TextSize = Theme.TextSize.Subtitle,
											},
											scope:New "Frame" {
												Name = "OldPrice",
												AutomaticSize = Enum.AutomaticSize.X,
												BackgroundTransparency = 1,
												LayoutOrder = 2,
												Size = UDim2.fromScale(0, 1),
												Visible = offerActive,
												[Children] = {
													scope:New "Frame" {
														Name = "Inner",
														AutomaticSize = Enum.AutomaticSize.X,
														BackgroundTransparency = 1,
														Size = UDim2.fromScale(0, 1),
														[Children] = {
															scope:New "UIListLayout" {
																FillDirection = Enum.FillDirection.Horizontal,
																Padding = UDim.new(0, 6),
																SortOrder = Enum.SortOrder.LayoutOrder,
																VerticalAlignment = Enum.VerticalAlignment.Center,
															},
															scope:New "ImageLabel" {
																Name = "Robux",
																BackgroundTransparency = 1,
																Image = Icons.RobuxFill,
																ImageColor3 = Theme.Color.PrimaryContent,
																LayoutOrder = 1,
																Size = UDim2.fromOffset(18, 18),
															},
															scope:New "TextLabel" {
																Name = "Amount",
																AutomaticSize = Enum.AutomaticSize.XY,
																BackgroundTransparency = 1,
																FontFace = scope:Computed(function(use)
																	return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
																end),
																LayoutOrder = 2,
																Text = fullPriceText,
																TextColor3 = Theme.Color.PrimaryContent,
																TextSize = Theme.TextSize.Subtitle,
															},
														},
													},
													scope:New "Frame" {
														Name = "Strike",
														AnchorPoint = Vector2.new(0.5, 0.5),
														BackgroundColor3 = strikeColor,
														BackgroundTransparency = 0.1,
														BorderSizePixel = 0,
														Position = UDim2.new(0.5, 0, 0.49, 0),
														Rotation = -5,
														Size = UDim2.new(1, 0, 0, 2),
													},
												},
											},
											scope:New "Frame" {
												Name = "NewPrice",
												AutomaticSize = Enum.AutomaticSize.X,
												BackgroundTransparency = 1,
												LayoutOrder = 3,
												Size = UDim2.fromScale(0, 1),
												[Children] = {
													scope:New "UIListLayout" {
														FillDirection = Enum.FillDirection.Horizontal,
														Padding = UDim.new(0, 6),
														SortOrder = Enum.SortOrder.LayoutOrder,
														VerticalAlignment = Enum.VerticalAlignment.Center,
													},
													scope:New "ImageLabel" {
														Name = "Robux",
														BackgroundTransparency = 1,
														Image = Icons.RobuxFill,
														ImageColor3 = Theme.Color.PrimaryContent,
														LayoutOrder = 1,
														Size = UDim2.fromOffset(18, 18),
													},
													scope:New "TextLabel" {
														Name = "Amount",
														AutomaticSize = Enum.AutomaticSize.XY,
														BackgroundTransparency = 1,
														FontFace = scope:Computed(function(use)
															return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
														end),
														LayoutOrder = 2,
														Text = newPriceText,
														TextColor3 = Theme.Color.PrimaryContent,
														TextSize = Theme.TextSize.Subtitle,
													},
												},
											},
										},
									},
								},
							}),

							scope:New "Frame" {
								Name = "ViewRow",
								BackgroundTransparency = 1,
								LayoutOrder = 3,
								Size = UDim2.new(1, 0, 0, 44),
								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Horizontal,
										Padding = UDim.new(0, 6),
										SortOrder = Enum.SortOrder.LayoutOrder,
										VerticalAlignment = Enum.VerticalAlignment.Center,
									},
									makeSecondaryButton(scope, 1, "View commands", viewCommands, UDim2.new(1, -50, 0, 44)),
									OutfitsButton(scope, {
										size = UDim2.fromOffset(44, 44),
										layoutOrder = 2,
										onActivate = function() Panels.openOutfits() end,
									}),
								},
							},
						},
					},
				},
			},
		},
	}
end
