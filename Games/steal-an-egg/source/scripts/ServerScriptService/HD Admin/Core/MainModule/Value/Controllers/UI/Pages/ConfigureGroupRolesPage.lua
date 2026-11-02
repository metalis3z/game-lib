--!strict

-- Note from ben: names go along with ranks because Roblox groups can have two roles
-- sharing a Rank, so to match, we need both fields


-- LOCAL
local GroupService = game:GetService("GroupService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local SearchBar = require(frontend.Components.SearchBar)
local CheckItem = require(frontend.Components.CheckItem)
local Pressable = require(frontend.Components.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type GroupRole = {Name: string, Rank: number}
-- Both fields store at confirm time so qualifier checks can disambiguate shared ranks
type RoleRow = {key: string, label: string, body: string?, rank: number?, name: string?, order: number}
type PickerItem = {
	key: string,
	label: string,
	header: string,
	body: string?,
	icon: string?,
	rawValue: any,
	category: ("player" | "qualifier" | "custom" | "preset")?,
	groupConfig: boolean?,
}
type Props = {
	groupId: UsedAs<number?>?,
	currentEntry: UsedAs<any?>?, -- the role's saved GroupEntry; pre-ticks matching boxes, else defaults to "All Roles"
	onConfirm: UsedAs<((item: PickerItem, replacesKey: string?) -> ())?>?, -- replacesKey lets ItemSelector swap the entry
	onBack: (() -> ())?,
}

local ALL_ROLES_KEY = "__all_roles"


-- COMPONENT
return function(scope: Scope, props: Props)
	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	local searchText: Fusion.Value<string> = scope:Value("")
	local isLoading: Fusion.Value<boolean> = scope:Value(false)
	local loadError: Fusion.Value<string> = scope:Value("")
	local allRows: Fusion.Value<{RoleRow}> = scope:Value({} :: {RoleRow})
	local resolvedGroupName: Fusion.Value<string> = scope:Value("")
	local pendingKeys: Fusion.Value<{[string]: boolean}> = scope:Value({[ALL_ROLES_KEY] = true})

	local function seedPendingFromEntry(rows: {RoleRow})
		-- Match precedence is exact (rank + name), then name-only for re-ranks,
		-- then rank-only for legacy roleIds entries
		local rawEntry = if props.currentEntry ~= nil
			then (if typeof(props.currentEntry) == "table" then Fusion.peek(props.currentEntry :: any) else props.currentEntry)
			else nil
		local entryType = if typeof(rawEntry) == "table" then (rawEntry :: any).type else nil
		if entryType ~= "SpecificRoles" or typeof(rawEntry) ~= "table" then
			pendingKeys:set({[ALL_ROLES_KEY] = true})
			return
		end

		local cfgRoles: {{rank: number, name: string}} = {}
		if typeof((rawEntry :: any).roles) == "table" then
			for _, role in (rawEntry :: any).roles :: {any} do
				if typeof(role) == "table"
					and typeof((role :: any).rank) == "number"
					and typeof((role :: any).name) == "string"
				then
					table.insert(cfgRoles, {rank = (role :: any).rank, name = (role :: any).name})
				end
			end
		end
		-- Legacy roleIds convert to {rank=id, name=""} so the seed can match by rank only
		if #cfgRoles == 0 and typeof((rawEntry :: any).roleIds) == "table" then
			for _, rid in (rawEntry :: any).roleIds :: {any} do
				if typeof(rid) == "number" then
					table.insert(cfgRoles, {rank = rid, name = ""})
				end
			end
		end

		if #cfgRoles == 0 then
			pendingKeys:set({[ALL_ROLES_KEY] = true})
			return
		end

		local seeded: {[string]: boolean} = {}
		for _, cfg in cfgRoles do
			local exactRow: RoleRow? = nil
			local nameRow: RoleRow? = nil
			local rankRow: RoleRow? = nil
			for _, row in rows do
				if row.rank == nil then continue end
				local sameRank = row.rank == cfg.rank
				local sameName = typeof(row.name) == "string" and #(row.name :: string) > 0 and row.name == cfg.name
				if sameRank and sameName then
					exactRow = row
					break
				end
				if sameName and nameRow == nil then
					nameRow = row
				end
				if sameRank and rankRow == nil then
					rankRow = row
				end
			end
			local pick = exactRow or nameRow or rankRow
			if pick then
				seeded[(pick :: RoleRow).key] = true
			end
		end

		if next(seeded) == nil then
			pendingKeys:set({[ALL_ROLES_KEY] = true})
			return
		end
		pendingKeys:set(seeded)
	end

	local function resetAndFetch()
		searchText:set("")
		loadError:set("")
		resolvedGroupName:set("")
		pendingKeys:set({[ALL_ROLES_KEY] = true})
		allRows:set({} :: {RoleRow})
		local gid = if props.groupId then Fusion.peek(props.groupId :: any) else nil
		if typeof(gid) ~= "number" or (gid :: number) <= 0 then return end
		isLoading:set(true)
		task.spawn(function()
			local ok, info: any = pcall(function()
				return GroupService:GetGroupInfoAsync(gid :: number)
			end)
			if destroyed then return end
			isLoading:set(false)
			if not ok or typeof(info) ~= "table" then
				loadError:set("Failed to load group roles.")
				return
			end
			resolvedGroupName:set(if typeof(info.Name) == "string" then info.Name else "Group " .. tostring(gid))
			local rows: {RoleRow} = {}
			table.insert(rows, {key = ALL_ROLES_KEY, label = "All Roles", body = nil, rank = nil, name = nil, order = 0})
			if typeof(info.Roles) == "table" then
				local sorted: {GroupRole} = {}
				for _, role in info.Roles :: any do
					if typeof(role) == "table" and typeof(role.Name) == "string" and typeof(role.Rank) == "number" then
						table.insert(sorted, {Name = role.Name, Rank = role.Rank})
					end
				end
				table.sort(sorted, function(roleA, roleB) return roleA.Rank < roleB.Rank end)
				for index, role in sorted do
					-- The key combines rank and name so roles sharing a rank stay distinct rows
					table.insert(rows, {
						key = "role:" .. tostring(role.Rank) .. ":" .. role.Name,
						label = role.Name,
						body = "Rank " .. tostring(role.Rank),
						rank = role.Rank,
						name = role.Name,
						order = index,
					})
				end
			end
			allRows:set(rows)
			seedPendingFromEntry(rows)
		end)
	end

	if props.groupId ~= nil then
		scope:Observer(props.groupId :: any):onChange(resetAndFetch)
	end
	-- Opening the cog for the same group on a different role leaves groupId
	-- unchanged, so re-seed on currentEntry too, skipping the fetch
	if props.currentEntry ~= nil then
		scope:Observer(props.currentEntry :: any):onChange(function()
			local rows = Fusion.peek(allRows) :: {RoleRow}
			if #rows > 0 then
				seedPendingFromEntry(rows)
			end
		end)
	end
	resetAndFetch()

	local filteredRows: Fusion.Computed<{RoleRow}> = scope:Computed(function(use)
		local rows = use(allRows) :: {RoleRow}
		local query = string.lower((string.gsub(use(searchText) :: string, "%s", "")))
		if #query == 0 then return rows end
		local result: {RoleRow} = {}
		for _, row in rows do
			if row.key == ALL_ROLES_KEY or string.find(string.lower(row.label), query, 1, true) then
				table.insert(result, row)
			end
		end
		return result
	end)

	local function toggleKey(key: string)
		if key == ALL_ROLES_KEY then return end
		local current = Fusion.peek(pendingKeys) :: {[string]: boolean}
		local copy = table.clone(current)
		if copy[key] then
			copy[key] = nil
		else
			copy[key] = true
			copy[ALL_ROLES_KEY] = nil
		end
		local hasSpecific = false
		for pendingKey in copy do
			if pendingKey ~= ALL_ROLES_KEY then hasSpecific = true; break end
		end
		if not hasSpecific then
			copy[ALL_ROLES_KEY] = true
		end
		pendingKeys:set(copy)
	end

	local selectedCount = scope:Computed(function(use)
		local keys = use(pendingKeys) :: {[string]: boolean}
		local count = 0
		for _ in keys do count += 1 end
		return count
	end)

	local function onConfirm()
		local gid = if props.groupId then Fusion.peek(props.groupId :: any) else nil
		if typeof(gid) ~= "number" then return end
		local keys = Fusion.peek(pendingKeys) :: {[string]: boolean}
		local confirmFn = if props.onConfirm then Fusion.peek(props.onConfirm :: any) else nil
		if typeof(confirmFn) ~= "function" then
			if props.onBack then props.onBack() end
			return
		end
		local groupName = Fusion.peek(resolvedGroupName) :: string
		local replacesKey = "group:" .. tostring(gid)
		local isAllRoles = keys[ALL_ROLES_KEY] == true
		local rawValue: any
		local subtitle: string
		if isAllRoles then
			rawValue = {type = "AnyMember", groupId = gid}
			subtitle = "All Roles"
		else
			local cfgRoles: {{rank: number, name: string}} = {}
			local roleNames: {string} = {}
			local rows = Fusion.peek(allRows) :: {RoleRow}
			for _, row in rows do
				if row.rank ~= nil and typeof(row.name) == "string" and keys[row.key] then
					table.insert(cfgRoles, {rank = row.rank :: number, name = row.name :: string})
					table.insert(roleNames, row.label)
				end
			end
			if #cfgRoles == 0 then
				rawValue = {type = "AnyMember", groupId = gid}
				subtitle = "All Roles"
			else
				rawValue = {type = "SpecificRoles", groupId = gid, roles = cfgRoles}
				subtitle = table.concat(roleNames, ", ")
			end
		end
		local item: PickerItem = {
			key = replacesKey,
			label = groupName,
			header = groupName,
			body = tostring(gid),
			icon = "rbxthumb://type=GroupIcon&id=" .. tostring(gid) .. "&w=150&h=150",
			rawValue = rawValue,
			category = "custom",
			groupConfig = true,
			roleLabel = subtitle,
		}
		;(confirmFn :: any)(item, replacesKey)
		if props.onBack then props.onBack() end
	end

	local confirmBgColor = Theme.Color.Primary
	local confirmStrokeGradient = scope:Computed(function(use)
		local primary = use(Theme.Color.Primary)
		local hue, saturation, value = Color3.toHSV(primary)
		local lighter = Color3.fromHSV(hue, saturation * 0.92, math.min(value * 1.06, 1))
		return ColorSequence.new({
			ColorSequenceKeypoint.new(0, lighter),
			ColorSequenceKeypoint.new(1, primary),
		})
	end)

	return scope:New "Frame" {
		Name = "ConfigureGroupRolesPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "Frame" {
				Name = "ListArea",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					SearchBar(scope, {
						searchText = searchText,
						placeholderText = "Filter roles...",
						layoutOrder = 0,
					}),

					scope:New "TextLabel" {
						Name = "StatusLabel",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 0),
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
						end),
						Text = scope:Computed(function(use)
							if use(isLoading) then return "Loading roles..." end
							return use(loadError :: any) :: string
						end),
						TextColor3 = scope:Computed(function(use)
							if use(isLoading) then
								return use(Theme.Color.NeutralContentDark)
							end
							return use(Theme.Color.Error)
						end),
						TextSize = scope:Computed(function(use) return use(Theme.TextSize.Small) * 1.5 end),
						TextXAlignment = Enum.TextXAlignment.Left,
						Visible = scope:Computed(function(use)
							return use(isLoading) or #(use(loadError :: any) :: string) > 0
						end),
						[Children] = {
							scope:New "UIPadding" {
								PaddingLeft = UDim.new(0, 12),
								PaddingRight = UDim.new(0, 12),
								PaddingBottom = UDim.new(0, 4),
							},
						},
					},

					scope:New "ScrollingFrame" {
						Name = "Results",
						LayoutOrder = 2,
						BackgroundTransparency = 1,
						CanvasSize = UDim2.fromOffset(0, 0),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollBarThickness = 4,
						ScrollBarImageColor3 = Theme.Color.NeutralStroke,
						Size = UDim2.fromScale(1, 1),
						[Children] = {
							scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
							scope:New "UIPadding" {
								PaddingTop = UDim.new(0, 8),
								PaddingBottom = UDim.new(0, 8),
							},
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Vertical,
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								Padding = UDim.new(0, 4),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							scope:ForValues(filteredRows, function(_, innerScope: Scope, row: any)
								local roleRow = row :: RoleRow
								local isChecked = innerScope:Computed(function(use)
									return (use(pendingKeys) :: {[string]: boolean})[roleRow.key] == true
								end)
								if roleRow.key == ALL_ROLES_KEY then
									local item = CheckItem(innerScope, {
										header = innerScope:Value(roleRow.label),
										checked = isChecked,
										onCheck = function() end,
									})
									return innerScope:New "Frame" {
										Name = "AllRolesRow",
										LayoutOrder = roleRow.order,
										AutomaticSize = Enum.AutomaticSize.Y,
										BackgroundTransparency = 1,
										Size = UDim2.fromScale(1, 0),
										Interactable = false,
										[Children] = {
											item,
											innerScope:New "Frame" {
												Name = "LockOverlay",
												BackgroundColor3 = Theme.Color.Base,
												BackgroundTransparency = 0.35,
												Size = UDim2.fromScale(1, 1),
												ZIndex = 10,
											},
										},
									}
								end
								local checkItem = CheckItem(innerScope, {
									header = innerScope:Value(roleRow.label),
									body = if roleRow.body then innerScope:Value(roleRow.body) else nil,
									checked = isChecked,
									onCheck = function()
										toggleKey(roleRow.key)
									end,
								})
								;(checkItem :: any).LayoutOrder = roleRow.order
								return checkItem
							end),
						},
					},
				},
			},

			scope:New "Frame" {
				Name = "Divider",
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = Theme.Color.NeutralStroke,
			},

			scope:New "Frame" {
				Name = "BottomBar",
				LayoutOrder = 3,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 14),
					},
					Pressable(scope, {
						name = "ConfirmButton",
						automaticSize = Enum.AutomaticSize.Y,
						backgroundColor = confirmBgColor,
						size = UDim2.fromScale(1, 0),
						onActivate = onConfirm,
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							scope:New "UIPadding" {
								PaddingTop = UDim.new(0, 8),
								PaddingBottom = UDim.new(0, 8),
								PaddingLeft = UDim.new(0, 24),
								PaddingRight = UDim.new(0, 24),
							},
							scope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = Color3.new(1, 1, 1),
								[Children] = {
									scope:New "UIGradient" {
										Color = confirmStrokeGradient,
										Rotation = 90,
									},
								},
							},
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Center,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								Size = UDim2.fromOffset(0, 0),
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								RichText = true,
								Text = scope:Computed(function(use)
									local keys = use(pendingKeys) :: {[string]: boolean}
									if keys[ALL_ROLES_KEY] then return "Confirm" end
									local count = use(selectedCount)
									return string.format("Confirm (%d)", count)
								end),
								TextColor3 = Theme.Color.PrimaryContent,
								TextSize = Theme.TextSize.Subtitle,
							},
						},
					}),
				},
			},
		},
	}
end
