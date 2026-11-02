--!strict
-- CONFIG
-- Clear it to fall back to the Get-Booster-style glow
local HERO_BACKGROUND_IMAGE = "rbxassetid://96375899701520"

-- Donations are built but not ready to show yet
local SHOW_DONATIONS = false


-- LOCAL
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local VERSION = require(frontend.Config.VERSION)
local Credits = require(frontend.Config.Credits)
local Panels = require(frontend.Config.Panels)
local Divider = require(frontend.Components.Divider)
local CreditBadge = require(frontend.Components.CreditBadge)
local UpdatesLink = require(frontend.Components.UpdatesLink)
local CosmeticCard = require(frontend.Components.CosmeticCard)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local Pressable = require(frontend.Components.Pressable)
local CosmeticMarket = require(frontend.Util.CosmeticMarket)
local Prompt = require(modules.Prompt)
local products = require(modules.References.products)
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	onBooster: (() -> ())?,
}
type CreditLink = {
	name: string,
	url: string,
	icon: string,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	-- Bail flag for async
	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local latestVersion: Fusion.Value<string?> = scope:Value(nil)
	task.spawn(function()
		local version = VERSION.getLatestVersion()
		if destroyed then return end
		latestVersion:set(version)
	end)

	local updatesHintText = scope:Computed(function(use)
		local latest = use(latestVersion)
		if VERSION.isOutdatedVersion(latest) then
			return `You're not on the latest version ({latest}). Update from the link below`
		end
		return "Get a free copy and view the latest updates here:"
	end)
	-- The artwork stays dark in every theme, so text sat on it keeps fixed light
	-- colours. Theme tokens go dark on light themes and vanish into it
	local heroTitleColor: any = if HERO_BACKGROUND_IMAGE ~= "" then Color3.fromRGB(255, 255, 255) else Theme.Color.BaseContent
	local updatesHintColor = scope:Computed(function(use)
		local latest = use(latestVersion)
		local outdated = VERSION.isOutdatedVersion(latest)
		if HERO_BACKGROUND_IMAGE ~= "" then
			return if outdated then Color3.fromRGB(251, 191, 36) else Color3.fromRGB(212, 212, 216)
		end
		return if outdated then use(Theme.Color.Warning) else use(Theme.Color.NeutralContentMain)
	end)

	local contributorGroupsValue = scope:Value(Credits.Contributors)
	local librariesValue = scope:Value(Credits.Libraries)

	-- The Outfits store owns the accessory catalog, we just surface its first two
	local accessoriesFuse = scope:Fuse("everyone", "SpecialAccessories")
	local featuredAccessories = scope:Computed(function(use)
		local catalog = use(accessoriesFuse)
		if typeof(catalog) ~= "table" then return {} end
		local list = {}
		for _, accessory in catalog :: any do
			if typeof(accessory) == "table" and accessory.id then
				table.insert(list, accessory)
			end
		end
		table.sort(list, function(left, right)
			local leftOrder, rightOrder = left.order or math.huge, right.order or math.huge
			if leftOrder ~= rightOrder then return leftOrder < rightOrder end
			return tostring(left.name) < tostring(right.name)
		end)
		local featured = {}
		for index = 1, math.min(2, #list) do
			featured[index] = list[index]
		end
		return featured
	end)

	-- Placeholder entries (id 0) only show in Studio so the grid stays testable
	local donationEntries: {products.Product} = {}
	for _, product in products do
		if product.donationRobux and (product.id ~= 0 or RunService:IsStudio()) then
			table.insert(donationEntries, product)
		end
	end
	table.sort(donationEntries, function(left, right)
		return (left.donationRobux :: number) < (right.donationRobux :: number)
	end)
	local donationEntriesValue = scope:Value(donationEntries)

	-- Clicking the same badge again dismisses it
	local activeCreditLink: Fusion.Value<CreditLink?> = scope:Value(nil)
	local function toggleCreditLink(name: string, url: string, icon: string)
		local current = Fusion.peek(activeCreditLink)
		if current and current.url == url then
			activeCreditLink:set(nil)
		else
			activeCreditLink:set({name = name, url = url, icon = icon})
		end
	end
	local creditLinkIcon = scope:Computed(function(use)
		local entry = use(activeCreditLink)
		return if entry then entry.icon else ""
	end)
	local creditLinkUrl = scope:Computed(function(use)
		local entry = use(activeCreditLink)
		return if entry then entry.url else ""
	end)
	-- One springed number drives both heights so they resize in sync
	local creditBarHeight: any = (scope :: any):Spring((scope :: any):Computed(function(use)
		return if use(activeCreditLink) then 54 else 0
	end), 40, 1)

	local function sectionHeading(sc: Scope, text: string, layoutOrder: number): Instance
		return sc:New "TextLabel" {
			Name = "Heading",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = sc:Computed(function(use)
				return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
			end),
			LayoutOrder = layoutOrder,
			Size = UDim2.fromScale(1, 0),
			Text = text,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Title,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
		}
	end

	local function groupHeading(sc: Scope, text: string): Instance
		return sc:New "TextLabel" {
			Name = "GroupHeading",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = sc:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
			end),
			LayoutOrder = 1,
			Text = text,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Subtitle,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
		}
	end

	local function donationText(amount: number): string
		return if amount >= 1000 then tostring(amount / 1000) .. "k" else tostring(amount)
	end

	local function promptDonation(product: products.Product)
		if product.id == 0 then
			Prompt.warn("Donations are coming soon")
			return
		end
		task.spawn(function()
			local success, warning = promptPurchaseAsync(product.id, nil, product.infoType)
			if not success and typeof(warning) == "string" and warning ~= "" then
				Prompt.warn(warning)
			end
		end)
	end

	return scope:New "Frame" {
		Name = "AboutPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			-- Keeps the bottom clear of the panel's expander drag strip
			scope:New "UIPadding" {
				PaddingBottom = UDim.new(0, 20),
			},

			-- The link bar carves its height out of the scroll area directly, so the
			-- page opens at full height with no flex settle frame
			scope:New "ScrollingFrame" {
				Name = "Sections",
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BottomImage = "rbxassetid://16547643439",
				CanvasSize = UDim2.new(),
				MidImage = "rbxassetid://16547330984",
				ScrollBarImageTransparency = 1,
				ScrollBarThickness = 0,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				Size = scope:Computed(function(use)
					return UDim2.new(1, 0, 1, -use(creditBarHeight))
				end),
				TopImage = "rbxassetid://16547667444",

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 12),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "Frame" {
						Name = "HeroBanner",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.fromScale(1, 0),

						[Children] = {
							scope:Computed(function(_, innerScope)
								if HERO_BACKGROUND_IMAGE ~= "" then
									return innerScope:New "ImageLabel" {
										Name = "BannerImage",
										BackgroundTransparency = 1,
										Image = HERO_BACKGROUND_IMAGE,
										ScaleType = Enum.ScaleType.Crop,
										Size = UDim2.fromScale(1, 1),
										ZIndex = 0,
										[Children] = {
											innerScope:New "UIGradient" {
												Rotation = 90,
												Transparency = NumberSequence.new({
													NumberSequenceKeypoint.new(0, 0),
													NumberSequenceKeypoint.new(0.65, 0.1),
													NumberSequenceKeypoint.new(1, 1),
												}),
											},
										},
									}
								end
								return innerScope:New "Frame" {
									Name = "Glow",
									BackgroundColor3 = innerScope:Computed(function(use)
										local latest = use(latestVersion)
										local outdated = VERSION.isOutdatedVersion(latest)
										return if outdated then use(Theme.Color.Warning) else use(Theme.Color.Primary)
									end),
									Size = UDim2.fromScale(1, 0.65),
									ZIndex = 1,
									[Children] = {
										innerScope:New "UIGradient" {
											Rotation = 90,
											Transparency = NumberSequence.new({
												NumberSequenceKeypoint.new(0, 0.72),
												NumberSequenceKeypoint.new(0.6, 0.9),
												NumberSequenceKeypoint.new(1, 1),
											}),
										},
									},
								}
							end),

							scope:New "Frame" {
								Name = "Content",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 0),
								ZIndex = 2,

								[Children] = {
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 14),
										PaddingLeft = UDim.new(0, 14),
										PaddingRight = UDim.new(0, 14),
										PaddingTop = UDim.new(0, 18),
									},
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Vertical,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
										Padding = UDim.new(0, 10),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									scope:New "TextLabel" {
										Name = "Title",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
										end),
										LayoutOrder = 2,
										Text = "HD Admin",
										TextColor3 = heroTitleColor,
										TextSize = Theme.TextSize.Title,
										TextXAlignment = Enum.TextXAlignment.Center,
									},
									scope:New "Frame" {
										Name = "BadgeRow",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										LayoutOrder = 3,

										[Children] = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Vertical,
												HorizontalAlignment = Enum.HorizontalAlignment.Center,
												Padding = UDim.new(0, 6),
												SortOrder = Enum.SortOrder.LayoutOrder,
											},
											CreditBadge(scope, {
												text = VERSION.appVersion,
												layoutOrder = 1,
											}),
											scope:Computed(function(use, innerScope)
												local latest = use(latestVersion)
												if latest == nil then
													return nil
												end
												local outdated = VERSION.isOutdatedVersion(latest)
												return CreditBadge(innerScope, {
													text = if outdated then "Update available" else "All up-to date!",
													icon = if outdated then Icons.WarningFill else Icons.CheckMarkFill,
													iconColor = if outdated then Theme.Color.Warning else Theme.Color.Success,
													backgroundColor = Theme.Color.Neutral,
													strokeColor = if outdated then Theme.Color.Warning else Theme.Color.Success,
													textColor = if outdated then Theme.Color.Warning else Theme.Color.Success,
													paddingRight = 14, -- matches the visual gap between the tick and the text
													layoutOrder = 2,
												})
											end),
										},
									},
									-- Narrower than the banner so it wraps early and more artwork shows
									scope:New "TextLabel" {
										Name = "UpdatesHint",
										AutomaticSize = Enum.AutomaticSize.Y,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
										end),
										LayoutOrder = 4,
										Size = UDim2.fromScale(0.7, 0),
										Text = updatesHintText,
										TextColor3 = updatesHintColor,
										TextSize = Theme.TextSize.Label,
										TextWrapped = true,
										TextXAlignment = Enum.TextXAlignment.Center,
									},
									UpdatesLink(scope, {
										url = VERSION.updatesUrl,
										layoutOrder = 5,
									}),
								},
							},
						},
					},

					-- Every section below the banner keeps the page padding the banner escapes
					scope:New "Frame" {
						Name = "Body",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 2,
						Size = UDim2.fromScale(1, 0),

						[Children] = {
							scope:New "UIPadding" {
								PaddingBottom = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
								PaddingLeft = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
								PaddingRight = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
							},
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Vertical,
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								Padding = UDim.new(0, 27),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},

							scope:New "Frame" {
								Name = "Cosmetics",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 3,

								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Vertical,
										HorizontalFlex = Enum.UIFlexAlignment.Fill,
										Padding = UDim.new(0, 16),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									sectionHeading(scope, "Cosmetics", 1),
									scope:Computed(function(use, innerScope)
										local featured = use(featuredAccessories)
										if #featured == 0 then
											return LoadingSpinner(innerScope, { layoutOrder = 2 })
										end
										local cards = {}
										for index, accessory in featured do
											local id = accessory.id
											local comingSoon = accessory.comingSoon == true
											local price = innerScope:Value(if comingSoon then 0 else CosmeticMarket.peekPrice(id))
											local favourited = innerScope:Value(if comingSoon then false else CosmeticMarket.peekFavourite(id))
											if not comingSoon then
												CosmeticMarket.seedPrice(id, price)
												CosmeticMarket.seedFavourite(id, favourited)
											end
											table.insert(cards, CosmeticCard(innerScope, {
												accessoryId = id,
												name = if comingSoon then "Coming Soon" else tostring(accessory.name),
												robuxPrice = price,
												isFavourited = favourited,
												onFavourite = function()
													if comingSoon then
														CosmeticMarket.notifyComingSoon()
														return
													end
													CosmeticMarket.toggleFavourite(id, favourited)
												end,
												onBuy = function()
													if comingSoon then
														CosmeticMarket.notifyComingSoon()
														return
													end
													CosmeticMarket.buy(id)
												end,
												layoutOrder = index,
											}))
										end
										return innerScope:New "Frame" {
											Name = "FeaturedCards",
											AutomaticSize = Enum.AutomaticSize.Y,
											BackgroundTransparency = 1,
											LayoutOrder = 2,
											Size = UDim2.fromScale(1, 0),
											[Children] = {
												innerScope:New "UIListLayout" {
													FillDirection = Enum.FillDirection.Horizontal,
													HorizontalFlex = Enum.UIFlexAlignment.Fill,
													Padding = UDim.new(0, 8),
													SortOrder = Enum.SortOrder.LayoutOrder,
												},
												cards,
											},
										}
									end),
									Pressable(scope, {
										name = "ShopAll",
										automaticSize = Enum.AutomaticSize.Y,
										backgroundColor = Theme.Color.Primary,
										layoutOrder = 3,
										onActivate = function()
											Panels.openOutfits()
										end,
										size = UDim2.fromScale(1, 0),

										[Children] = {
											scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
											scope:New "UIPadding" {
												PaddingBottom = UDim.new(0, 8),
												PaddingLeft = UDim.new(0, 16),
												PaddingRight = UDim.new(0, 16),
												PaddingTop = UDim.new(0, 8),
											},
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Horizontal,
												HorizontalAlignment = Enum.HorizontalAlignment.Center,
												HorizontalFlex = Enum.UIFlexAlignment.None,
												VerticalFlex = Enum.UIFlexAlignment.None,
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
												Text = "Shop All",
												TextColor3 = Theme.Color.PrimaryContent,
												TextSize = Theme.TextSize.Subtitle,
											},
										},
									}),
								},
							},

							Divider(scope, { layoutOrder = 4 }),

							scope:New "Frame" {
								Name = "Credits",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								LayoutOrder = 5,

								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Vertical,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
										HorizontalFlex = Enum.UIFlexAlignment.Fill,
										Padding = UDim.new(0, 18),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									sectionHeading(scope, "Credits", 1),
									scope:New "Frame" {
										Name = "ContributorGroups",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										LayoutOrder = 2,

										[Children] = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Vertical,
												HorizontalAlignment = Enum.HorizontalAlignment.Center,
												Padding = UDim.new(0, 18),
												SortOrder = Enum.SortOrder.LayoutOrder,
											},
											scope:ForValues(contributorGroupsValue, function(_, outerScope: Scope, group: Credits.ContributorGroup, gi: number)
												local membersValue = outerScope:Value(group.Members)
												return outerScope:New "Frame" {
													Name = "Group_" .. group.Name,
													AutomaticSize = Enum.AutomaticSize.XY,
													BackgroundTransparency = 1,
													LayoutOrder = gi,

													[Children] = {
														outerScope:New "UIListLayout" {
															FillDirection = Enum.FillDirection.Vertical,
															HorizontalAlignment = Enum.HorizontalAlignment.Center,
															Padding = UDim.new(0, 9),
															SortOrder = Enum.SortOrder.LayoutOrder,
														},
														groupHeading(outerScope, group.Name),
														outerScope:New "Frame" {
															Name = "Badges",
															AutomaticSize = Enum.AutomaticSize.XY,
															BackgroundTransparency = 1,
															LayoutOrder = 2,

															[Children] = {
																outerScope:New "UIListLayout" {
																	FillDirection = Enum.FillDirection.Horizontal,
																	HorizontalAlignment = Enum.HorizontalAlignment.Center,
																	Padding = UDim.new(0, 9),
																	SortOrder = Enum.SortOrder.LayoutOrder,
																	Wraps = true,
																},
																outerScope:ForValues(membersValue, function(_, innerScope, member: Credits.ContributorMember, mi: number)
																	local headshot = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(member.UserId) .. "&w=48&h=48"
																	return CreditBadge(innerScope, {
																		text = member.Name,
																		icon = headshot,
																		layoutOrder = mi,
																		onActivate = function()
																			toggleCreditLink(member.Name, "https://www.roblox.com/users/" .. tostring(member.UserId) .. "/profile", headshot)
																		end,
																	})
																end),
															},
														},
													},
												}
											end),
										},
									},
									scope:New "Frame" {
										Name = "Libraries",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										LayoutOrder = 3,

										[Children] = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Vertical,
												HorizontalAlignment = Enum.HorizontalAlignment.Center,
												Padding = UDim.new(0, 9),
												SortOrder = Enum.SortOrder.LayoutOrder,
											},
											groupHeading(scope, "Libraries"),
											scope:New "Frame" {
												Name = "Badges",
												AutomaticSize = Enum.AutomaticSize.XY,
												BackgroundTransparency = 1,
												LayoutOrder = 2,

												[Children] = {
													scope:New "UIListLayout" {
														FillDirection = Enum.FillDirection.Horizontal,
														HorizontalAlignment = Enum.HorizontalAlignment.Center,
														Padding = UDim.new(0, 9),
														SortOrder = Enum.SortOrder.LayoutOrder,
														Wraps = true,
													},
													scope:ForValues(librariesValue, function(_, innerScope, lib: Credits.Library, li: number)
														return CreditBadge(innerScope, {
															text = lib.Name,
															icon = lib.Image,
															layoutOrder = li,
															onActivate = function()
																toggleCreditLink(lib.Name, lib.Link, lib.Image)
															end,
														})
													end),
												},
											},
										},
									},
								},
							},

							-- Behind a Computed so the section only enters the tree once entries exist
							scope:Computed(function(_, innerScope)
								if not SHOW_DONATIONS or #donationEntries == 0 then
									return nil
								end
								return {
									Divider(innerScope, { layoutOrder = 6 }),

									innerScope:New "Frame" {
										Name = "Donate",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										LayoutOrder = 7,

										[Children] = {
											innerScope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Vertical,
												HorizontalFlex = Enum.UIFlexAlignment.Fill,
												Padding = UDim.new(0, 16),
												SortOrder = Enum.SortOrder.LayoutOrder,
											},
											sectionHeading(innerScope, "Donate", 1),
											innerScope:New "Frame" {
												Name = "DonationButtons",
												AutomaticSize = Enum.AutomaticSize.XY,
												BackgroundTransparency = 1,
												LayoutOrder = 2,

												[Children] = {
													innerScope:New "UIListLayout" {
														FillDirection = Enum.FillDirection.Horizontal,
														HorizontalFlex = Enum.UIFlexAlignment.Fill,
														Padding = UDim.new(0, 9),
														SortOrder = Enum.SortOrder.LayoutOrder,
														Wraps = true,
													},
													innerScope:ForValues(donationEntriesValue, function(_, buttonScope: Scope, product: products.Product, index: number)
														return Pressable(buttonScope, {
															name = "DonationButton",
															automaticSize = Enum.AutomaticSize.Y,
															backgroundColor = Theme.Color.Neutral,
															layoutOrder = index,
															onActivate = function()
																promptDonation(product)
															end,
															size = UDim2.new(0.5, -9, 0, 0),

															[Children] = {
																buttonScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
																buttonScope:New "UIPadding" {
																	PaddingBottom = UDim.new(0, 8),
																	PaddingLeft = UDim.new(0, 24),
																	PaddingRight = UDim.new(0, 24),
																	PaddingTop = UDim.new(0, 8),
																},
																buttonScope:New "UIStroke" {
																	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
																	Color = Theme.Color.NeutralContent,
																},
																buttonScope:New "UIListLayout" {
																	FillDirection = Enum.FillDirection.Horizontal,
																	HorizontalAlignment = Enum.HorizontalAlignment.Center,
																	HorizontalFlex = Enum.UIFlexAlignment.None,
																	VerticalFlex = Enum.UIFlexAlignment.None,
																	Padding = UDim.new(0, 4),
																	SortOrder = Enum.SortOrder.LayoutOrder,
																	VerticalAlignment = Enum.VerticalAlignment.Center,
																},
																buttonScope:New "ImageLabel" {
																	Name = "RobuxIcon",
																	BackgroundTransparency = 1,
																	Image = Icons.RobuxFill,
																	ImageColor3 = Theme.Color.BaseContent,
																	LayoutOrder = 1,
																	Size = UDim2.fromOffset(16, 16),
																},
																buttonScope:New "TextLabel" {
																	Name = "Amount",
																	AutomaticSize = Enum.AutomaticSize.XY,
																	BackgroundTransparency = 1,
																	FontFace = buttonScope:Computed(function(use)
																		return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
																	end),
																	LayoutOrder = 2,
																	Text = donationText(product.donationRobux :: number),
																	TextColor3 = Theme.Color.BaseContent,
																	TextSize = Theme.TextSize.Subtitle,
																},
															},
														})
													end),
												},
											},
										},
									},
								}
							end),

							-- Donators and Booster stay hidden for now. Restore by removing the
							-- surrounding --[[ and ]] markers
							--[[
							Divider(scope, { layoutOrder = 8 }),

							-- Donators
							scope:New "Frame" {
								Name = "Donators",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								LayoutOrder = 9,

								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Vertical,
										HorizontalFlex = Enum.UIFlexAlignment.Fill,
										Padding = UDim.new(0, 16),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									sectionHeading(scope, "Donators", 1),
									scope:New "TextLabel" {
										Name = "ComingSoon",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										LayoutOrder = 2,
										Text = "Coming Soon",
										TextColor3 = Theme.Color.NeutralContentDark,
										TextSize = Theme.TextSize.Body,
										TextWrapped = true,
										TextXAlignment = Enum.TextXAlignment.Left,
									},
								},
							},

							Divider(scope, { layoutOrder = 10 }),

							-- Booster
							Pressable(scope, {
								automaticSize = Enum.AutomaticSize.Y,
								backgroundColor = Theme.Color.Neutral,
								layoutOrder = 11,
								onActivate = props.onBooster,
								size = UDim2.fromScale(1, 0),

								[Children] = {
									scope:New "UICorner" {
										CornerRadius = scope:Computed(function(use)
											return UDim.new(0, use(Theme.Layout.CornerRadius))
										end),
									},
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 12),
										PaddingLeft = UDim.new(0, 16),
										PaddingRight = UDim.new(0, 16),
										PaddingTop = UDim.new(0, 12),
									},
									scope:New "TextLabel" {
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = "Booster",
										TextColor3 = Theme.Color.BaseContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),
							--]]
						},
					},
				},
			},

			-- Springs open from the page bottom, the same reveal the settings confirm bar uses
			scope:New "Frame" {
				Name = "CreditLinkWrap",
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.fromScale(0, 1),
				Size = scope:Computed(function(use)
					return UDim2.new(1, 0, 0, use(creditBarHeight))
				end),

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						VerticalFlex = Enum.UIFlexAlignment.None,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					Divider(scope, { layoutOrder = 1, paddingY = 0 }),

					scope:New "Frame" {
						Name = "LinkRow",
						BackgroundTransparency = 1,
						LayoutOrder = 2,
						Size = UDim2.new(1, 0, 0, 0),

						[Children] = {
							scope:New "UIFlexItem" {
								FlexMode = Enum.UIFlexMode.Fill,
							},
							scope:New "UIPadding" {
								PaddingBottom = UDim.new(0, 8),
								PaddingLeft = UDim.new(0, 14),
								PaddingRight = UDim.new(0, 14),
								PaddingTop = UDim.new(0, 8),
							},
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.None,
								VerticalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 10),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "TextBox" {
								Name = "Url",
								AutoLocalize = false,
								BackgroundColor3 = Theme.Color.Neutral,
								ClearTextOnFocus = false,
								ClipsDescendants = true,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								LayoutOrder = 1,
								Size = UDim2.new(0, 0, 1, 0),
								Text = creditLinkUrl,
								TextColor3 = Theme.Color.BaseContent,
								TextEditable = false,
								TextSize = Theme.TextSize.Label,
								TextTruncate = Enum.TextTruncate.AtEnd,
								TextXAlignment = Enum.TextXAlignment.Left,

								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIStroke" {
										ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
										Color = Theme.Color.NeutralStroke,
									},
									scope:New "UIPadding" {
										PaddingLeft = UDim.new(0, 36),
										PaddingRight = UDim.new(0, 34),
									},
									scope:New "UIFlexItem" {
										FlexMode = Enum.UIFlexMode.Fill,
									},
									-- Padding shifts child origins right by 36, the negative offset walks it back
									scope:New "ImageLabel" {
										Name = "Icon",
										AnchorPoint = Vector2.new(0, 0.5),
										BackgroundTransparency = 1,
										Image = creditLinkIcon,
										Position = UDim2.new(0, -28, 0.5, 0),
										Size = UDim2.fromOffset(20, 20),
									},
									-- Same trick on the right, pushed past the padded edge
									Pressable(scope, {
										name = "CloseButton",
										anchorPoint = Vector2.new(1, 0.5),
										position = UDim2.new(1, 30, 0.5, 0),
										size = UDim2.fromOffset(26, 26),
										iconImage = Icons.Close,
										iconColor = Theme.Color.NeutralContentDark,
										iconSize = 14,
										onActivate = function()
											activeCreditLink:set(nil)
										end,
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
