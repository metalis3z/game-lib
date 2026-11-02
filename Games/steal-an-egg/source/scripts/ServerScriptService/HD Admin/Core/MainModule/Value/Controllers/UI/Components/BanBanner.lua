--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Permissions = require(frontend.Util.Permissions)
local Pressable = require(frontend.Components.Pressable)
local nameValueFor = require(frontend.Util.nameValueFor)
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	userId: UsedAs<number>,
	layoutOrder: UsedAs<number>?,
}

type Resolved = {
	ban: any,
	banId: string,
	key: string, -- "loader" | "perm" | "expire" | "server"
}


-- CONSTANTS
local INDICATOR_LABELS = {
	loader = "Loader",
	perm   = "Perm",
	expire = "Time",
	server = "Server",
}


-- HELPERS
local function isEntryActive(entry: any, now: number): boolean
	local entryType = (entry :: any).type or "perm"
	if entryType == "expire" then
		local exp = (entry :: any).expiresAt
		return typeof(exp) == "number" and exp > now
	end
	return true
end

local function resolveDominantBan(
	userId: number,
	serverFeed: any,
	permanentFeed: any
): Resolved?
	local key = tostring(userId)
	local now = os.time()
	local best: Resolved? = nil
	local bestBannedAt: number = -math.huge
	local function rank(kindKey: string): number
		if kindKey == "loader" then return 4 end
		if kindKey == "perm"   then return 3 end
		if kindKey == "expire" then return 2 end
		if kindKey == "server" then return 1 end
		return 0
	end
	for _, feed in { serverFeed, permanentFeed } do
		if typeof(feed) ~= "table" then continue end
		local record = (feed :: any)[key]
		if typeof(record) ~= "table" then continue end
		local bans = (record :: any).Bans
		if typeof(bans) ~= "table" then continue end
		for banId, entry in bans :: any do
			if typeof(banId) ~= "string" or typeof(entry) ~= "table" then continue end
			if not isEntryActive(entry, now) then continue end
			local entryKey: string
			if (entry :: any).source == "loader" then
				entryKey = "loader"
			else
				entryKey = (entry :: any).type or "perm"
			end
			local entryBannedAt = if typeof((entry :: any).bannedAt) == "number"
				then (entry :: any).bannedAt
				else 0
			local takes = false
			if not best then
				takes = true
			elseif rank(entryKey) > rank(best.key) then
				takes = true
			elseif rank(entryKey) == rank(best.key) and entryBannedAt > bestBannedAt then
				takes = true
			end
			if takes then
				best = { ban = entry, banId = banId, key = entryKey }
				bestBannedAt = entryBannedAt
			end
		end
	end
	return best
end

local function formatRemaining(remaining: number): string
	if remaining <= 0 then return "Soon" end
	local units = {
		{ name = "day",    seconds = 86400 },
		{ name = "hour",   seconds = 3600 },
		{ name = "minute", seconds = 60 },
		{ name = "second", seconds = 1 },
	}
	local parts: {string} = {}
	for _, unit in units do
		if remaining < unit.seconds then continue end
		local count = math.floor(remaining / unit.seconds)
		remaining -= count * unit.seconds
		local suffix = if count == 1 then unit.name else unit.name .. "s"
		table.insert(parts, `{count} {suffix}`)
		if #parts >= 2 then break end
	end
	if #parts == 0 then return "Soon" end
	return "in " .. table.concat(parts, " ")
end

local function formatRelativePast(ts: number, now: number): string
	if typeof(ts) ~= "number" or ts <= 0 then return "" end
	local diff = math.max(0, now - ts)
	if diff < 60 then return "just now" end
	local units = {
		{ name = "day",    seconds = 86400 },
		{ name = "hour",   seconds = 3600 },
		{ name = "minute", seconds = 60 },
	}
	for _, unit in units do
		if diff < unit.seconds then continue end
		local count = math.floor(diff / unit.seconds)
		local suffix = if count == 1 then unit.name else unit.name .. "s"
		return `{count} {suffix} ago`
	end
	return "just now"
end

local function formatAbsolute(ts: number): string
	if typeof(ts) ~= "number" or ts <= 0 then return "" end
	local date = os.date("*t", ts) :: any
	return string.format("%04d-%02d-%02d %02d:%02d",
		date.year, date.month, date.day, date.hour, date.min)
end


-- COMPONENT
return function(scope: Scope, props: Props): Instance
	local userIdProp = props.userId
	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	local nowValue: Fusion.Value<number> = scope:Value(os.time())
	local serverBansFuse: any = (scope :: any):Fuse("everyone", "ServerBans")
	local permanentBansFuse: any = (scope :: any):Fuse("everyone", "PermanentBans")

	local dominant = scope:Computed(function(use): Resolved?
		local id = if typeof(userIdProp) == "table" then use(userIdProp :: any) else userIdProp
		if typeof(id) ~= "number" or id <= 0 then return nil end
		return resolveDominantBan(id, use(serverBansFuse), use(permanentBansFuse))
	end)

	-- The clock only runs for expire bans, always-on ticking re-ran every open profile per second
	local needsTick = scope:Computed(function(use): boolean
		local resolved = use(dominant)
		return resolved ~= nil and (resolved.ban :: any).type == "expire"
	end)
	task.spawn(function()
		while not destroyed do
			task.wait(1)
			if destroyed then return end
			if not Fusion.peek(needsTick) then continue end
			nowValue:set(os.time())
		end
	end)

	local isBanned = scope:Computed(function(use)
		return use(dominant) ~= nil
	end)

	local pillLabel = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		return (INDICATOR_LABELS :: any)[resolved.key] or ""
	end)

	local scopeLabel = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		if resolved.key == "server" then return "Banned from this server" end
		return "Banned from all servers"
	end)

	local reasonText = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		local reason = (resolved.ban :: any).reason
		return if typeof(reason) == "string" and reason ~= "" then reason else "No reason given"
	end)

	-- Inlining GetNameFromUserIdAsync in the Computed re-fired the call every re-run
	local bannedByUserId: Fusion.Value<number?> = scope:Value(nil)
	scope:Observer(dominant):onChange(function()
		local resolved = Fusion.peek(dominant)
		if not resolved then bannedByUserId:set(nil); return end
		if resolved.key == "loader" then bannedByUserId:set(nil); return end
		local by = (resolved.ban :: any).bannedBy
		if typeof(by) ~= "number" or by <= 0 then bannedByUserId:set(nil); return end
		bannedByUserId:set(by)
	end)
	do
		local resolved = Fusion.peek(dominant)
		if resolved and resolved.key ~= "loader" then
			local by = (resolved.ban :: any).bannedBy
			if typeof(by) == "number" and by > 0 then bannedByUserId:set(by) end
		end
	end
	local bannedByName = nameValueFor(scope, bannedByUserId :: any)

	local bannedByText = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		if resolved.key == "loader" then return "System (loader file)" end
		local by = (resolved.ban :: any).bannedBy
		if typeof(by) ~= "number" or by <= 0 then return "System" end
		local name = use(bannedByName)
		if name == "" then return tostring(by) end
		return `{name} (@{name})`
	end)

	local bannedAtText = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		local at = (resolved.ban :: any).bannedAt
		if typeof(at) ~= "number" or at <= 0 then return "Unknown" end
		local now = use(nowValue)
		local rel = formatRelativePast(at, now)
		local abs = formatAbsolute(at)
		if rel == "" then return abs end
		return `{rel} ({abs})`
	end)

	local expiresText = scope:Computed(function(use): string
		local resolved = use(dominant)
		if not resolved then return "" end
		local ban: any = resolved.ban
		if ban.type ~= "expire" then return "Never" end
		local exp = ban.expiresAt
		if typeof(exp) ~= "number" then return "Unknown" end
		local now = use(nowValue)
		return formatRemaining(exp - now)
	end)
	local hasExpiry = scope:Computed(function(use): boolean
		local resolved = use(dominant)
		return resolved ~= nil and (resolved.ban :: any).type == "expire"
	end)

	local hasRobloxCover = scope:Computed(function(use): boolean
		local resolved = use(dominant)
		return resolved ~= nil and (resolved.ban :: any).banAlts == true
	end)

	local canUnban = Permissions.canUseCommand(scope, "unban")
	local canUnServerBan = Permissions.canUseCommand(scope, "unserverban")

	local unbanState = scope:Computed(function(use): { enabled: boolean, reason: string? }
		local resolved = use(dominant)
		if not resolved then return { enabled = false } end
		if resolved.key == "loader" then
			return { enabled = false, reason = "Loader bans are immutable - edit Loader/Config/Bans.luau" }
		end
		if resolved.key == "server" then
			if use(canUnServerBan) then return { enabled = true } end
			return { enabled = false, reason = "You don't have permission (;unServerBan)" }
		end
		if use(canUnban) then return { enabled = true } end
		return { enabled = false, reason = "You don't have permission (;unban)" }
	end)

	-- armToken stops a stale 2s timer disarming a newer arm
	local isArmed: Fusion.Value<boolean> = scope:Value(false)
	local isPending: Fusion.Value<boolean> = scope:Value(false)
	local armToken = 0
	local function disarm()
		armToken += 1
		isArmed:set(false)
	end
	local function arm()
		armToken += 1
		local thisToken = armToken
		isArmed:set(true)
		task.delay(2, function()
			if destroyed then return end
			if armToken ~= thisToken then return end
			isArmed:set(false)
		end)
	end
	-- The dominant ban can change mid-arm and confirm would target the wrong banId
	scope:Observer(dominant):onChange(function()
		if Fusion.peek(isArmed) then disarm() end
	end)

	local function fireUnban()
		if Fusion.peek(isPending) then return end
		local resolved = Fusion.peek(dominant)
		if not resolved then return end
		local state = Fusion.peek(unbanState) :: any
		if not state.enabled then return end
		if not Fusion.peek(isArmed) then
			arm()
			return
		end
		disarm()
		local id = if typeof(userIdProp) == "table" then Fusion.peek(userIdProp :: any) else userIdProp
		if typeof(id) ~= "number" or id <= 0 then return end
		local remote = Remote.get("UnbanUser")
		if not remote then
			Prompt.error("Unban remote not available")
			return
		end
		isPending:set(true)
		task.spawn(function()
			-- nil banId clears every stacked entry so one click fully unbans
			local ok, err = remote:invokeServerAsync(id, nil)
			if destroyed then return end
			isPending:set(false)
			if not ok then
				Prompt.error(tostring(err or "Failed to unban"))
				return
			end
			Prompt.success("Unbanned")
		end)
	end


	-- LOCAL FUNCTIONS
	local function fieldRow(layoutOrder: number, label: string, valueText: any, visible: any?): Instance
		return scope:New "Frame" {
			Name = "Field_" .. label,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = layoutOrder,
			Size = UDim2.new(1, 0, 0, 0),
			Visible = visible,
			[Children] = {
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				scope:New "TextLabel" {
					Name = "Label",
					LayoutOrder = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Size = UDim2.new(0, 68, 0, 0),
					Text = label .. ":",
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Label,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				},
				scope:New "TextLabel" {
					Name = "Value",
					LayoutOrder = 2,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Size = UDim2.new(1, -76, 0, 0),
					Text = valueText,
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Label,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				},
			},
		}
	end


	-- BANNER
	return scope:New "Frame" {
		Name = "BanBanner",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Color.Primary,
		BackgroundTransparency = 0.88,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.new(1, 0, 0, 0),
		Visible = isBanned,

		[Children] = {
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.Primary,
				Thickness = 1,
			},
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "Frame" {
				Name = "Title",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 0),
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "TextLabel" {
						Name = "ScopeLabel",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
						end),
						Size = UDim2.new(0, 0, 0, 0),
						Text = scope:Computed(function(use)
							return `🚫 {use(scopeLabel)}`
						end),
						TextColor3 = Theme.Color.Primary,
						TextSize = Theme.TextSize.Body,
						TextXAlignment = Enum.TextXAlignment.Left,
					},

					scope:New "Frame" {
						Name = "TypePill",
						LayoutOrder = 2,
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Theme.Color.Primary,
						Size = UDim2.new(0, 0, 0, 22),
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							scope:New "UIPadding" {
								PaddingLeft = UDim.new(0, 10),
								PaddingRight = UDim.new(0, 10),
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								Size = UDim2.new(0, 0, 1, 0),
								Text = pillLabel,
								TextColor3 = Theme.Color.PrimaryContent,
								TextSize = Theme.TextSize.Label,
							},
						},
					},
				},
			},

			fieldRow(2, "Reason",    reasonText,   nil),
			fieldRow(3, "Banned by", bannedByText, nil),
			fieldRow(4, "Banned at", bannedAtText, nil),
			fieldRow(5, "Expires",   expiresText,  hasExpiry),
			fieldRow(6, "Roblox",
				scope:Computed(function(): string return "Includes Roblox Web Ban" end),
				hasRobloxCover),

			scope:New "Frame" {
				Name = "ActionFooter",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 7,
				Size = UDim2.new(1, 0, 0, 0),
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					Pressable(scope, {
						name = "UnbanButton",
						layoutOrder = 1,
						size = UDim2.fromOffset(0, 0),
						automaticSize = Enum.AutomaticSize.Y,
						backgroundColor = scope:Computed(function(use)
							local state = use(unbanState) :: any
							return if state.enabled then use(Theme.Color.Primary) else use(Theme.Color.NeutralContent)
						end),
						interactable = scope:Computed(function(use)
							return (use(unbanState) :: any).enabled and not use(isPending)
						end),
						onActivate = fireUnban,
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							scope:New "UIPadding" {
								PaddingLeft = UDim.new(0, 18),
								PaddingRight = UDim.new(0, 18),
								PaddingTop = UDim.new(0, 6),
								PaddingBottom = UDim.new(0, 6),
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								Size = UDim2.new(1, 0, 0, 0),
								Text = scope:Computed(function(use)
									if use(isPending) then return "Unbanning..." end
									return if use(isArmed) then "Confirm?" else "Unban"
								end),
								TextColor3 = scope:Computed(function(use)
									local state = use(unbanState) :: any
									return if state.enabled then use(Theme.Color.PrimaryContent) else use(Theme.Color.NeutralContentDark)
								end),
								TextSize = Theme.TextSize.Body,
								TextXAlignment = Enum.TextXAlignment.Center,
								TextYAlignment = Enum.TextYAlignment.Center,
							},
						},
					}),

					scope:New "TextLabel" {
						Name = "DisabledReason",
						LayoutOrder = 2,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						Size = UDim2.new(1, 0, 0, 0),
						Text = scope:Computed(function(use)
							local state = use(unbanState) :: any
							return state.reason or ""
						end),
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Small,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						Visible = scope:Computed(function(use)
							local state = use(unbanState) :: any
							return (not state.enabled) and (state.reason ~= nil)
						end),
					},
				},
			},
		},
	}
end
