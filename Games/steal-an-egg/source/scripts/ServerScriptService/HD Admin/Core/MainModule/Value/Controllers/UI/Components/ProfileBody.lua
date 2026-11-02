--!strict

--[[

	Add and remove role actions fire their GiveRoleToUser / TakeRoleFromUser
	remote straight away

--]]

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Platform = require(frontend.Util.Platform)
local Viewport = require(frontend.Config.Viewport)
local RoleBadge = require(frontend.Components.RoleBadge)
local BanBanner = require(frontend.Components.BanBanner)
local Givers = require(frontend.Util.extractGivers)
local stableRows = require(frontend.Util.stableRows)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local Pressable = require(frontend.Components.Pressable)
local SearchRowToggle = require(frontend.Components.SearchRowToggle)
local nameValueFor = require(frontend.Util.nameValueFor)
local Remote = require(modules.Objects.Remote)
local Children = Fusion.Children
local Out = Fusion.Out


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type GiverIdentity = {
	type: string, -- "Group" | "Product" | "Friend" | "UserList"
	id: string,
	name: string,
	roleKeys: {string},
}

export type Props = {
	userId: UsedAs<number>?, -- required when giverIdentity is nil, ignored otherwise
	giverIdentity: GiverIdentity?,
	inline: boolean?,
	popupParent: Instance?, -- must sit above any ScrollingFrame so the popup isn't clipped
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local inline = props.inline == true

	local resolvedGiverIdentity = Fusion.peek(props.giverIdentity :: any)
	if resolvedGiverIdentity then
		local giver: GiverIdentity = resolvedGiverIdentity
		local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
		local reuseBadge, sweepBadges = stableRows()
		local rolesList = scope:Computed(function(use)
			local info = use(roleInfoFuse)
			if typeof(info) ~= "table" then return {} end
			local out: {{ id: string, name: string, color: Color3, level: number }} = {}
			for _, key in giver.roleKeys do
				local roleEntry = (info :: any)[key]
				if typeof(roleEntry) == "table" then
					local name = (roleEntry :: any).name or key
					local color = (roleEntry :: any).color or Color3.fromRGB(161, 161, 170)
					local level = (roleEntry :: any).rank or 0
					table.insert(out, reuseBadge(key, `{name}|{color:ToHex()}|{level}`, function()
						return {id = key, name = name, color = color, level = level}
					end))
				end
			end
			sweepBadges()
			table.sort(out, function(roleA, roleB) return roleA.level > roleB.level end)
			return out
		end)
		local groupBreakdown: any = if giver.type == "Group"
			then scope:Computed(function(use)
				local info = use(roleInfoFuse)
				return Givers.buildGroupBreakdown(info, giver.id)
			end)
			else nil
		local reuseSection, sweepSections = stableRows()
		local sectionsList: any = if groupBreakdown
			then scope:Computed(function(use)
				local sections = (use(groupBreakdown) :: any).sections
				local out: {any} = {}
				for _, section in sections :: {any} do
					local key = `{section.kind}:{section.rank or "all"}`
					local fingerprint = `{section.name or ""}|{table.concat(section.hdAdminRoleKeys, ",")}`
					table.insert(out, reuseSection(key, fingerprint, function()
						return section
					end))
				end
				sweepSections()
				return out
			end)
			else nil

		local function buildSection(_: any, sectionScope: Fusion.Scope, section: any)
			local headerText = sectionScope:Computed(function(use)
				if section.kind == "AllMembers" then
					return "All Members"
				end
				local dim: Color3 = use(Theme.Color.NeutralContentDark)
				local hex = string.format("#%02X%02X%02X",
					math.round(dim.R * 255), math.round(dim.G * 255), math.round(dim.B * 255))
				local nm = if typeof(section.name) == "string" and #section.name > 0
					then section.name
					else "Rank " .. tostring(section.rank)
				return string.format("%s <font color=\"%s\">(Rank %d)</font>", nm, hex, section.rank or 0)
			end)
			return sectionScope:New "Frame" {
				Name = "Section",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				[Children] = {
					sectionScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6),
					},
					sectionScope:New "TextLabel" {
						Name = "Header",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = sectionScope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
						end),
						RichText = true,
						Size = UDim2.new(1, 0, 0, 0),
						Text = headerText,
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Label,
						TextXAlignment = Enum.TextXAlignment.Left,
					},
					(function()
						-- Wraps + AutomaticSize.Y over-counts row height, so drive Size.Y
						-- from the layout's AbsoluteContentSize instead
						local badgesContentSize: Fusion.Value<Vector2> = sectionScope:Value(Vector2.zero)
						return sectionScope:New "Frame" {
							Name = "Badges",
							LayoutOrder = 2,
							BackgroundTransparency = 1,
							Size = sectionScope:Computed(function(use)
								return UDim2.new(1, 0, 0, use(badgesContentSize).Y)
							end),
							[Children] = {
								sectionScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Left,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Wraps = true,
									Padding = UDim.new(0, 6),
									SortOrder = Enum.SortOrder.LayoutOrder,
									[Out("AbsoluteContentSize")] = badgesContentSize,
								},
								sectionScope:ForValues(section.hdAdminRoleKeys, function(_, bScope, hdRoleKey)
									local nameValue = bScope:Computed(function(use)
										local info = use(roleInfoFuse)
										local roleEntry = if typeof(info) == "table" then (info :: any)[hdRoleKey] else nil
										return if typeof(roleEntry) == "table" and typeof((roleEntry :: any).name) == "string" then (roleEntry :: any).name else hdRoleKey
									end)
									local colorValue = bScope:Computed(function(use)
										local info = use(roleInfoFuse)
										local roleEntry = if typeof(info) == "table" then (info :: any)[hdRoleKey] else nil
										return if typeof(roleEntry) == "table" and typeof((roleEntry :: any).color) == "Color3" then (roleEntry :: any).color else Color3.fromRGB(161, 161, 170)
									end)
									return RoleBadge(bScope, {
										id = bScope:Value(hdRoleKey),
										name = nameValue,
										color = colorValue,
										large = true,
										isGiver = bScope:Value(true),
									})
								end),
							},
						}
					end)(),
				},
			}
		end
		return scope:New "Frame" {
			Name = "ProfileBody",
			AutomaticSize = if inline then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
			BackgroundTransparency = 1,
			Size = if inline then UDim2.new(1, 0, 0, 0) else UDim2.fromScale(1, 1),
			[Children] = {
				scope:New "UIPadding" {
					PaddingBottom = UDim.new(0, 2),
					PaddingLeft = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingTop = UDim.new(0, 6),
				},
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					Padding = UDim.new(0, 14),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				scope:New "Frame" {
					Name = "Header",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					Size = UDim2.new(1, 0, 0, 0),
					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 10),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						scope:New "ImageLabel" {
							Name = "Icon",
							BackgroundColor3 = Theme.Color.NeutralDark,
							Image = Givers.imageUrl(giver),
							LayoutOrder = 1,
							Size = UDim2.fromOffset(60, 60),
							[Children] = {
								scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							},
						},
						scope:New "Frame" {
							Name = "Names",
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							LayoutOrder = 2,
							Size = UDim2.new(1, -70, 0, 0),
							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Vertical,
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								scope:New "TextLabel" {
									Name = "DisplayName",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
									end),
									LayoutOrder = 1,
									Size = UDim2.new(1, 0, 0, 0),
									Text = Givers.makeNameComputed(scope, giver),
									TextColor3 = Theme.Color.BaseContent,
									TextSize = 24,
									TextTruncate = Enum.TextTruncate.AtEnd,
									TextXAlignment = Enum.TextXAlignment.Left,
									TextYAlignment = Enum.TextYAlignment.Top,
								},
								scope:New "TextLabel" {
									Name = "Subtitle",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
									end),
									LayoutOrder = 2,
									Size = UDim2.new(1, 0, 0, 0),
									Text = `({Givers.subtitleFor(giver)})`,
									TextColor3 = Theme.Color.NeutralContentDark,
									TextSize = Theme.TextSize.Subtitle,
									TextTruncate = Enum.TextTruncate.AtEnd,
									TextXAlignment = Enum.TextXAlignment.Left,
									TextYAlignment = Enum.TextYAlignment.Top,
								},
							},
						},
					},
				},
				(function()
					local introText: string
					if giver.type == "Group" then
						introText = "The members of this group will receive these roles:"
					elseif giver.type == "Product" or giver.type == "ProductPreset" then
						introText = "Everyone with this product will receive these roles:"
					elseif giver.type == "Friend" then
						introText = if giver.id == "friends"
							then "Everyone friended with the creator will receive these roles:"
							else "Everyone friended with this user will receive these roles:"
					elseif giver.type == "UserPreset" then
						if giver.id == "Creator" then
							introText = "The creator of this game (or its group owner) will receive these roles:"
						elseif giver.id == "FriendsOfCreator" then
							introText = "Friends of the creator of this game (or its group owner) will receive these roles:"
						else
							introText = "Everyone matching this preset will receive these roles:"
						end
					elseif giver.type == "UserList" then
						introText = "Everyone matching this list will receive these roles:"
					elseif giver.type == "Everyone" then
						introText = "Everyone in this game will receive these roles:"
					elseif giver.type == "PrivateServerOwner" then
						introText = "The owner of a private server will receive these roles:"
					else
						introText = "These roles will be granted:"
					end
					return scope:New "TextLabel" {
						Name = "IntroNote",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						LayoutOrder = 2,
						Size = UDim2.new(1, 0, 0, 0),
						Text = introText,
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Label,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}
				end)(),
				if giver.type == "Group" then scope:New "Frame" {
					Name = "Sections",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 3,
					Size = UDim2.new(1, 0, 0, 0),
					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 12),
						},
						scope:ForValues(sectionsList, buildSection),
					},
				} else (function()
					-- Same Wraps over-count fix as the section badges above
					local rolesContentSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
					return scope:New "Frame" {
						Name = "Roles",
						BackgroundTransparency = 1,
						LayoutOrder = 3,
						Size = scope:Computed(function(use)
							return UDim2.new(1, 0, 0, use(rolesContentSize).Y)
						end),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Left,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Wraps = true,
								Padding = UDim.new(0, 6),
								SortOrder = Enum.SortOrder.LayoutOrder,
								[Out("AbsoluteContentSize")] = rolesContentSize,
							},
							scope:ForValues(rolesList, function(_, badgeScope, role: any, index: number)
								return RoleBadge(badgeScope, {
									id = badgeScope:Value(role.id),
									name = badgeScope:Value(role.name),
									color = badgeScope:Value(role.color),
									large = true,
									isGiver = badgeScope:Value(true),
								})
							end),
						},
					}
				end)(),
				scope:New "TextLabel" {
					Name = "ConfiguredNote",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					LayoutOrder = 4,
					Size = UDim2.new(1, 0, 0, 0),
					Text = "This can be configured within Roles",
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Label,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				},
			},
		}
	end

	local userId = props.userId

	local thumbUrl = scope:Computed(function(use)
		local id = if typeof(userId) == "table" then use(userId) else userId
		return "rbxthumb://type=AvatarBust&id=" .. tostring(id) .. "&w=150&h=150"
	end)

	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local serverMembersFuse: any = (scope :: any):Fuse("everyone", "ServerMembers")
	local permanentMembersFuse: any = (scope :: any):Fuse("everyone", "PermanentMembers")
	local memberData = scope:Computed(function(use)
		local id = if typeof(userId) == "table" then use(userId) else userId
		if typeof(id) ~= "number" then return nil end
		local you = use(youMemberFuse)
		if typeof(you) == "table" and typeof((you :: any).userId) == "number" and (you :: any).userId == id then
			return you
		end
		local idKey = tostring(id)
		local server = use(serverMembersFuse)
		if typeof(server) == "table" and typeof((server :: any)[idKey]) == "table" then
			return (server :: any)[idKey]
		end
		local permanent = use(permanentMembersFuse)
		if typeof(permanent) == "table" and typeof((permanent :: any)[idKey]) == "table" then
			return (permanent :: any)[idKey]
		end
		return nil
	end)

	local resolvedUserName = nameValueFor(scope, userId :: any)

	local optimisticAdds: Fusion.Value<{[string]: {isPermanent: boolean, token: number}}> = scope:Value({})
	local optimisticRemoves: Fusion.Value<{[string]: number}> = scope:Value({})
	local optimisticTokens = 0

	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	local reuseRoleBadge, sweepRoleBadges = stableRows()
	local rolesList = scope:Computed(function(use)
		local info = use(roleInfoFuse)
		if typeof(info) ~= "table" then return {} end
		local member = use(memberData)
		local serverRoleKeys: {string} = if member and typeof((member :: any).roleKeys) == "table"
			then (member :: any).roleKeys :: any else {}
		local serverPermSet: {[string]: boolean} = if member and typeof((member :: any).permanentRoleKeys) == "table"
			then (member :: any).permanentRoleKeys :: any else {}
		local serverGiverSet: {[string]: boolean} = if member and typeof((member :: any).giverRoleKeys) == "table"
			then (member :: any).giverRoleKeys :: any else {}
		local adds = use(optimisticAdds)
		local removes = use(optimisticRemoves)

		-- The server can't unlink a giver source, so a remove only drops the perm flag
		local effective: {[string]: {isPermanent: boolean, isGiver: boolean}} = {}
		for _, key in serverRoleKeys do
			local isPerm = serverPermSet[key] == true
			local isGiver = serverGiverSet[key] == true
			if removes[key] then
				if not isGiver then continue end
				isPerm = false
			end
			effective[key] = { isPermanent = isPerm, isGiver = isGiver }
		end
		for key, addInfo in adds do
			local existingGiver = (effective[key] and effective[key].isGiver) or false
			local existingPerm = (effective[key] and effective[key].isPermanent) or false
			effective[key] = {
				isPermanent = existingPerm or addInfo.isPermanent,
				isGiver = existingGiver,
			}
		end

		local out: {{ id: string, name: string, color: Color3, level: number, isPermanent: boolean, isGiver: boolean }} = {}
		for key, flags in effective do
			local roleEntry = (info :: any)[key]
			if typeof(roleEntry) ~= "table" then continue end
			if isInternalRole(roleEntry) then continue end
			local name = (roleEntry :: any).name or key
			local color = (roleEntry :: any).color or Color3.fromRGB(161, 161, 170)
			local level = (roleEntry :: any).rank or 0
			table.insert(out, reuseRoleBadge(key, `{name}|{color:ToHex()}|{level}|{tostring(flags.isPermanent)}|{tostring(flags.isGiver)}`, function()
				return {
					id = key,
					name = name,
					color = color,
					level = level,
					isPermanent = flags.isPermanent,
					isGiver = flags.isGiver,
				}
			end))
		end
		sweepRoleBadges()
		table.sort(out, function(roleA, roleB) return roleA.level > roleB.level end)
		return out
	end)

	local addPopupOpen: Fusion.Value<boolean> = scope:Value(false)
	local reuseAvailableRole, sweepAvailableRoles = stableRows()
	local availableRoles = scope:Computed(function(use)
		local info = use(roleInfoFuse)
		if typeof(info) ~= "table" then return {} end
		local member = use(memberData)
		local owned: {[string]: boolean} = {}
		if member and typeof((member :: any).roleKeys) == "table" then
			for _, roleKey in (member :: any).roleKeys :: {string} do owned[roleKey] = true end
		end
		local adds = use(optimisticAdds)
		local removes = use(optimisticRemoves)
		for key in adds do owned[key] = true end
		for key in removes do owned[key] = nil end
		local you = use(youMemberFuse)
		local callerTopRank = 0
		if typeof(you) == "table" and typeof((you :: any).roleKeys) == "table" then
			for _, roleKey in (you :: any).roleKeys :: {string} do
				local roleEntry: any = (info :: any)[roleKey]
				if typeof(roleEntry) == "table" and typeof((roleEntry :: any).rank) == "number" then
					if (roleEntry :: any).rank > callerTopRank then callerTopRank = (roleEntry :: any).rank end
				end
			end
		end
		local out: {{ key: string, name: string, color: Color3, rank: number }} = {}
		for key, role in info :: {[string]: any} do
			if typeof(key) ~= "string" or typeof(role) ~= "table" then continue end
			if isInternalRole(role) then continue end
			if owned[key] then continue end
			local rank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
			-- Mirrors server canGiveRole's rank check
			if rank >= callerTopRank then continue end
			local name = (role :: any).name or key
			local color = (role :: any).color or Color3.fromRGB(161, 161, 170)
			table.insert(out, reuseAvailableRole(key, `{name}|{color:ToHex()}|{rank}`, function()
				return {key = key, name = name, color = color, rank = rank}
			end))
		end
		sweepAvailableRoles()
		table.sort(out, function(roleA, roleB) return roleA.rank > roleB.rank end)
		return out
	end)
	local canAddRoles = scope:Computed(function(use)
		return #use(availableRoles) > 0
	end)

	local giveRoleRemote = Remote.get("GiveRoleToUser")
	local takeRoleRemote = Remote.get("TakeRoleFromUser")

	-- Mirrors the server's canUseCommand check, the server still enforces
	local commandInfoFuse: any = (scope :: any):Fuse("everyone", "CommandInfo")
	local function makeCanUseCommandComputed(commandKeyLower: string)
		return scope:Computed(function(use): boolean
			local you = use(youMemberFuse)
			local infoMap = use(commandInfoFuse)
			if typeof(you) ~= "table" or typeof(infoMap) ~= "table" then return false end
			local cmd = (infoMap :: any)[commandKeyLower]
			if typeof(cmd) ~= "table" then return false end
			local cmdRoles: any = (cmd :: any).roles
			if typeof(cmdRoles) ~= "table" then return false end
			local cmdRoleSet: {[string]: true} = {}
			for _, roleKey in cmdRoles :: {string} do cmdRoleSet[roleKey] = true end
			local myRoles: any = (you :: any).roleKeys
			if typeof(myRoles) ~= "table" then return false end
			for _, roleKey in myRoles :: {string} do
				if cmdRoleSet[roleKey] then return true end
			end
			return false
		end)
	end
	local canUseGiveServerRole = makeCanUseCommandComputed("giveserverrole")
	local canUseGivePermRole = makeCanUseCommandComputed("givepermrole")
	local canUseTakeServerRole = makeCanUseCommandComputed("takeserverrole")
	local canUseTakePermRole = makeCanUseCommandComputed("takepermrole")

	-- Server-scope roles die with the JobId
	local isInServer = scope:Computed(function(use)
		local id = if typeof(userId) == "table" then use(userId) else userId
		if typeof(id) ~= "number" then return false end
		local you = use(youMemberFuse)
		if typeof(you) == "table" and typeof((you :: any).userId) == "number" and (you :: any).userId == id then
			return true
		end
		local server = use(serverMembersFuse)
		return typeof(server) == "table" and typeof((server :: any)[tostring(id)]) == "table"
	end)
	local serverPillAvailable = scope:Computed(function(use)
		return use(canUseGiveServerRole) and use(isInServer)
	end)

	local giveScope: Fusion.Value<"server" | "perm"> = scope:Value(
		if Fusion.peek(canUseGivePermRole) then "perm" else "server"
	)
	local function normaliseGiveScope()
		local permOK = Fusion.peek(canUseGivePermRole)
		local serverOK = Fusion.peek(serverPillAvailable)
		local current = Fusion.peek(giveScope)
		if permOK and not serverOK and current ~= "perm" then
			giveScope:set("perm")
		elseif serverOK and not permOK and current ~= "server" then
			giveScope:set("server")
		elseif current == "perm" and not permOK and serverOK then
			giveScope:set("server")
		elseif current == "server" and not serverOK and permOK then
			giveScope:set("perm")
		end
	end
	scope:Observer(canUseGivePermRole):onChange(normaliseGiveScope)
	scope:Observer(canUseGiveServerRole):onChange(normaliseGiveScope)
	scope:Observer(isInServer):onChange(normaliseGiveScope)
	task.defer(normaliseGiveScope)

	-- Backstop only. A short timer here made cross-server grants flicker
	local OPTIMISTIC_FALLBACK_SECS = 30

	local function clearOptimisticAdd(key: string, token: number?)
		local cur = Fusion.peek(optimisticAdds)
		local entry = cur[key]
		if entry == nil then return end
		if token ~= nil and entry.token ~= token then return end
		local next_ = table.clone(cur)
		next_[key] = nil
		optimisticAdds:set(next_)
	end
	local function clearOptimisticRemove(key: string, token: number?)
		local cur = Fusion.peek(optimisticRemoves)
		local entry = cur[key]
		if entry == nil then return end
		if token ~= nil and entry ~= token then return end
		local next_ = table.clone(cur)
		next_[key] = nil
		optimisticRemoves:set(next_)
	end

	local function onGiveRole(roleKey: string)
		addPopupOpen:set(false)
		local targetId = if typeof(userId) == "table" then Fusion.peek(userId) else userId
		if typeof(targetId) ~= "number" then return end
		local scopeChoice: "server" | "perm" = Fusion.peek(giveScope)
		local isPerm = scopeChoice == "perm"

		if Fusion.peek(optimisticRemoves)[roleKey] then
			clearOptimisticRemove(roleKey)
		end
		optimisticTokens += 1
		local token = optimisticTokens
		local cur = table.clone(Fusion.peek(optimisticAdds))
		cur[roleKey] = { isPermanent = isPerm, token = token }
		optimisticAdds:set(cur)

		task.spawn(function()
			local ok, err = (giveRoleRemote :: any):invokeServerAsync(targetId, roleKey, scopeChoice)
			if not ok then
				clearOptimisticAdd(roleKey, token)
				local Prompt = require(modules.Prompt)
				Prompt.warn(tostring(err or "Failed to give role"))
			end
		end)
		task.delay(OPTIMISTIC_FALLBACK_SECS, function()
			clearOptimisticAdd(roleKey, token)
		end)
	end
	-- Removing with "perm" wipes both layers on the server
	local function onRemoveRole(roleKey: string, removeScope: "server" | "perm")
		local targetId = if typeof(userId) == "table" then Fusion.peek(userId) else userId
		if typeof(targetId) ~= "number" then return end

		if Fusion.peek(optimisticAdds)[roleKey] then
			clearOptimisticAdd(roleKey)
		end
		optimisticTokens += 1
		local token = optimisticTokens
		local cur = table.clone(Fusion.peek(optimisticRemoves))
		cur[roleKey] = token
		optimisticRemoves:set(cur)

		task.spawn(function()
			local ok, err = (takeRoleRemote :: any):invokeServerAsync(targetId, roleKey, removeScope)
			if not ok then
				clearOptimisticRemove(roleKey, token)
				local Prompt = require(modules.Prompt)
				Prompt.warn(tostring(err or "Failed to remove role"))
			end
		end)
		task.delay(OPTIMISTIC_FALLBACK_SECS, function()
			clearOptimisticRemove(roleKey, token)
		end)
	end

	scope:Observer(memberData):onChange(function()
		local member = Fusion.peek(memberData)
		local hasKey: {[string]: boolean} = {}
		local hasPerm: {[string]: boolean} = {}
		if member then
			if typeof((member :: any).roleKeys) == "table" then
				for _, roleKey in (member :: any).roleKeys :: {string} do hasKey[roleKey] = true end
			end
			if typeof((member :: any).permanentRoleKeys) == "table" then
				for roleKey in (member :: any).permanentRoleKeys :: {[string]: any} do hasPerm[roleKey] = true end
			end
		end
		local adds = Fusion.peek(optimisticAdds)
		local newAdds = adds
		local addsChanged = false
		for key, info in adds do
			local satisfied = if info.isPermanent then hasPerm[key] == true else hasKey[key] == true
			if satisfied then
				if not addsChanged then newAdds, addsChanged = table.clone(adds), true end
				newAdds[key] = nil
			end
		end
		if addsChanged then optimisticAdds:set(newAdds) end
		local removes = Fusion.peek(optimisticRemoves)
		local newRemoves = removes
		local removesChanged = false
		for key in removes do
			if not hasKey[key] then
				if not removesChanged then newRemoves, removesChanged = table.clone(removes), true end
				newRemoves[key] = nil
			end
		end
		if removesChanged then optimisticRemoves:set(newRemoves) end
	end)

	local rolesAbsSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local rolesAbsPos: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local plusBtnAbsPos: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local plusBtnAbsSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local popupParentAbsPos: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local popupParentAbsSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	local camera = workspace.CurrentCamera
	local viewportAbsSize: Fusion.Value<Vector2> =
		scope:Value(if camera then camera.ViewportSize else Vector2.new(1920, 1080))
	if camera then
		local conn = camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			viewportAbsSize:set(camera.ViewportSize)
		end)
		table.insert(scope, function() conn:Disconnect() end)
	end

	local POPUP_MAX_HEIGHT = 240
	local POPUP_GAP = 6
	local POPUP_VIEWPORT_PAD = 12

	local itemsAbsSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	-- Snapshotted once at open, reactive tracking wobbled during PanelGui drags
	local popupAnchorPoint = Vector2.new(0, 0)
	local popupLocalPos: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local popupLocalSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local popupOpensAbove: Fusion.Value<boolean> = scope:Value(false)
	local popupPosition = scope:Computed(function(use)
		local position = use(popupLocalPos)
		return UDim2.fromOffset(position.X, position.Y)
	end)
	-- Tracked relative to popupParent so a scroll closes the popup but a drag doesn't
	local popupBaselineRel: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local function relButtonPos(): Vector2
		return Fusion.peek(plusBtnAbsPos) - Fusion.peek(popupParentAbsPos)
	end

	local function snapshotPopupGeometry()
		local btnPos = Fusion.peek(plusBtnAbsPos)
		local btnSize = Fusion.peek(plusBtnAbsSize)
		local rolesPos = Fusion.peek(rolesAbsPos)
		local rolesSize = Fusion.peek(rolesAbsSize)
		local parentPos = Fusion.peek(popupParentAbsPos)
		local vp = Fusion.peek(viewportAbsSize)
		local scale = Fusion.peek(Viewport.Scale)
		if scale <= 0 then scale = 1 end

		local desiredLocal = Fusion.peek(itemsAbsSize).Y / scale
		if desiredLocal <= 0 then desiredLocal = POPUP_MAX_HEIGHT end
		if desiredLocal > POPUP_MAX_HEIGHT then desiredLocal = POPUP_MAX_HEIGHT end

		local roomBelowLocal = (vp.Y - (btnPos.Y + btnSize.Y) - POPUP_VIEWPORT_PAD - POPUP_GAP) / scale
		local roomAboveLocal = (btnPos.Y - POPUP_VIEWPORT_PAD - POPUP_GAP) / scale
		local opensAbove = (roomBelowLocal < desiredLocal) and (roomAboveLocal > roomBelowLocal)

		local sideRoom = if opensAbove then roomAboveLocal else roomBelowLocal
		local finalH = math.min(desiredLocal, sideRoom)
		if finalH < 60 then finalH = 60 end

		local widthLocal = rolesSize.X / scale

		local screenY: number
		if opensAbove then
			screenY = btnPos.Y - POPUP_GAP - finalH * scale
		else
			screenY = btnPos.Y + btnSize.Y + POPUP_GAP
		end
		local localX = (rolesPos.X - parentPos.X) / scale
		local localY = (screenY - parentPos.Y) / scale

		popupLocalPos:set(Vector2.new(localX, localY))
		popupLocalSize:set(Vector2.new(widthLocal, finalH))
		popupOpensAbove:set(opensAbove)
	end

	scope:Observer(addPopupOpen):onChange(function()
		if Fusion.peek(addPopupOpen) then
			snapshotPopupGeometry()
			popupBaselineRel:set(relButtonPos())
		end
	end)
	local checkScheduled = false
	local function maybeClose()
		if not Fusion.peek(addPopupOpen) then return end
		if checkScheduled then return end
		checkScheduled = true
		task.defer(function()
			checkScheduled = false
			if not Fusion.peek(addPopupOpen) then return end
			local diff = relButtonPos() - Fusion.peek(popupBaselineRel)
			if math.abs(diff.Y) > 4 or math.abs(diff.X) > 4 then
				addPopupOpen:set(false)
			end
		end)
	end
	scope:Observer(plusBtnAbsPos):onChange(maybeClose)
	scope:Observer(popupParentAbsPos):onChange(maybeClose)

	-- The menu canvas ignores the popup, so this reservation is what grows it to fit
	local reservedBottomHeight = scope:Computed(function(use): number
		if not use(addPopupOpen) then return 0 end
		if use(popupOpensAbove) then return 0 end
		local scale = use(Viewport.Scale)
		if scale <= 0 then scale = 1 end
		local contentLocalH = use(itemsAbsSize).Y / scale
		if contentLocalH > POPUP_MAX_HEIGHT then contentLocalH = POPUP_MAX_HEIGHT end
		return contentLocalH + POPUP_GAP
	end)

	if props.popupParent then
		local popup = scope:New "ScrollingFrame" {
			Name = "AddRolePopup",
			AnchorPoint = popupAnchorPoint,
			Position = popupPosition,
			Size = scope:Computed(function(use)
				local size = use(popupLocalSize)
				return UDim2.fromOffset(size.X, size.Y)
			end),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Visible = scope:Computed(function(use)
				return use(addPopupOpen) and use(canAddRoles)
			end),
			ZIndex = 1000,
			BackgroundColor3 = Theme.Color.Base,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BottomImage = "rbxassetid://16547643439",
			CanvasSize = UDim2.new(),
			MidImage = "rbxassetid://16547330984",
			ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
			ScrollBarImageTransparency = if Platform.isMobile then 1 else 0,
			ScrollBarThickness = if Platform.isMobile then 2 else 8,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Selectable = false,
			TopImage = "rbxassetid://16547667444",
			VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
					Transparency = 0.5,
				},
				scope:New "Frame" {
					Name = "Items",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					[Out("AbsoluteSize")] = itemsAbsSize,
					[Children] = {
						scope:New "UIPadding" {
							PaddingTop = UDim.new(0, 6),
							PaddingBottom = UDim.new(0, 6),
							PaddingLeft = UDim.new(0, 6),
							PaddingRight = UDim.new(0, 6),
						},
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
							Padding = UDim.new(0, 8),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						scope:New "Frame" {
							Name = "ScopeToggle",
							LayoutOrder = 0,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 0),
							Visible = scope:Computed(function(use)
								return use(serverPillAvailable) or use(canUseGivePermRole)
							end),
							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Left,
									HorizontalFlex = Enum.UIFlexAlignment.None,
									Wraps = true,
									Padding = UDim.new(0, 6),
									SortOrder = Enum.SortOrder.LayoutOrder,
									VerticalAlignment = Enum.VerticalAlignment.Center,
								},
								scope:New "TextLabel" {
									Name = "Label",
									LayoutOrder = 1,
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
									end),
									Text = "Scope:",
									TextColor3 = Theme.Color.NeutralContentDark,
									TextSize = Theme.TextSize.Label,
								},
								-- Matches RoleBadge's large variant sizing
								(function()
									local pillPadV, pillPadH, pillTextSize = 6, 11, 17
									local function makeScopePill(props2: {
										name: string,
										value: "server" | "perm",
										label: string,
										layoutOrder: number,
										visible: Fusion.Computed<boolean>,
										canUse: Fusion.Computed<boolean>,
									})
										return Pressable(scope, {
											name = props2.name,
											layoutOrder = props2.layoutOrder,
											automaticSize = Enum.AutomaticSize.XY,
											visible = props2.visible,
											backgroundColor = scope:Computed(function(use)
												return if use(giveScope) == props2.value
													then use(Theme.Color.Primary)
													else use(Theme.Color.Neutral)
											end),
											onActivate = function()
												if Fusion.peek(props2.canUse) then
													giveScope:set(props2.value)
												end
											end,
											[Children] = {
												scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
												scope:New "UIStroke" {
													ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
													Color = Theme.Color.NeutralStroke,
													Transparency = 0.5,
												},
												scope:New "UIPadding" {
													PaddingTop = UDim.new(0, pillPadV),
													PaddingBottom = UDim.new(0, pillPadV),
													PaddingLeft = UDim.new(0, pillPadH),
													PaddingRight = UDim.new(0, pillPadH),
												},
												scope:New "TextLabel" {
													Name = "Label",
													AutomaticSize = Enum.AutomaticSize.XY,
													BackgroundTransparency = 1,
													FontFace = scope:Computed(function(use)
														return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
													end),
													Text = props2.label,
													TextColor3 = scope:Computed(function(use)
														return if use(giveScope) == props2.value
															then use(Theme.Color.PrimaryContent)
															else use(Theme.Color.BaseContent)
													end),
													TextSize = pillTextSize,
												},
											},
										})
									end
									return scope:New "Frame" {
										Name = "ScopePillsHolder",
										LayoutOrder = 2,
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										[Children] = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Horizontal,
												HorizontalFlex = Enum.UIFlexAlignment.None,
												Padding = UDim.new(0, 6),
												SortOrder = Enum.SortOrder.LayoutOrder,
												VerticalAlignment = Enum.VerticalAlignment.Center,
												Wraps = true,
											},
											makeScopePill({
												name = "ScopePill_Server",
												value = "server",
												label = "Server",
												layoutOrder = 1,
												visible = serverPillAvailable,
												canUse = serverPillAvailable,
											}),
											makeScopePill({
												name = "ScopePill_Permanent",
												value = "perm",
												label = "Permanent",
												layoutOrder = 2,
												visible = canUseGivePermRole,
												canUse = canUseGivePermRole,
											}),
										},
									}
								end)(),
							},
						},
						scope:New "Frame" {
							Name = "RolesFlow",
							LayoutOrder = 1,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 0),
							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Left,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Wraps = true,
									Padding = UDim.new(0, 6),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								scope:ForValues(availableRoles, function(_, optScope, role: any, _i: number)
									-- Matches RoleBadge's large variant sizing
									local padV, padH, dotSize, gap, textSize = 6, 11, 10, 6, 17
									return Pressable(optScope, {
										name = "RoleOption_" .. role.key,
										automaticSize = Enum.AutomaticSize.XY,
										backgroundColor = Theme.Color.Neutral,
										onActivate = function()
											onGiveRole(role.key)
										end,
										[Children] = {
											optScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
											optScope:New "UIPadding" {
												PaddingTop = UDim.new(0, padV),
												PaddingBottom = UDim.new(0, padV),
												PaddingLeft = UDim.new(0, padH),
												PaddingRight = UDim.new(0, padH),
											},
											optScope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Horizontal,
												VerticalAlignment = Enum.VerticalAlignment.Center,
												SortOrder = Enum.SortOrder.LayoutOrder,
												Padding = UDim.new(0, gap),
											},
											optScope:New "ImageLabel" {
												Name = "PermIcon",
												LayoutOrder = 0,
												BackgroundTransparency = 1,
												Image = "rbxassetid://132613467203568",
												ImageColor3 = Theme.Color.BaseContent,
												Size = UDim2.fromOffset(dotSize + 4, dotSize + 4),
												Visible = optScope:Computed(function(use)
													return use(giveScope) == "perm"
												end),
											},
											optScope:New "Frame" {
												Name = "Dot",
												LayoutOrder = 1,
												Size = UDim2.fromOffset(dotSize, dotSize),
												BackgroundColor3 = role.color,
												[Children] = {
													optScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
												},
											},
											optScope:New "TextLabel" {
												Name = "Name",
												LayoutOrder = 2,
												AutomaticSize = Enum.AutomaticSize.XY,
												BackgroundTransparency = 1,
												FontFace = optScope:Computed(function(use)
													return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
												end),
												Text = role.name,
												TextColor3 = Theme.Color.BaseContent,
												TextSize = textSize,
												TextWrapped = false,
											},
										},
									})
								end),
							},
						},
					},
				},
			},
		}
		popup.Parent = props.popupParent

		local parent: any = props.popupParent :: any
		popupParentAbsPos:set(parent.AbsolutePosition)
		popupParentAbsSize:set(parent.AbsoluteSize)
		local connPos = parent:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			popupParentAbsPos:set(parent.AbsolutePosition)
		end)
		local connSize = parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			popupParentAbsSize:set(parent.AbsoluteSize)
		end)
		table.insert(scope, function()
			connPos:Disconnect()
			connSize:Disconnect()
		end)
	end

	return scope:New "Frame" {
		Name = "ProfileBody",
		AutomaticSize = if inline then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
		BackgroundTransparency = 1,
		Size = if inline then UDim2.new(1, 0, 0, 0) else UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "UIPadding" {
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 2),
				PaddingLeft = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 6),
				PaddingTop = UDim.new(0, 6),
			},

			scope:New "Frame" {
				Name = "Content",
				AutomaticSize = if inline then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
				BackgroundTransparency = 1,
				Size = if inline then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 1, 0),
				ZIndex = 2,

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						VerticalFlex = Enum.UIFlexAlignment.None,
						Padding = UDim.new(0, 14),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "Frame" {
						Name = "Header",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.new(1, 0, 0, 0),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Padding = UDim.new(0, 10),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							scope:New "ImageLabel" {
								Name = "Avatar",
								BackgroundColor3 = Theme.Color.NeutralDark,
								Image = thumbUrl,
								LayoutOrder = 1,
								Size = UDim2.fromOffset(60, 60),
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								},
							},
							scope:New "Frame" {
								Name = "Names",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 2,
								Size = UDim2.new(1, -70, 0, 0),
								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Vertical,
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									scope:New "TextLabel" {
										Name = "DisplayName",
										AutomaticSize = Enum.AutomaticSize.Y,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
										end),
										LayoutOrder = 1,
										Size = UDim2.new(1, 0, 0, 0),
										Text = scope:Computed(function(use)
											local member = use(memberData)
											if member and typeof((member :: any).userDisplayName) == "string" then
												return (member :: any).userDisplayName
											end
											local resolved = use(resolvedUserName)
											if resolved ~= "" then return resolved end
											local id = if typeof(userId) == "table" then use(userId) else userId
											return tostring(id)
										end),
										TextColor3 = Theme.Color.BaseContent,
										TextSize = 24,
										TextTruncate = Enum.TextTruncate.AtEnd,
										TextXAlignment = Enum.TextXAlignment.Left,
										TextYAlignment = Enum.TextYAlignment.Top,
									},
									scope:New "TextLabel" {
										Name = "Username",
										AutomaticSize = Enum.AutomaticSize.Y,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										LayoutOrder = 2,
										Size = UDim2.new(1, 0, 0, 0),
										Text = scope:Computed(function(use)
											local member = use(memberData)
											if member and typeof((member :: any).userName) == "string" then
												return `@{(member :: any).userName}`
											end
											local resolved = use(resolvedUserName)
											if resolved ~= "" then return `@{resolved}` end
											return ""
										end),
										TextColor3 = Theme.Color.NeutralContentDark,
										TextSize = Theme.TextSize.Subtitle,
										TextTruncate = Enum.TextTruncate.AtEnd,
										TextXAlignment = Enum.TextXAlignment.Left,
										TextYAlignment = Enum.TextYAlignment.Top,
									},
								},
							},
						},
					},

					BanBanner(scope, {
						userId = if typeof(userId) == "table" then userId :: any else userId,
						layoutOrder = 2,
					}),

					-- Same Wraps over-count fix as the giver view's section badges above
					(function()
						local rolesContentSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
						return scope:New "Frame" {
							Name = "Roles",
							BackgroundTransparency = 1,
							LayoutOrder = 3,
							Size = scope:Computed(function(use)
								return UDim2.new(1, 0, 0, use(rolesContentSize).Y)
							end),
							[Out("AbsoluteSize")] = rolesAbsSize,
							[Out("AbsolutePosition")] = rolesAbsPos,
							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Left,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Wraps = true,
									Padding = UDim.new(0, 6),
									SortOrder = Enum.SortOrder.LayoutOrder,
									[Out("AbsoluteContentSize")] = rolesContentSize,
								},
								scope:ForValues(rolesList, function(_, badgeScope, role: any, index: number)
									return RoleBadge(badgeScope, {
										id = badgeScope:Value(role.id),
										name = badgeScope:Value(role.name),
										color = badgeScope:Value(role.color),
										large = true,
										isPermanent = badgeScope:Value(role.isPermanent),
										isGiver = badgeScope:Value(role.isGiver),
										userId = badgeScope:Computed(function(use)
											-- nil hides the X
											if role.isGiver and not role.isPermanent then
												return nil :: any
											end
											if role.isPermanent then
												if not use(canUseTakePermRole) then return nil :: any end
											else
												if not use(canUseTakeServerRole) then return nil :: any end
											end
											local id = if typeof(userId) == "table" then use(userId) else userId
											return id
										end) :: any,
										onRemove = function(roleId: string, _userId: number)
											onRemoveRole(roleId, if role.isPermanent then "perm" else "server")
										end,
									})
								end),
								scope:New "Frame" {
									Name = "AddButton",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									LayoutOrder = 9999,
									Visible = canAddRoles,
									[Out("AbsolutePosition")] = plusBtnAbsPos,
									[Out("AbsoluteSize")] = plusBtnAbsSize,
									[Children] = {
										SearchRowToggle(scope, {
											name = "AddRoleToggle",
											text = scope:Computed(function(use)
												return if use(addPopupOpen) then "x" else "+"
											end),
											size = UDim2.fromOffset(28, 28),
											isActive = addPopupOpen,
											cornerRadius = UDim.new(1, 0),
											onActivate = function()
												addPopupOpen:set(not Fusion.peek(addPopupOpen))
											end,
										}),
									},
								},
							},
						}
					end)(),

					scope:New "Frame" {
						Name = "BottomReservation",
						BackgroundTransparency = 1,
						LayoutOrder = 4,
						Size = scope:Computed(function(use)
							return UDim2.new(1, 0, 0, use(reservedBottomHeight))
						end),
					},
				},
			},

		},
	}
end
