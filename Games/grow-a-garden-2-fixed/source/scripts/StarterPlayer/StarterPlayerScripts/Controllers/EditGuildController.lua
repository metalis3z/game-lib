--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Asserts = require(ReplicatedStorage.SharedModules.Guild.Asserts)
local IconPool = require(ReplicatedStorage.SharedModules.Guild.IconPool)
local MarketplaceServiceHelper = require(ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local ColorPickerGuildController = require(LocalPlayer.PlayerScripts.Controllers.ColorPickerGuildController)
local MAX_NAME_LENGTH = Asserts.MAX_NAME_LENGTH
local MIN_TAG_LENGTH = Asserts.MIN_TAG_LENGTH
local MAX_TAG_LENGTH = Asserts.MAX_TAG_LENGTH
local MAX_DESCRIPTION_LENGTH = Asserts.MAX_DESCRIPTION_LENGTH
local v1 = Color3.fromRGB(110, 231, 167)
local t = {
	[1] = true,
	[13] = true
}
local t2 = {
	StartOrder = 9
}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = ""
local v16 = ""
local v17 = ""
local v18 = v1
local v19 = v1
local DEFAULT_ICON_ID = IconPool.DEFAULT_ICON_ID
local v20 = 0
local v21 = false

local function utf8Len(p1) --[[ utf8Len | Line: 88 ]]
	return utf8.len(p1) or #p1
end

local function utf8Truncate(p1, p2) --[[ utf8Truncate | Line: 92 ]]
	local v1 = utf8.len(p1)

	if not v1 or v1 <= p2 then
		return p1
	end

	local v2 = utf8.offset(p1, p2 + 1)

	if v2 then
		return string.sub(p1, 1, v2 - 1)
	end

	return string.sub(p1, 1, p2)
end

local function trim(p1) --[[ trim | Line: 102 ]]
	return string.gsub(p1, "^%s*(.-)%s*$", "%1")
end

local function color3ToHex(p1) --[[ color3ToHex | Line: 106 ]]
	return string.format("#%02X%02X%02X", math.clamp(math.floor(p1.R * 255 + 0.5), 0, 255), math.clamp(math.floor(p1.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(p1.B * 255 + 0.5), 0, 255)))
end

local function hexToColor3(p1) --[[ hexToColor3 | Line: 115 | Upvalues: v1 (copy) ]]
	if typeof(p1) ~= "string" or p1 == "" then
		return v1
	end

	local v12 = if string.sub(p1, 1, 1) == "#" then string.sub(p1, 2) else p1

	if #v12 ~= 6 then
		return v1
	end

	local v3 = tonumber(string.sub(v12, 1, 2), 16)
	local v5 = tonumber(string.sub(v12, 3, 4), 16)
	local v7 = tonumber(string.sub(v12, 5, 6), 16)

	if v3 and (v5 and v7) then
		return Color3.fromRGB(v3, v5, v7)
	end

	return v1
end

local function color3Equal(p1, p2) --[[ color3Equal | Line: 126 ]]
	return if math.abs(p1.R - p2.R) < 0.001 then if math.abs(p1.G - p2.G) < 0.001 then math.abs(p1.B - p2.B) < 0.001 else false else false
end

local function formatCooldownDH(p1) --[[ formatCooldownDH | Line: 135 ]]
	local v2 = math.max(0, (math.floor(p1 + 0.5)))
	local v3 = v2 // 86400
	local v4 = (v2 - v3 * 86400) // 3600

	if v3 <= 0 and v4 <= 0 then
		v4 = 1
	end

	return string.format("%dd %dh", v3, v4)
end

local function isNameDirty() --[[ isNameDirty | Line: 146 | Upvalues: v14 (ref), v15 (ref) ]]
	if not v14 then
		return false
	end

	return if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= ""
end

local function isTagDirty() --[[ isTagDirty | Line: 151 | Upvalues: v14 (ref), v16 (ref) ]]
	if not v14 then
		return false
	end

	return if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= ""
end

local function isDescriptionDirty() --[[ isDescriptionDirty | Line: 156 | Upvalues: v14 (ref), v17 (ref) ]]
	if not v14 then
		return false
	end

	return if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= ""
end

local function isNameColorDirty() --[[ isNameColorDirty | Line: 163 | Upvalues: v14 (ref), v18 (ref) ]]
	if not v14 then
		return false
	end

	local v1 = v18
	local Color = v14.Color

	return not (if math.abs(v1.R - Color.R) < 0.001 then if math.abs(v1.G - Color.G) < 0.001 then math.abs(v1.B - Color.B) < 0.001 else false else false)
end

local function isTagColorDirty() --[[ isTagColorDirty | Line: 168 | Upvalues: v14 (ref), v19 (ref) ]]
	if not v14 then
		return false
	end

	local v1 = v19
	local TagColor = v14.TagColor

	return not (if math.abs(v1.R - TagColor.R) < 0.001 then if math.abs(v1.G - TagColor.G) < 0.001 then math.abs(v1.B - TagColor.B) < 0.001 else false else false)
end

local function isIconDirty() --[[ isIconDirty | Line: 173 | Upvalues: v14 (ref), DEFAULT_ICON_ID (ref) ]]
	if not v14 then
		return false
	end

	return DEFAULT_ICON_ID ~= v14.IconId
end

local function hasAnyChanges() --[[ hasAnyChanges | Line: 178 | Upvalues: v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	local v1 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v1 then
		v1 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v1 then
			v1 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v1 then
				if v14 then
					local v8 = v18
					local Color = v14.Color

					v1 = not (if math.abs(v8.R - Color.R) < 0.001 then if math.abs(v8.G - Color.G) < 0.001 then math.abs(v8.B - Color.B) < 0.001 else false else false)
				else
					v1 = false
				end

				if not v1 then
					if v14 then
						local v13 = v19
						local TagColor = v14.TagColor

						v1 = not (if math.abs(v13.R - TagColor.R) < 0.001 then if math.abs(v13.G - TagColor.G) < 0.001 then math.abs(v13.B - TagColor.B) < 0.001 else false else false)
					else
						v1 = false
					end

					if not v1 then
						if not v14 then
							return false
						end

						v1 = DEFAULT_ICON_ID ~= v14.IconId
					end
				end
			end
		end
	end

	return v1
end

local function updateConfirmFade() --[[ updateConfirmFade | Line: 184 | Upvalues: v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	if not v10 then
		return
	end

	local v2 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v2 then
		v2 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v2 then
			v2 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v2 then
				if v14 then
					local v9 = v18
					local Color = v14.Color

					v2 = not (if math.abs(v9.R - Color.R) < 0.001 then if math.abs(v9.G - Color.G) < 0.001 then math.abs(v9.B - Color.B) < 0.001 else false else false)
				else
					v2 = false
				end

				if not v2 then
					if v14 then
						local v142 = v19
						local TagColor = v14.TagColor

						v2 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
					else
						v2 = false
					end

					if not v2 then
						v2 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v2
end

local function loadSnapshotFromServer() --[[ loadSnapshotFromServer | Line: 193 | Upvalues: Networking (copy), Asserts (copy), hexToColor3 (copy) ]]
	local ok, result = pcall(function() --[[ Line: 194 | Upvalues: Networking (ref) ]]
		return Networking.Guild.GetMyGuild:Fire()
	end)

	if not ok or typeof(result) ~= "table" then
		return nil
	end

	local Guild = result.Guild

	if typeof(Guild) ~= "table" then
		return nil
	end

	local v1 = 0
	local LastNameChangedAt = Guild.LastNameChangedAt

	if typeof(LastNameChangedAt) == "number" and LastNameChangedAt > 0 then
		local v2 = os.time() - LastNameChangedAt

		if v2 < 604800 then
			v1 = 604800 - v2
		end
	end

	local IconId = Guild.IconId

	if typeof(IconId) ~= "number" or IconId <= 0 then
		IconId = Asserts.DEFAULT_ICON_ID
	end

	local t = {}

	t.Name = tostring(Guild.Name or "")
	t.Tag = tostring(Guild.Tag or "")
	t.Description = tostring(Guild.Description or "")
	t.Color = hexToColor3(Guild.Color)
	t.TagColor = hexToColor3(Guild.TagColor or Guild.Color)
	t.IconId = IconId
	t.Role = if typeof(result.Role) == "string" then result.Role else nil
	t.NameCooldownRemainingAtFetch = v1
	t.FetchedAtClock = os.clock()

	return t
end

local function reflectIconUI() --[[ reflectIconUI | Line: 236 | Upvalues: v11 (ref), Asserts (copy), DEFAULT_ICON_ID (ref), v13 (ref) ]]
	if v11 then
		v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
	end

	if not v13 then
		return
	end

	v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
end

local function applySnapshotToFields(p1) --[[ applySnapshotToFields | Line: 245 | Upvalues: v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (copy), v13 (ref), v10 (ref) ]]
	v14 = p1
	v15 = p1.Name
	v16 = p1.Tag
	v17 = p1.Description
	v18 = p1.Color
	v19 = p1.TagColor
	DEFAULT_ICON_ID = p1.IconId

	if v4 then
		v4.Text = p1.Name
		v4.TextColor3 = p1.Color
	end

	if v5 then
		v5.Text = p1.Tag
		v5.TextColor3 = p1.TagColor
	end

	if v6 then
		v6.Text = p1.Description
	end

	if v11 then
		v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
	end

	if v13 then
		v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
	end

	if not v10 then
		return
	end

	local v52 = if p1 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == p1.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v52 then
		v52 = if p1 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == p1.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v52 then
			v52 = if p1 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == p1.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v52 then
				if p1 then
					local v12 = v18
					local Color = p1.Color

					v52 = not (if math.abs(v12.R - Color.R) < 0.001 then if math.abs(v12.G - Color.G) < 0.001 then math.abs(v12.B - Color.B) < 0.001 else false else false)
				else
					v52 = false
				end

				if not v52 then
					if p1 then
						local v172 = v19
						local TagColor = p1.TagColor

						v52 = not (if math.abs(v172.R - TagColor.R) < 0.001 then if math.abs(v172.G - TagColor.G) < 0.001 then math.abs(v172.B - TagColor.B) < 0.001 else false else false)
					else
						v52 = false
					end

					if not v52 then
						v52 = if p1 then if DEFAULT_ICON_ID == p1.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v52
end

local function clampNameText() --[[ clampNameText | Line: 271 | Upvalues: v4 (ref), MAX_NAME_LENGTH (copy), v15 (ref), v10 (ref), v14 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	if not v4 then
		return
	end

	local v1 = string.gsub(v4.Text, "[^A-Za-z0-9 _\'%-]", "")
	local v2 = MAX_NAME_LENGTH
	local v3 = utf8.len(v1)
	local v42

	if v3 and not (v3 <= v2) then
		local v5 = utf8.offset(v1, v2 + 1)

		v42 = if v5 then string.sub(v1, 1, v5 - 1) else string.sub(v1, 1, v2)
	else
		v42 = v1
	end

	if v42 ~= v4.Text then
		v4.Text = v42
	end

	v15 = v4.Text

	if not v10 then
		return
	end

	local v9 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v9 then
		v9 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v9 then
			v9 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v9 then
				if v14 then
					local v162 = v18
					local Color = v14.Color

					v9 = not (if math.abs(v162.R - Color.R) < 0.001 then if math.abs(v162.G - Color.G) < 0.001 then math.abs(v162.B - Color.B) < 0.001 else false else false)
				else
					v9 = false
				end

				if not v9 then
					if v14 then
						local v21 = v19
						local TagColor = v14.TagColor

						v9 = not (if math.abs(v21.R - TagColor.R) < 0.001 then if math.abs(v21.G - TagColor.G) < 0.001 then math.abs(v21.B - TagColor.B) < 0.001 else false else false)
					else
						v9 = false
					end

					if not v9 then
						v9 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v9
end

local function clampTagText() --[[ clampTagText | Line: 284 | Upvalues: v5 (ref), MAX_TAG_LENGTH (copy), v16 (ref), v10 (ref), v14 (ref), v15 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	if not v5 then
		return
	end

	local v2 = string.gsub(string.upper(v5.Text), "[^A-Z0-9]", "")
	local v3 = MAX_TAG_LENGTH
	local v4 = utf8.len(v2)
	local v52

	if v4 and not (v4 <= v3) then
		local v6 = utf8.offset(v2, v3 + 1)

		v52 = if v6 then string.sub(v2, 1, v6 - 1) else string.sub(v2, 1, v3)
	else
		v52 = v2
	end

	if v52 ~= v5.Text then
		v5.Text = v52
	end

	v16 = v5.Text

	if not v10 then
		return
	end

	local v102 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v102 then
		v102 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v102 then
			v102 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v102 then
				if v14 then
					local v172 = v18
					local Color = v14.Color

					v102 = not (if math.abs(v172.R - Color.R) < 0.001 then if math.abs(v172.G - Color.G) < 0.001 then math.abs(v172.B - Color.B) < 0.001 else false else false)
				else
					v102 = false
				end

				if not v102 then
					if v14 then
						local v22 = v19
						local TagColor = v14.TagColor

						v102 = not (if math.abs(v22.R - TagColor.R) < 0.001 then if math.abs(v22.G - TagColor.G) < 0.001 then math.abs(v22.B - TagColor.B) < 0.001 else false else false)
					else
						v102 = false
					end

					if not v102 then
						v102 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v102
end

local function clampDescriptionText() --[[ clampDescriptionText | Line: 299 | Upvalues: v6 (ref), MAX_DESCRIPTION_LENGTH (copy), v17 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	if not v6 then
		return
	end

	local v1 = string.gsub(v6.Text, "[^ -~]", "")
	local v2 = MAX_DESCRIPTION_LENGTH
	local v3 = utf8.len(v1)
	local v4

	if v3 and not (v3 <= v2) then
		local v5 = utf8.offset(v1, v2 + 1)

		v4 = if v5 then string.sub(v1, 1, v5 - 1) else string.sub(v1, 1, v2)
	else
		v4 = v1
	end

	if v4 ~= v6.Text then
		v6.Text = v4
	end

	v17 = v6.Text

	if not v10 then
		return
	end

	local v9 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v9 then
		v9 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v9 then
			v9 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v9 then
				if v14 then
					local v162 = v18
					local Color = v14.Color

					v9 = not (if math.abs(v162.R - Color.R) < 0.001 then if math.abs(v162.G - Color.G) < 0.001 then math.abs(v162.B - Color.B) < 0.001 else false else false)
				else
					v9 = false
				end

				if not v9 then
					if v14 then
						local v21 = v19
						local TagColor = v14.TagColor

						v9 = not (if math.abs(v21.R - TagColor.R) < 0.001 then if math.abs(v21.G - TagColor.G) < 0.001 then math.abs(v21.B - TagColor.B) < 0.001 else false else false)
					else
						v9 = false
					end

					if not v9 then
						v9 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v9
end

local function applyNameColor(p1) --[[ applyNameColor | Line: 313 | Upvalues: v18 (ref), v4 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v19 (ref), DEFAULT_ICON_ID (ref) ]]
	v18 = p1

	if v4 then
		v4.TextColor3 = p1
	end

	if not v10 then
		return
	end

	local v2 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v2 then
		v2 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v2 then
			v2 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v2 then
				if v14 then
					local v9 = p1
					local Color = v14.Color

					v2 = not (if math.abs(v9.R - Color.R) < 0.001 then if math.abs(v9.G - Color.G) < 0.001 then math.abs(v9.B - Color.B) < 0.001 else false else false)
				else
					v2 = false
				end

				if not v2 then
					if v14 then
						local v142 = v19
						local TagColor = v14.TagColor

						v2 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
					else
						v2 = false
					end

					if not v2 then
						v2 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v2
end

local function applyTagColor(p1) --[[ applyTagColor | Line: 319 | Upvalues: v19 (ref), v5 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), DEFAULT_ICON_ID (ref) ]]
	v19 = p1

	if v5 then
		v5.TextColor3 = p1
	end

	if not v10 then
		return
	end

	local v2 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v2 then
		v2 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v2 then
			v2 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v2 then
				if v14 then
					local v9 = v18
					local Color = v14.Color

					v2 = not (if math.abs(v9.R - Color.R) < 0.001 then if math.abs(v9.G - Color.G) < 0.001 then math.abs(v9.B - Color.B) < 0.001 else false else false)
				else
					v2 = false
				end

				if not v2 then
					if v14 then
						local v142 = p1
						local TagColor = v14.TagColor

						v2 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
					else
						v2 = false
					end

					if not v2 then
						v2 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v2
end

local function rollDiceIcon() --[[ rollDiceIcon | Line: 329 | Upvalues: IconPool (copy), DEFAULT_ICON_ID (ref), v20 (ref), v11 (ref), Asserts (copy), v13 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref) ]]
	local v1 = IconPool.GetPool()

	if #v1 == 0 then
		return
	end

	local v2 = math.random(#v1)

	if #v1 > 1 and v1[v2] == DEFAULT_ICON_ID then
		v2 = v2 % #v1 + 1
	end

	v20 = v20 + 1
	DEFAULT_ICON_ID = v1[v2]

	if v11 then
		v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
	end

	if v13 then
		v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
	end

	if not v10 then
		return
	end

	local v7 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v7 then
		v7 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v7 then
			v7 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v7 then
				if v14 then
					local v142 = v18
					local Color = v14.Color

					v7 = not (if math.abs(v142.R - Color.R) < 0.001 then if math.abs(v142.G - Color.G) < 0.001 then math.abs(v142.B - Color.B) < 0.001 else false else false)
				else
					v7 = false
				end

				if not v7 then
					if v14 then
						local v192 = v19
						local TagColor = v14.TagColor

						v7 = not (if math.abs(v192.R - TagColor.R) < 0.001 then if math.abs(v192.G - TagColor.G) < 0.001 then math.abs(v192.B - TagColor.B) < 0.001 else false else false)
					else
						v7 = false
					end

					if not v7 then
						v7 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
					end
				end
			end
		end
	end

	v10.Visible = not v7
end

local function validateCustomImage(p1) --[[ validateCustomImage | Line: 348 | Upvalues: v11 (ref), Asserts (copy), DEFAULT_ICON_ID (ref), v13 (ref), NotificationController (copy), v20 (ref), MarketplaceServiceHelper (copy), GuiController (copy), t (copy), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref) ]]
	if string.match(p1, "^%s*$") then
		if v11 then
			v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
		end

		if not v13 then
			return
		end

		v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
	else
		local v4 = tonumber(string.match(p1, "rbxassetid://(%d+)"))

		if not v4 then
			v4 = tonumber(string.match(p1, "^%s*(%d+)%s*$"))
		end

		if v4 then
			if v4 ~= DEFAULT_ICON_ID then
				v20 = v20 + 1

				local v5 = v20

				task.spawn(function() --[[ Line: 371 | Upvalues: MarketplaceServiceHelper (ref), v4 (copy), v5 (copy), v20 (ref), GuiController (ref), t (ref), v11 (ref), Asserts (ref), DEFAULT_ICON_ID (ref), v13 (ref), NotificationController (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref) ]]
					local ok, result = pcall(MarketplaceServiceHelper.GetInfoAsync, v4, Enum.InfoType.Asset)

					if v5 ~= v20 then
						return
					end

					if not GuiController:IsOpen("EditGuild") then
						return
					end

					if if ok then if typeof(result) == "table" then t[result.AssetTypeId] == true else false else ok then
						DEFAULT_ICON_ID = v4

						if v11 then
							v11.Image = Asserts.IconAssetString(v4)
						end

						if v13 then
							v13.Text = if Asserts.IsPoolIcon(v4) then "" else tostring(v4)
						end

						if not v10 then
							return
						end

						local v6 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

						if not v6 then
							v6 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

							if not v6 then
								v6 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

								if not v6 then
									if v14 then
										local v132 = v18
										local Color = v14.Color

										v6 = not (if math.abs(v132.R - Color.R) < 0.001 then if math.abs(v132.G - Color.G) < 0.001 then math.abs(v132.B - Color.B) < 0.001 else false else false)
									else
										v6 = false
									end

									if not v6 then
										if v14 then
											local v182 = v19
											local TagColor = v14.TagColor

											v6 = not (if math.abs(v182.R - TagColor.R) < 0.001 then if math.abs(v182.G - TagColor.G) < 0.001 then math.abs(v182.B - TagColor.B) < 0.001 else false else false)
										else
											v6 = false
										end

										if not v6 then
											v6 = if v14 then if v4 == v14.IconId then false else true else false
										end
									end
								end
							end
						end

						v10.Visible = not v6
					else
						if v11 then
							v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
						end

						if v13 then
							v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
						end

						NotificationController:CreateNotification("That\'s not a valid roblox image id!")
					end
				end)

				return
			end

			if v11 then
				v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
			end

			if not v13 then
				return
			end

			local v6 = v13

			v6.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
		else
			if v11 then
				v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
			end

			if not v13 then
				NotificationController:CreateNotification("That\'s not a valid roblox image id!")

				return
			end

			v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
			NotificationController:CreateNotification("That\'s not a valid roblox image id!")
		end
	end
end

local function notifyEditError(p1) --[[ notifyEditError | Line: 394 | Upvalues: NotificationController (copy) ]]
	if typeof(p1) == "string" and string.sub(p1, 1, 14) == "name_cooldown:" then
		local v6 = math.max(0, (math.floor((tonumber((string.sub(p1, 15))) or 0) + 0.5)))
		local v7 = v6 // 86400
		local v8 = (v6 - v7 * 86400) // 3600

		if v7 <= 0 and v8 <= 0 then
			v8 = 1
		end

		NotificationController:CreateNotification((("You can change your name in %*"):format((string.format("%dd %dh", v7, v8)))))
	else
		if p1 == "name_cooldown" then
			NotificationController:CreateNotification("You can change your name in 7d 0h")

			return
		end

		if p1 == "no_changes" then
			NotificationController:CreateNotification("Nothing to save")

			return
		end

		if p1 == "not_leader" then
			NotificationController:CreateNotification("Only the guild leader can edit")

			return
		end

		if p1 == "guild_not_found" then
			NotificationController:CreateNotification("Couldn\'t find your guild")

			return
		end

		if p1 == "invalid_name" then
			NotificationController:CreateNotification("That guild name isn\'t allowed")

			return
		end

		if p1 == "name_too_long" then
			NotificationController:CreateNotification("Guild name is too long")

			return
		end

		if p1 == "name_taken" then
			NotificationController:CreateNotification("That guild name is taken")

			return
		end

		if p1 == "name_filtered" then
			NotificationController:CreateNotification("Guild name not allowed, try another!")

			return
		end

		if p1 == "invalid_tag" then
			NotificationController:CreateNotification("Guild tag must be 2-5 letters/digits")

			return
		end

		if p1 == "tag_taken" then
			NotificationController:CreateNotification("That guild tag is taken")

			return
		end

		if p1 == "tag_filtered" then
			NotificationController:CreateNotification("Guild tag not allowed, try another!")

			return
		end

		if p1 == "invalid_color" then
			NotificationController:CreateNotification("That name color isn\'t valid")

			return
		end

		if p1 == "invalid_tag_color" then
			NotificationController:CreateNotification("That tag color isn\'t valid")

			return
		end

		if p1 == "invalid_icon" then
			NotificationController:CreateNotification("That\'s not a valid roblox image id!")

			return
		end

		if p1 == "invalid_description" then
			NotificationController:CreateNotification("That description isn\'t allowed")

			return
		end

		if p1 == "description_too_long" then
			NotificationController:CreateNotification("Guild description is too long")

			return
		end

		if p1 == "description_filtered" then
			NotificationController:CreateNotification("Description not allowed, try another!")

			return
		end

		if p1 == "filter_unavailable" then
			NotificationController:CreateNotification("Couldn\'t verify that text right now - try again in a moment!")

			return
		end

		if p1 then
			NotificationController:CreateNotification((("Failed to save guild (%*)"):format(p1)))
		else
			NotificationController:CreateNotification("Failed to save guild")
		end
	end
end

local function checkLocalCooldown() --[[ checkLocalCooldown | Line: 454 | Upvalues: v14 (ref), v15 (ref), NotificationController (copy) ]]
	if not v14 then
		return true
	end

	if not (if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false) then
		return true
	end

	local v5 = v14.NameCooldownRemainingAtFetch - (os.clock() - v14.FetchedAtClock)

	if not (v5 > 0) then
		return true
	end

	local v9 = math.max(0, (math.floor(v5 + 0.5)))
	local v10 = v9 // 86400
	local v11 = (v9 - v10 * 86400) // 3600

	if v10 <= 0 and v11 <= 0 then
		v11 = 1
	end

	NotificationController:CreateNotification((("You can change your name in %*"):format((string.format("%dd %dh", v10, v11)))))

	return false
end

local function fireSave() --[[ fireSave | Line: 470 | Upvalues: v21 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), NotificationController (copy), checkLocalCooldown (copy), Networking (copy), notifyEditError (copy), loadSnapshotFromServer (copy), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (copy), v13 (ref), v10 (ref), GuiController (copy) ]]
	if v21 then
		return
	end

	if not v14 then
		return
	end

	local v1 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v1 then
		v1 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v1 then
			v1 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v1 then
				if v14 then
					local v8 = v18
					local Color = v14.Color

					v1 = not (if math.abs(v8.R - Color.R) < 0.001 then if math.abs(v8.G - Color.G) < 0.001 then math.abs(v8.B - Color.B) < 0.001 else false else false)
				else
					v1 = false
				end

				if not v1 then
					if v14 then
						local v132 = v19
						local TagColor = v14.TagColor

						v1 = not (if math.abs(v132.R - TagColor.R) < 0.001 then if math.abs(v132.G - TagColor.G) < 0.001 then math.abs(v132.B - TagColor.B) < 0.001 else false else false)
					else
						v1 = false
					end

					if not v1 then
						v1 = if v14 then DEFAULT_ICON_ID ~= v14.IconId else false
					end
				end
			end
		end
	end

	if not v1 then
		NotificationController:CreateNotification("Nothing to save")

		return
	end

	if not checkLocalCooldown() then
		return
	end

	local v182 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false
	local v212 = if v182 then string.gsub(v15, "^%s*(.-)%s*$", "%1") else ""
	local v23 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false elseif string.gsub(v16, "^%s*(.-)%s*$", "%1") == "" then false else true else false
	local v26 = if v23 then string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) else ""
	local v28

	if v14 then
		local v29 = v18
		local Color = v14.Color

		v28 = not (if math.abs(v29.R - Color.R) < 0.001 then if math.abs(v29.G - Color.G) < 0.001 then math.abs(v29.B - Color.B) < 0.001 else false else false)
	else
		v28 = false
	end

	local v34

	if v28 then
		local v35 = v18

		v34 = string.format("#%02X%02X%02X", math.clamp(math.floor(v35.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v35.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v35.B * 255 + 0.5), 0, 255)))
	else
		v34 = ""
	end

	local v44

	if v14 then
		local v45 = v19
		local TagColor = v14.TagColor

		v44 = not (if math.abs(v45.R - TagColor.R) < 0.001 then if math.abs(v45.G - TagColor.G) < 0.001 then math.abs(v45.B - TagColor.B) < 0.001 else false else false)
	else
		v44 = false
	end

	local v50

	if v44 then
		local v51 = v19

		v50 = string.format("#%02X%02X%02X", math.clamp(math.floor(v51.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v51.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v51.B * 255 + 0.5), 0, 255)))
	else
		v50 = ""
	end

	local v60 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
	local v61 = if v60 then DEFAULT_ICON_ID else 0
	local v62 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false elseif string.gsub(v17, "^%s*(.-)%s*$", "%1") == "" then false else true else false
	local v65 = if v62 then string.gsub(v17, "^%s*(.-)%s*$", "%1") else ""

	v21 = true
	task.spawn(function() --[[ Line: 490 | Upvalues: Networking (ref), v212 (copy), v26 (copy), v34 (copy), v50 (copy), v61 (copy), v65 (copy), v21 (ref), NotificationController (ref), notifyEditError (ref), loadSnapshotFromServer (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (ref), v13 (ref), v10 (ref), GuiController (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 491 | Upvalues: Networking (ref), v212 (ref), v26 (ref), v34 (ref), v50 (ref), v61 (ref), v65 (ref) ]]
			return Networking.Guild.EditGuild:Fire(v212, v26, v34, v50, v61, v65)
		end)

		v21 = false

		if not ok then
			NotificationController:CreateNotification("Failed to save guild")

			return
		end

		if result then
			NotificationController:CreateNotification("Saved guild changes")

			local v1 = loadSnapshotFromServer()

			if v1 then
				v14 = v1
				v15 = v1.Name
				v16 = v1.Tag
				v17 = v1.Description
				v18 = v1.Color
				v19 = v1.TagColor
				DEFAULT_ICON_ID = v1.IconId

				if v4 then
					v4.Text = v1.Name
					v4.TextColor3 = v1.Color
				end

				if v5 then
					v5.Text = v1.Tag
					v5.TextColor3 = v1.TagColor
				end

				if v6 then
					v6.Text = v1.Description
				end

				if v11 then
					v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
				end

				if v13 then
					v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
				end

				if v10 then
					local v62 = if v1 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v1.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v62 then
						v62 = if v1 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v1.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

						if not v62 then
							v62 = if v1 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v1.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

							if not v62 then
								if v1 then
									local v132 = v18
									local Color = v1.Color

									v62 = not (if math.abs(v132.R - Color.R) < 0.001 then if math.abs(v132.G - Color.G) < 0.001 then math.abs(v132.B - Color.B) < 0.001 else false else false)
								else
									v62 = false
								end

								if not v62 then
									if v1 then
										local v182 = v19
										local TagColor = v1.TagColor

										v62 = not (if math.abs(v182.R - TagColor.R) < 0.001 then if math.abs(v182.G - TagColor.G) < 0.001 then math.abs(v182.B - TagColor.B) < 0.001 else false else false)
									else
										v62 = false
									end

									if not v62 then
										v62 = if v1 then if DEFAULT_ICON_ID == v1.IconId then false else true else false
									end
								end
							end
						end
					end

					v10.Visible = not v62
				end
			end

			if not GuiController:IsOpen("EditGuild") then
				return
			end

			GuiController:Open("ViewGuildPage", nil, { "HUD" })

			if not GuiController:IsOpen("EditGuild") then
				return
			end

			GuiController:Close()
		else
			notifyEditError(if typeof(result2) == "string" and result2 then result2 else nil)
		end
	end)
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 531 | Upvalues: v3 (ref), v4 (ref), v7 (ref), v5 (ref), v8 (ref), v6 (ref), v9 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref) ]]
	local function deep(p12) --[[ deep | Line: 532 | Upvalues: p1 (copy) ]]
		return p1:FindFirstChild(p12, true)
	end

	local function resolveField(p12) --[[ resolveField | Line: 539 | Upvalues: p1 (copy) ]]
		local v1 = p1:FindFirstChild(p12, true)

		if not v1 then
			return nil, nil
		end

		local v2 = nil
		local UsernameGuild = v1:FindFirstChild("UsernameGuild")

		if UsernameGuild then
			local TextBox = UsernameGuild:FindFirstChild("TextBox")

			if TextBox and TextBox:IsA("TextBox") then
				v2 = TextBox
			end
		end

		local v3 = nil
		local ColorPickerGuildNameButton = v1:FindFirstChild("ColorPickerGuildNameButton")

		if ColorPickerGuildNameButton and ColorPickerGuildNameButton:IsA("GuiButton") then
			v3 = ColorPickerGuildNameButton
		end

		return v2, v3
	end

	local v1 = p1:FindFirstChild("CloseButton", true) or p1:FindFirstChild("ExitButton", true)

	if v1 and v1:IsA("GuiButton") then
		v3 = v1
	end

	local v2, v32 = resolveField("GuildName")

	v4 = v2
	v7 = v32

	local v42, v52 = resolveField("GuildTag")

	v5 = v42
	v8 = v52
	v6 = resolveField("GuildDescription")

	local ConfirmButton = p1:FindFirstChild("ConfirmButton", true)

	if ConfirmButton and ConfirmButton:IsA("GuiButton") then
		v9 = ConfirmButton

		local Fade = ConfirmButton:FindFirstChild("Fade")

		if Fade and Fade:IsA("GuiObject") then
			v10 = Fade
		end
	end

	local GuildImagePreview = p1:FindFirstChild("GuildImagePreview", true)

	if not GuildImagePreview then
		return
	end

	local GuildImage = GuildImagePreview:FindFirstChild("GuildImage", true)

	if GuildImage and GuildImage:IsA("ImageLabel") then
		v11 = GuildImage
	end

	local DiceButton = GuildImagePreview:FindFirstChild("DiceButton", true)

	if DiceButton and DiceButton:IsA("GuiButton") then
		v12 = DiceButton
	elseif DiceButton then
		local v62 = DiceButton:FindFirstChildOfClass("ImageButton") or DiceButton:FindFirstChildOfClass("TextButton")

		if v62 then
			v12 = v62
		end
	end

	local TextBox = GuildImagePreview:FindFirstChild("TextBox", true)

	if not (TextBox and TextBox:IsA("TextBox")) then
		return
	end

	v13 = TextBox
end

local function BindCloseButton() --[[ BindCloseButton | Line: 594 | Upvalues: v3 (ref), GuiController (copy) ]]
	if v3 then
		v3.MouseButton1Click:Connect(function() --[[ Line: 596 | Upvalues: GuiController (ref) ]]
			if not GuiController:IsOpen("EditGuild") then
				return
			end

			GuiController:Open("ViewGuildPage", nil, { "HUD" })

			if not GuiController:IsOpen("EditGuild") then
				return
			end

			GuiController:Close()
		end)
	end
end

local function BindTextBoxes() --[[ BindTextBoxes | Line: 609 | Upvalues: v4 (ref), clampNameText (copy), v5 (ref), clampTagText (copy), v6 (ref), clampDescriptionText (copy) ]]
	if v4 then
		v4.ClearTextOnFocus = false
		v4:GetPropertyChangedSignal("Text"):Connect(clampNameText)
	end

	if v5 then
		v5.ClearTextOnFocus = false
		v5:GetPropertyChangedSignal("Text"):Connect(clampTagText)
	end

	if not v6 then
		return
	end

	v6.ClearTextOnFocus = false
	v6:GetPropertyChangedSignal("Text"):Connect(clampDescriptionText)
end

local function BindColorPickers() --[[ BindColorPickers | Line: 624 | Upvalues: v7 (ref), ColorPickerGuildController (copy), v18 (ref), v4 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v19 (ref), DEFAULT_ICON_ID (ref), GuiController (copy), v8 (ref), v5 (ref) ]]
	if v7 then
		v7.MouseButton1Click:Connect(function() --[[ Line: 626 | Upvalues: ColorPickerGuildController (ref), v18 (ref), v4 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v19 (ref), DEFAULT_ICON_ID (ref), GuiController (ref) ]]
			ColorPickerGuildController:RequestColor(v18, function(p1) --[[ Line: 627 | Upvalues: v18 (ref), v4 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v19 (ref), DEFAULT_ICON_ID (ref), GuiController (ref) ]]
				if p1 then
					v18 = p1

					if v4 then
						v4.TextColor3 = p1
					end

					if v10 then
						local v2 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

						if not v2 then
							v2 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

							if not v2 then
								v2 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

								if not v2 then
									if v14 then
										local v9 = p1
										local Color = v14.Color

										v2 = not (if math.abs(v9.R - Color.R) < 0.001 then if math.abs(v9.G - Color.G) < 0.001 then math.abs(v9.B - Color.B) < 0.001 else false else false)
									else
										v2 = false
									end

									if not v2 then
										if v14 then
											local v142 = v19
											local TagColor = v14.TagColor

											v2 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
										else
											v2 = false
										end

										if not v2 then
											v2 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
										end
									end
								end
							end
						end

						v10.Visible = not v2
					end
				end

				if GuiController:IsOpen("EditGuild") then
					return
				end

				GuiController:Open("EditGuild", nil, { "HUD" })
			end)
		end)
	end

	if not v8 then
		return
	end

	v8.MouseButton1Click:Connect(function() --[[ Line: 637 | Upvalues: ColorPickerGuildController (ref), v19 (ref), v5 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), DEFAULT_ICON_ID (ref), GuiController (ref) ]]
		ColorPickerGuildController:RequestColor(v19, function(p1) --[[ Line: 638 | Upvalues: v19 (ref), v5 (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), DEFAULT_ICON_ID (ref), GuiController (ref) ]]
			if p1 then
				v19 = p1

				if v5 then
					v5.TextColor3 = p1
				end

				if v10 then
					local v2 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v2 then
						v2 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

						if not v2 then
							v2 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

							if not v2 then
								if v14 then
									local v9 = v18
									local Color = v14.Color

									v2 = not (if math.abs(v9.R - Color.R) < 0.001 then if math.abs(v9.G - Color.G) < 0.001 then math.abs(v9.B - Color.B) < 0.001 else false else false)
								else
									v2 = false
								end

								if not v2 then
									if v14 then
										local v142 = p1
										local TagColor = v14.TagColor

										v2 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
									else
										v2 = false
									end

									if not v2 then
										v2 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
									end
								end
							end
						end
					end

					v10.Visible = not v2
				end
			end

			if GuiController:IsOpen("EditGuild") then
				return
			end

			GuiController:Open("EditGuild", nil, { "HUD" })
		end)
	end)
end

local function BindConfirmButton() --[[ BindConfirmButton | Line: 648 | Upvalues: v9 (ref), fireSave (copy) ]]
	if v9 then
		v9.MouseButton1Click:Connect(fireSave)
	end
end

local function BindImagePicker() --[[ BindImagePicker | Line: 653 | Upvalues: v12 (ref), rollDiceIcon (copy), v13 (ref), validateCustomImage (copy) ]]
	if v12 then
		v12.MouseButton1Click:Connect(rollDiceIcon)
	end

	if not v13 then
		return
	end

	v13.ClearTextOnFocus = false
	v13.FocusLost:Connect(function() --[[ Line: 659 | Upvalues: v13 (ref), validateCustomImage (ref) ]]
		if v13 then
			validateCustomImage(v13.Text)
		end
	end)
end

local function OnFocus() --[[ OnFocus | Line: 666 | Upvalues: v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), loadSnapshotFromServer (copy), NotificationController (copy), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (copy), v13 (ref), v10 (ref) ]]
	local v1 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

	if not v1 then
		v1 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

		if not v1 then
			v1 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v1 then
				if v14 then
					local v8 = v18
					local Color = v14.Color

					v1 = not (if math.abs(v8.R - Color.R) < 0.001 then if math.abs(v8.G - Color.G) < 0.001 then math.abs(v8.B - Color.B) < 0.001 else false else false)
				else
					v1 = false
				end

				if not v1 then
					if v14 then
						local v132 = v19
						local TagColor = v14.TagColor

						v1 = not (if math.abs(v132.R - TagColor.R) < 0.001 then if math.abs(v132.G - TagColor.G) < 0.001 then math.abs(v132.B - TagColor.B) < 0.001 else false else false)
					else
						v1 = false
					end

					if not v1 then
						v1 = if v14 then DEFAULT_ICON_ID ~= v14.IconId else false
					end
				end
			end
		end
	end

	if not v1 then
		task.spawn(function() --[[ Line: 677 | Upvalues: loadSnapshotFromServer (ref), NotificationController (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (ref), v13 (ref), v10 (ref) ]]
			local v1 = loadSnapshotFromServer()

			if not v1 then
				NotificationController:CreateNotification("Couldn\'t load your guild")

				return
			end

			v14 = v1
			v15 = v1.Name
			v16 = v1.Tag
			v17 = v1.Description
			v18 = v1.Color
			v19 = v1.TagColor
			DEFAULT_ICON_ID = v1.IconId

			if v4 then
				v4.Text = v1.Name
				v4.TextColor3 = v1.Color
			end

			if v5 then
				v5.Text = v1.Tag
				v5.TextColor3 = v1.TagColor
			end

			if v6 then
				v6.Text = v1.Description
			end

			if v11 then
				v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
			end

			if v13 then
				v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
			end

			if not v10 then
				return
			end

			local v62 = if v1 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v1.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v62 then
				v62 = if v1 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v1.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

				if not v62 then
					v62 = if v1 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v1.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v62 then
						if v1 then
							local v132 = v18
							local Color = v1.Color

							v62 = not (if math.abs(v132.R - Color.R) < 0.001 then if math.abs(v132.G - Color.G) < 0.001 then math.abs(v132.B - Color.B) < 0.001 else false else false)
						else
							v62 = false
						end

						if not v62 then
							if v1 then
								local v182 = v19
								local TagColor = v1.TagColor

								v62 = not (if math.abs(v182.R - TagColor.R) < 0.001 then if math.abs(v182.G - TagColor.G) < 0.001 then math.abs(v182.B - TagColor.B) < 0.001 else false else false)
							else
								v62 = false
							end

							if not v62 then
								v62 = if v1 then if DEFAULT_ICON_ID == v1.IconId then false else true else false
							end
						end
					end
				end
			end

			v10.Visible = not v62
		end)
	end
end

function t2.Init(p1) --[[ Init | Line: 688 ]] end
function t2.Start(p1) --[[ Start | Line: 690 | Upvalues: PlayerGui (copy), v2 (ref), ResolveRefs (copy), v3 (ref), GuiController (copy), BindTextBoxes (copy), BindColorPickers (copy), v9 (ref), fireSave (copy), v12 (ref), rollDiceIcon (copy), v13 (ref), validateCustomImage (copy), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), loadSnapshotFromServer (copy), NotificationController (copy), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (copy) ]]
	task.spawn(function() --[[ Line: 691 | Upvalues: PlayerGui (ref), v2 (ref), ResolveRefs (ref), v3 (ref), GuiController (ref), BindTextBoxes (ref), BindColorPickers (ref), v9 (ref), fireSave (ref), v12 (ref), rollDiceIcon (ref), v13 (ref), validateCustomImage (ref), v10 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), loadSnapshotFromServer (ref), NotificationController (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (ref) ]]
		local EditGuild = PlayerGui:WaitForChild("EditGuild", 30)

		if not (EditGuild and EditGuild:IsA("ScreenGui")) then
			return
		end

		v2 = EditGuild
		EditGuild.Enabled = false
		ResolveRefs(EditGuild)

		if v3 then
			v3.MouseButton1Click:Connect(function() --[[ Line: 596 | Upvalues: GuiController (ref) ]]
				if not GuiController:IsOpen("EditGuild") then
					return
				end

				GuiController:Open("ViewGuildPage", nil, { "HUD" })

				if not GuiController:IsOpen("EditGuild") then
					return
				end

				GuiController:Close()
			end)
		end

		BindTextBoxes()
		BindColorPickers()

		if v9 then
			v9.MouseButton1Click:Connect(fireSave)
		end

		if v12 then
			v12.MouseButton1Click:Connect(rollDiceIcon)
		end

		if v13 then
			v13.ClearTextOnFocus = false
			v13.FocusLost:Connect(function() --[[ Line: 659 | Upvalues: v13 (ref), validateCustomImage (ref) ]]
				if v13 then
					validateCustomImage(v13.Text)
				end
			end)
		end

		if v10 then
			local v22 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v22 then
				v22 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

				if not v22 then
					v22 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v22 then
						if v14 then
							local v92 = v18
							local Color = v14.Color

							v22 = not (if math.abs(v92.R - Color.R) < 0.001 then if math.abs(v92.G - Color.G) < 0.001 then math.abs(v92.B - Color.B) < 0.001 else false else false)
						else
							v22 = false
						end

						if not v22 then
							if v14 then
								local v142 = v19
								local TagColor = v14.TagColor

								v22 = not (if math.abs(v142.R - TagColor.R) < 0.001 then if math.abs(v142.G - TagColor.G) < 0.001 then math.abs(v142.B - TagColor.B) < 0.001 else false else false)
							else
								v22 = false
							end

							if not v22 then
								v22 = if v14 then if DEFAULT_ICON_ID == v14.IconId then false else true else false
							end
						end
					end
				end
			end

			v10.Visible = not v22
		end

		GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 706 | Upvalues: EditGuild (copy), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), loadSnapshotFromServer (ref), NotificationController (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (ref), v13 (ref), v10 (ref) ]]
			if p1 ~= EditGuild then
				return
			end

			local v1 = if v14 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v14.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

			if not v1 then
				v1 = if v14 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v14.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

				if not v1 then
					v1 = if v14 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v14.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v1 then
						if v14 then
							local v8 = v18
							local Color = v14.Color

							v1 = not (if math.abs(v8.R - Color.R) < 0.001 then if math.abs(v8.G - Color.G) < 0.001 then math.abs(v8.B - Color.B) < 0.001 else false else false)
						else
							v1 = false
						end

						if not v1 then
							if v14 then
								local v132 = v19
								local TagColor = v14.TagColor

								v1 = not (if math.abs(v132.R - TagColor.R) < 0.001 then if math.abs(v132.G - TagColor.G) < 0.001 then math.abs(v132.B - TagColor.B) < 0.001 else false else false)
							else
								v1 = false
							end

							if not v1 then
								v1 = if v14 then DEFAULT_ICON_ID ~= v14.IconId else false
							end
						end
					end
				end
			end

			if v1 then
				return
			end

			task.spawn(function() --[[ Line: 677 | Upvalues: loadSnapshotFromServer (ref), NotificationController (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), DEFAULT_ICON_ID (ref), v4 (ref), v5 (ref), v6 (ref), v11 (ref), Asserts (ref), v13 (ref), v10 (ref) ]]
				local v1 = loadSnapshotFromServer()

				if not v1 then
					NotificationController:CreateNotification("Couldn\'t load your guild")

					return
				end

				v14 = v1
				v15 = v1.Name
				v16 = v1.Tag
				v17 = v1.Description
				v18 = v1.Color
				v19 = v1.TagColor
				DEFAULT_ICON_ID = v1.IconId

				if v4 then
					v4.Text = v1.Name
					v4.TextColor3 = v1.Color
				end

				if v5 then
					v5.Text = v1.Tag
					v5.TextColor3 = v1.TagColor
				end

				if v6 then
					v6.Text = v1.Description
				end

				if v11 then
					v11.Image = Asserts.IconAssetString(DEFAULT_ICON_ID)
				end

				if v13 then
					v13.Text = if Asserts.IsPoolIcon(DEFAULT_ICON_ID) then "" else tostring(DEFAULT_ICON_ID)
				end

				if not v10 then
					return
				end

				local v62 = if v1 then if string.gsub(v15, "^%s*(.-)%s*$", "%1") == v1.Name then false else string.gsub(v15, "^%s*(.-)%s*$", "%1") ~= "" else false

				if not v62 then
					v62 = if v1 then if string.upper((string.gsub(v16, "^%s*(.-)%s*$", "%1"))) == v1.Tag then false else string.gsub(v16, "^%s*(.-)%s*$", "%1") ~= "" else false

					if not v62 then
						v62 = if v1 then if string.gsub(v17, "^%s*(.-)%s*$", "%1") == v1.Description then false else string.gsub(v17, "^%s*(.-)%s*$", "%1") ~= "" else false

						if not v62 then
							if v1 then
								local v132 = v18
								local Color = v1.Color

								v62 = not (if math.abs(v132.R - Color.R) < 0.001 then if math.abs(v132.G - Color.G) < 0.001 then math.abs(v132.B - Color.B) < 0.001 else false else false)
							else
								v62 = false
							end

							if not v62 then
								if v1 then
									local v182 = v19
									local TagColor = v1.TagColor

									v62 = not (if math.abs(v182.R - TagColor.R) < 0.001 then if math.abs(v182.G - TagColor.G) < 0.001 then math.abs(v182.B - TagColor.B) < 0.001 else false else false)
								else
									v62 = false
								end

								if not v62 then
									v62 = if v1 then if DEFAULT_ICON_ID == v1.IconId then false else true else false
								end
							end
						end
					end
				end

				v10.Visible = not v62
			end)
		end)
	end)
end

return t2