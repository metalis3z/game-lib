--credit to leon games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Asserts = require(ReplicatedStorage.SharedModules.Guild.Asserts)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local DevProductController = require(LocalPlayer.PlayerScripts.Controllers.DevProductController)
local ColorPickerGuildController = require(LocalPlayer.PlayerScripts.Controllers.ColorPickerGuildController)
local MIN_NAME_LENGTH = Asserts.MIN_NAME_LENGTH
local MAX_NAME_LENGTH = Asserts.MAX_NAME_LENGTH
local MIN_TAG_LENGTH = Asserts.MIN_TAG_LENGTH
local MAX_TAG_LENGTH = Asserts.MAX_TAG_LENGTH
local MAX_DESCRIPTION_LENGTH = Asserts.MAX_DESCRIPTION_LENGTH
local t = {
	StartOrder = 7
}
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
local v15 = nil
local v16 = nil
local v17 = Color3.fromRGB(255, 255, 255)
local v18 = Color3.fromRGB(255, 255, 255)
local v19 = false

local function utf8Len(p1) --[[ utf8Len | Line: 69 ]]
	return utf8.len(p1) or #p1
end

local function utf8Truncate(p1, p2) --[[ utf8Truncate | Line: 73 ]]
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

local function color3ToHex(p1) --[[ color3ToHex | Line: 83 ]]
	return string.format("#%02X%02X%02X", math.clamp(math.floor(p1.R * 255 + 0.5), 0, 255), math.clamp(math.floor(p1.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(p1.B * 255 + 0.5), 0, 255)))
end

local function trim(p1) --[[ trim | Line: 92 ]]
	return string.gsub(p1, "^%s*(.-)%s*$", "%1")
end

local function getName() --[[ getName | Line: 96 | Upvalues: v5 (ref) ]]
	if v5 then
		return string.gsub(v5.Text, "^%s*(.-)%s*$", "%1")
	end

	return ""
end

local function getTag() --[[ getTag | Line: 101 | Upvalues: v7 (ref) ]]
	if v7 then
		return string.gsub(v7.Text, "^%s*(.-)%s*$", "%1")
	end

	return ""
end

local function isNameValid() --[[ isNameValid | Line: 106 | Upvalues: v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy) ]]
	local v1 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v3 = utf8.len(v1) or #v1

	return if MIN_NAME_LENGTH <= v3 then v3 <= MAX_NAME_LENGTH else false
end

local function isTagValid() --[[ isTagValid | Line: 112 | Upvalues: v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy) ]]
	local v1 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
	local v3 = utf8.len(v1) or #v1

	return if MIN_TAG_LENGTH <= v3 then v3 <= MAX_TAG_LENGTH else false
end

local function getDescription() --[[ getDescription | Line: 118 | Upvalues: v9 (ref) ]]
	if v9 then
		return string.gsub(v9.Text, "^%s*(.-)%s*$", "%1")
	end

	return ""
end

local function isDescriptionValid() --[[ isDescriptionValid | Line: 123 | Upvalues: v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	local v1 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
	local v3 = utf8.len(v1) or #v1

	return if v3 >= 1 then v3 <= MAX_DESCRIPTION_LENGTH else false
end

local function isFormValid() --[[ isFormValid | Line: 131 | Upvalues: v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	local v1 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v3 = utf8.len(v1) or #v1
	local v4 = if MIN_NAME_LENGTH <= v3 then v3 <= MAX_NAME_LENGTH else false

	if v4 then
		local v52 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v72 = utf8.len(v52) or #v52

		v4 = if MIN_TAG_LENGTH <= v72 then v72 <= MAX_TAG_LENGTH else false

		if v4 then
			local v8 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v10 = utf8.len(v8) or #v8

			v4 = if v10 >= 1 then v10 <= MAX_DESCRIPTION_LENGTH else false
		end
	end

	return v4
end

local function setLabelChain(p1, p2) --[[ setLabelChain | Line: 135 ]]
	if not p1 then
		return
	end

	p1.Text = p2

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("TextLabel") or v2:IsA("TextButton") then
			v2.Text = p2
		end
	end
end

local function updateCounter(p1, p2, p3) --[[ updateCounter | Line: 145 | Upvalues: setLabelChain (copy) ]]
	if p1 then
		setLabelChain(p1, (("(%*/%*)"):format(p2, p3)))
	end
end

local function applyNameColor(p1) --[[ applyNameColor | Line: 150 | Upvalues: v17 (ref), v5 (ref) ]]
	v17 = p1

	if not v5 then
		return
	end

	v5.TextColor3 = p1
end

local function applyTagColor(p1) --[[ applyTagColor | Line: 157 | Upvalues: v18 (ref), v7 (ref) ]]
	v18 = p1

	if not v7 then
		return
	end

	v7.TextColor3 = p1
end

local function updateCreateBlock() --[[ updateCreateBlock | Line: 164 | Upvalues: v14 (ref), v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	if not v14 then
		return
	end

	local v2 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v4 = utf8.len(v2) or #v2
	local v52 = if MIN_NAME_LENGTH <= v4 then v4 <= MAX_NAME_LENGTH else false

	if v52 then
		local v6 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v8 = utf8.len(v6) or #v6

		v52 = if MIN_TAG_LENGTH <= v8 then v8 <= MAX_TAG_LENGTH else false

		if v52 then
			local v92 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v11 = utf8.len(v92) or #v92

			v52 = if v11 >= 1 then if v11 <= MAX_DESCRIPTION_LENGTH then true else false else false
		end
	end

	v14.Visible = not v52
end

local function clampNameText() --[[ clampNameText | Line: 173 | Upvalues: v5 (ref), MAX_NAME_LENGTH (copy), v10 (ref), setLabelChain (copy), v14 (ref), MIN_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	if not v5 then
		return
	end

	local v1 = string.gsub(v5.Text, "[^A-Za-z0-9 _\'%-]", "")
	local v2 = MAX_NAME_LENGTH
	local v3 = utf8.len(v1)
	local v4

	if v3 and not (v3 <= v2) then
		local v52 = utf8.offset(v1, v2 + 1)

		v4 = if v52 then string.sub(v1, 1, v52 - 1) else string.sub(v1, 1, v2)
	else
		v4 = v1
	end

	if v4 ~= v5.Text then
		v5.Text = v4
	end

	local v8 = v10
	local Text = v5.Text
	local v92 = utf8.len(Text)
	local v102 = if v92 then v92 else #Text
	local v11 = MAX_NAME_LENGTH

	if v8 then
		setLabelChain(v8, (("(%*/%*)"):format(v102, v11)))
	end

	if not v14 then
		return
	end

	local v13 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v15 = utf8.len(v13) or #v13
	local v16 = if MIN_NAME_LENGTH <= v15 then v15 <= MAX_NAME_LENGTH else false

	if v16 then
		local v17 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v19 = utf8.len(v17) or #v17

		v16 = if MIN_TAG_LENGTH <= v19 then v19 <= MAX_TAG_LENGTH else false

		if v16 then
			local v20 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v22 = utf8.len(v20) or #v20

			v16 = if v22 >= 1 then if v22 <= MAX_DESCRIPTION_LENGTH then true else false else false
		end
	end

	v14.Visible = not v16
end

local function clampTagText() --[[ clampTagText | Line: 186 | Upvalues: v7 (ref), MAX_TAG_LENGTH (copy), v11 (ref), setLabelChain (copy), v14 (ref), v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), MIN_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	if not v7 then
		return
	end

	local v2 = string.gsub(string.upper(v7.Text), "[^A-Z0-9]", "")
	local v3 = MAX_TAG_LENGTH
	local v4 = utf8.len(v2)
	local v52

	if v4 and not (v4 <= v3) then
		local v6 = utf8.offset(v2, v3 + 1)

		v52 = if v6 then string.sub(v2, 1, v6 - 1) else string.sub(v2, 1, v3)
	else
		v52 = v2
	end

	if v52 ~= v7.Text then
		v7.Text = v52
	end

	local v92 = v11
	local Text = v7.Text
	local v10 = utf8.len(Text)
	local v112 = if v10 then v10 else #Text
	local v12 = MAX_TAG_LENGTH

	if v92 then
		setLabelChain(v92, (("(%*/%*)"):format(v112, v12)))
	end

	if not v14 then
		return
	end

	local v142 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v16 = utf8.len(v142) or #v142
	local v17 = if MIN_NAME_LENGTH <= v16 then v16 <= MAX_NAME_LENGTH else false

	if v17 then
		local v18 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v20 = utf8.len(v18) or #v18

		v17 = if MIN_TAG_LENGTH <= v20 then v20 <= MAX_TAG_LENGTH else false

		if v17 then
			local v21 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v23 = utf8.len(v21) or #v21

			v17 = if v23 >= 1 then if v23 <= MAX_DESCRIPTION_LENGTH then true else false else false
		end
	end

	v14.Visible = not v17
end

local function clampDescriptionText() --[[ clampDescriptionText | Line: 202 | Upvalues: v9 (ref), MAX_DESCRIPTION_LENGTH (copy), v12 (ref), setLabelChain (copy), v14 (ref), v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy) ]]
	if not v9 then
		return
	end

	local v1 = string.gsub(v9.Text, "[^ -~]", "")
	local v2 = MAX_DESCRIPTION_LENGTH
	local v3 = utf8.len(v1)
	local v4

	if v3 and not (v3 <= v2) then
		local v52 = utf8.offset(v1, v2 + 1)

		v4 = if v52 then string.sub(v1, 1, v52 - 1) else string.sub(v1, 1, v2)
	else
		v4 = v1
	end

	if v4 ~= v9.Text then
		v9.Text = v4
	end

	local v8 = v12
	local Text = v9.Text
	local v92 = utf8.len(Text)
	local v10 = if v92 then v92 else #Text
	local v11 = MAX_DESCRIPTION_LENGTH

	if v8 then
		setLabelChain(v8, (("(%*/%*)"):format(v10, v11)))
	end

	if not v14 then
		return
	end

	local v13 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v15 = utf8.len(v13) or #v13
	local v16 = if MIN_NAME_LENGTH <= v15 then v15 <= MAX_NAME_LENGTH else false

	if v16 then
		local v17 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v19 = utf8.len(v17) or #v17

		v16 = if MIN_TAG_LENGTH <= v19 then v19 <= MAX_TAG_LENGTH else false

		if v16 then
			local v20 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v22 = utf8.len(v20) or #v20

			v16 = if v22 >= 1 then if v22 <= MAX_DESCRIPTION_LENGTH then true else false else false
		end
	end

	v14.Visible = not v16
end

local function notifyServerError(p1) --[[ notifyServerError | Line: 217 | Upvalues: NotificationController (copy) ]]
	if p1 == "name_filtered" or p1 == "invalid_name" then
		NotificationController:CreateNotification("Guild name not allowed, try another!")

		return
	end

	if p1 == "tag_filtered" or p1 == "invalid_tag" then
		NotificationController:CreateNotification("Guild tag not allowed, try another!")

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

	if p1 == "tag_taken" then
		NotificationController:CreateNotification("That guild tag is taken")

		return
	end

	if p1 == "already_in_guild" then
		NotificationController:CreateNotification("You\'re already in a guild!")

		return
	end

	if p1 == "no_creation_token" then
		NotificationController:CreateNotification("You need to purchase Guild Creation first")

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
		NotificationController:CreateNotification((("Failed to create guild (%*)"):format(p1)))
	else
		NotificationController:CreateNotification("Failed to create guild")
	end
end

local function notifySuccess(p1, p2) --[[ notifySuccess | Line: 249 | Upvalues: v17 (ref), v18 (ref), NotificationController (copy) ]]
	local v1 = v17
	local v10 = string.format("#%02X%02X%02X", math.clamp(math.floor(v1.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v1.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v1.B * 255 + 0.5), 0, 255)))
	local v11 = v18

	NotificationController:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v10, p1, string.format("#%02X%02X%02X", math.clamp(math.floor(v11.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v11.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v11.B * 255 + 0.5), 0, 255))), p2)))
end

local function fireCreate(p1, p2, p3) --[[ fireCreate | Line: 260 | Upvalues: Networking (copy), v17 (ref), v19 (ref), NotificationController (copy), notifyServerError (copy), v18 (ref), GuiController (copy) ]]
	task.spawn(function() --[[ Line: 262 | Upvalues: Networking (ref), p1 (copy), p2 (copy), v17 (ref), p3 (copy), v19 (ref), NotificationController (ref), notifyServerError (ref), v18 (ref), GuiController (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 263 | Upvalues: Networking (ref), p1 (ref), p2 (ref), v17 (ref), p3 (ref) ]]
			local v3 = v17

			return Networking.Guild.CreateGuild:Fire(p1, p2, string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255))), p3)
		end)

		v19 = false

		if not ok then
			NotificationController:CreateNotification("Failed to create guild")

			return
		end

		if result then
			local v3 = v17
			local v122 = string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255)))
			local v132 = v18

			NotificationController:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v122, p1, string.format("#%02X%02X%02X", math.clamp(math.floor(v132.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v132.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v132.B * 255 + 0.5), 0, 255))), p2)))
			GuiController:Open("ViewGuildPage", nil, { "HUD" })

			if not GuiController:IsOpen("CreateGuild") then
				return
			end

			GuiController:Close()
		else
			local v23 = if typeof(result2) == "string" and result2 then result2 else nil

			if v23 == "name_taken" then
				NotificationController:CreateNotification("That guild name is already taken, but don\'t worry - your next creation is free!")

				return
			end

			if v23 == "tag_taken" then
				NotificationController:CreateNotification("That guild tag is already taken, but don\'t worry - your next creation is free!")
			else
				notifyServerError(v23)
			end
		end
	end)
end

local function promptCreatePurchase(p1, p2, p3) --[[ promptCreatePurchase | Line: 313 | Upvalues: DevProductController (copy), Networking (copy), v17 (ref), v19 (ref), NotificationController (copy), notifyServerError (copy), v18 (ref), GuiController (copy) ]]
	local v1 = false
	local v2 = false
	local v3 = DevProductController.PurchaseComplete:Connect(function(p1) --[[ Line: 321 | Upvalues: v2 (ref), v1 (ref) ]]
		if p1 ~= "Guild:Guild Creation:1" then
			return
		end

		v2 = true
		v1 = true
	end)
	local v4 = DevProductController.PurchaseFailed:Connect(function(p1, p2) --[[ Line: 327 | Upvalues: v1 (ref) ]]
		if p1 ~= "Guild:Guild Creation:1" then
			return
		end

		v1 = true
	end)
	local v5 = DevProductController.PurchaseCancelled:Connect(function(p1) --[[ Line: 332 | Upvalues: v1 (ref) ]]
		if p1 ~= "Guild:Guild Creation:1" then
			return
		end

		v1 = true
	end)
	local v6, v7 = DevProductController:PromptPurchase("Guild:Guild Creation:1")

	if v6 then
		if v7 ~= "Prompted Robux" and not v1 then
			v2 = true
			v1 = true
		end
	else
		v1 = true
	end

	local v8 = os.clock()
	local v9, v10, v11 = v3, v4, v5

	while not v1 and os.clock() - v8 < 60 do
		task.wait(0.1)
	end

	if v9 then
		v9:Disconnect()
	end

	if v10 then
		v10:Disconnect()
	end

	if v11 then
		v11:Disconnect()
	end

	if v2 then
		task.spawn(function() --[[ Line: 262 | Upvalues: Networking (ref), p1 (copy), p2 (copy), v17 (ref), p3 (copy), v19 (ref), NotificationController (ref), notifyServerError (ref), v18 (ref), GuiController (ref) ]]
			local ok, result, result2 = pcall(function() --[[ Line: 263 | Upvalues: Networking (ref), p1 (ref), p2 (ref), v17 (ref), p3 (ref) ]]
				local v3 = v17

				return Networking.Guild.CreateGuild:Fire(p1, p2, string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255))), p3)
			end)

			v19 = false

			if not ok then
				NotificationController:CreateNotification("Failed to create guild")

				return
			end

			if result then
				local v3 = v17
				local v122 = string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255)))
				local v132 = v18

				NotificationController:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v122, p1, string.format("#%02X%02X%02X", math.clamp(math.floor(v132.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v132.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v132.B * 255 + 0.5), 0, 255))), p2)))
				GuiController:Open("ViewGuildPage", nil, { "HUD" })

				if not GuiController:IsOpen("CreateGuild") then
					return
				end

				GuiController:Close()
			else
				local v23 = if typeof(result2) == "string" and result2 then result2 else nil

				if v23 == "name_taken" then
					NotificationController:CreateNotification("That guild name is already taken, but don\'t worry - your next creation is free!")

					return
				end

				if v23 == "tag_taken" then
					NotificationController:CreateNotification("That guild tag is already taken, but don\'t worry - your next creation is free!")
				else
					notifyServerError(v23)
				end
			end
		end)
	else
		v19 = false
	end
end

local function tryCreate() --[[ tryCreate | Line: 367 | Upvalues: v19 (ref), v5 (ref), v7 (ref), v9 (ref), NotificationController (copy), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), MAX_DESCRIPTION_LENGTH (copy), LocalPlayer (copy), Networking (copy), notifyServerError (copy), v17 (ref), v18 (ref), GuiController (copy), promptCreatePurchase (copy) ]]
	if v19 then
		return
	end

	local v1 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v2 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
	local v3 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
	local v4 = utf8.len(v1) or #v1
	local v52 = utf8.len(v2) or #v2
	local v6 = utf8.len(v3) or #v3

	if v4 < 1 then
		NotificationController:CreateNotification("Enter a guild name first!")

		return
	end

	if v4 < MIN_NAME_LENGTH or MAX_NAME_LENGTH < v4 then
		NotificationController:CreateNotification((("Guild name must be %*-%* characters"):format(MIN_NAME_LENGTH, MAX_NAME_LENGTH)))

		return
	end

	if v52 < MIN_TAG_LENGTH or MAX_TAG_LENGTH < v52 then
		NotificationController:CreateNotification("Guild tag must be 2-5 characters")

		return
	end

	if v6 < 1 then
		NotificationController:CreateNotification("Enter a guild description first!")

		return
	end

	if MAX_DESCRIPTION_LENGTH < v6 then
		NotificationController:CreateNotification("Guild description is too long")

		return
	end

	if LocalPlayer:GetAttribute("GuildId") == nil then
		v19 = true
		task.spawn(function() --[[ Line: 410 | Upvalues: Networking (ref), v1 (copy), v2 (copy), v3 (copy), v19 (ref), NotificationController (ref), notifyServerError (ref), v17 (ref), v18 (ref), GuiController (ref), promptCreatePurchase (ref) ]]
			local ok, result, result2, result3 = pcall(function() --[[ Line: 411 | Upvalues: Networking (ref), v1 (ref), v2 (ref), v3 (ref) ]]
				return Networking.Guild.CheckCreateAvailability:Fire(v1, v2, v3)
			end)

			if not ok then
				v19 = false
				NotificationController:CreateNotification("Failed to create guild")

				return
			end

			if result then
				if result3 then
					local v12 = v1
					local v22 = v2
					local v32 = v3

					task.spawn(function() --[[ Line: 262 | Upvalues: Networking (ref), v12 (copy), v22 (copy), v17 (ref), v32 (copy), v19 (ref), NotificationController (ref), notifyServerError (ref), v18 (ref), GuiController (ref) ]]
						local ok, result, result2 = pcall(function() --[[ Line: 263 | Upvalues: Networking (ref), v12 (ref), v22 (ref), v17 (ref), v32 (ref) ]]
							local v3 = v17

							return Networking.Guild.CreateGuild:Fire(p1, p2, string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255))), p3)
						end)

						v19 = false

						if not ok then
							NotificationController:CreateNotification("Failed to create guild")

							return
						end

						if result then
							local v3 = v17
							local v122 = string.format("#%02X%02X%02X", math.clamp(math.floor(v3.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v3.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v3.B * 255 + 0.5), 0, 255)))
							local v132 = v18

							NotificationController:CreateNotification((string.format("Created Guild: <font color=\"%s\">%s</font> [<font color=\"%s\">%s</font>]", v122, v12, string.format("#%02X%02X%02X", math.clamp(math.floor(v132.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v132.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v132.B * 255 + 0.5), 0, 255))), v22)))
							GuiController:Open("ViewGuildPage", nil, { "HUD" })

							if not GuiController:IsOpen("CreateGuild") then
								return
							end

							GuiController:Close()
						else
							local v23 = if typeof(result2) == "string" and result2 then result2 else nil

							if v23 == "name_taken" then
								NotificationController:CreateNotification("That guild name is already taken, but don\'t worry - your next creation is free!")

								return
							end

							if v23 == "tag_taken" then
								NotificationController:CreateNotification("That guild tag is already taken, but don\'t worry - your next creation is free!")
							else
								notifyServerError(v23)
							end
						end
					end)
				else
					promptCreatePurchase(v1, v2, v3)
				end
			else
				v19 = false
				notifyServerError(if typeof(result2) == "string" then result2 or nil else nil)
			end
		end)
	else
		NotificationController:CreateNotification("You\'re already in a guild!")
	end
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 439 | Upvalues: v4 (ref), v5 (ref), v6 (ref), v10 (ref), v7 (ref), v8 (ref), v11 (ref), v9 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref) ]]
	local MainPage = p1:FindFirstChild("MainPage")

	if not MainPage then
		return
	end

	local Header = MainPage:FindFirstChild("Header")

	if Header then
		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v4 = ExitButton
		end
	end

	local v1 = MainPage:FindFirstChild("Content")

	if v1 then
		local Name = v1:FindFirstChild("Name")

		if Name then
			local TextField = Name:FindFirstChild("TextField")

			if TextField then
				local TextBox = TextField:FindFirstChild("TextBox")

				if TextBox and TextBox:IsA("TextBox") then
					v5 = TextBox
				end
			end

			local ColorPickerButton = Name:FindFirstChild("ColorPickerButton")

			if ColorPickerButton and ColorPickerButton:IsA("GuiButton") then
				v6 = ColorPickerButton
			end

			local CharacterCounter = Name:FindFirstChild("CharacterCounter")

			if CharacterCounter and CharacterCounter:IsA("TextLabel") then
				v10 = CharacterCounter
			end
		end

		local Tag = v1:FindFirstChild("Tag")

		if Tag then
			local TextField = Tag:FindFirstChild("TextField")

			if TextField then
				local TextBox = TextField:FindFirstChild("TextBox")

				if TextBox and TextBox:IsA("TextBox") then
					v7 = TextBox
				end
			end

			local ColorPickerButton = Tag:FindFirstChild("ColorPickerButton")

			if ColorPickerButton and ColorPickerButton:IsA("GuiButton") then
				v8 = ColorPickerButton
			end

			local CharacterCounter = Tag:FindFirstChild("CharacterCounter")

			if CharacterCounter and CharacterCounter:IsA("TextLabel") then
				v11 = CharacterCounter
			end
		end

		local Description = v1:FindFirstChild("Description")

		if Description then
			local TextField = Description:FindFirstChild("TextField")

			if TextField then
				local TextBox = TextField:FindFirstChild("TextBox")

				if TextBox and TextBox:IsA("TextBox") then
					v9 = TextBox
				end
			end

			local CharacterCounter = Description:FindFirstChild("CharacterCounter")

			if CharacterCounter and CharacterCounter:IsA("TextLabel") then
				v12 = CharacterCounter
			end
		end
	end

	local CreateButton = MainPage:FindFirstChild("CreateButton")

	if not (CreateButton and CreateButton:IsA("GuiButton")) then
		return
	end

	v13 = CreateButton

	local CreateBlock = CreateButton:FindFirstChild("CreateBlock")

	if CreateBlock and CreateBlock:IsA("GuiObject") then
		v14 = CreateBlock
	end

	local TextLabel = CreateButton:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	v15 = TextLabel

	local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

	if not (TextLabel2 and TextLabel2:IsA("TextLabel")) then
		return
	end

	v16 = TextLabel2
end

local function BindTextBoxes() --[[ BindTextBoxes | Line: 525 | Upvalues: v5 (ref), v17 (ref), clampNameText (copy), v7 (ref), v18 (ref), clampTagText (copy), v9 (ref), clampDescriptionText (copy) ]]
	if v5 then
		v5.ClearTextOnFocus = false
		v5.TextColor3 = v17
		v5:GetPropertyChangedSignal("Text"):Connect(clampNameText)
		clampNameText()
	end

	if v7 then
		v7.ClearTextOnFocus = false
		v7.TextColor3 = v18
		v7:GetPropertyChangedSignal("Text"):Connect(clampTagText)
		clampTagText()
	end

	if not v9 then
		return
	end

	v9.ClearTextOnFocus = false
	v9:GetPropertyChangedSignal("Text"):Connect(clampDescriptionText)
	clampDescriptionText()
end

local function BindColorPickers() --[[ BindColorPickers | Line: 545 | Upvalues: v6 (ref), ColorPickerGuildController (copy), v17 (ref), v5 (ref), GuiController (copy), v8 (ref), v18 (ref), v7 (ref) ]]
	if v6 then
		v6.MouseButton1Click:Connect(function() --[[ Line: 547 | Upvalues: ColorPickerGuildController (ref), v17 (ref), v5 (ref), GuiController (ref) ]]
			ColorPickerGuildController:RequestColor(v17, function(p1) --[[ Line: 548 | Upvalues: v17 (ref), v5 (ref), GuiController (ref) ]]
				if p1 then
					v17 = p1

					if v5 then
						v5.TextColor3 = p1
					end
				end

				if GuiController:IsOpen("CreateGuild") then
					return
				end

				GuiController:Open("CreateGuild", nil, { "HUD" })
			end)
		end)
	end

	if not v8 then
		return
	end

	v8.MouseButton1Click:Connect(function() --[[ Line: 560 | Upvalues: ColorPickerGuildController (ref), v18 (ref), v7 (ref), GuiController (ref) ]]
		ColorPickerGuildController:RequestColor(v18, function(p1) --[[ Line: 561 | Upvalues: v18 (ref), v7 (ref), GuiController (ref) ]]
			if p1 then
				v18 = p1

				if v7 then
					v7.TextColor3 = p1
				end
			end

			if GuiController:IsOpen("CreateGuild") then
				return
			end

			GuiController:Open("CreateGuild", nil, { "HUD" })
		end)
	end)
end

local function BindInviteButtons() --[[ BindInviteButtons | Line: 573 ]] end

local function BindCreateButton() --[[ BindCreateButton | Line: 578 | Upvalues: v13 (ref), setLabelChain (copy), v15 (ref), v16 (ref), tryCreate (copy) ]]
	if v13 then
		v13.MouseEnter:Connect(function() --[[ Line: 581 | Upvalues: setLabelChain (ref), v15 (ref), v16 (ref) ]]
			setLabelChain(v15, "99 R$")
			setLabelChain(v16, "99 R$")
		end)
		v13.MouseLeave:Connect(function() --[[ Line: 585 | Upvalues: setLabelChain (ref), v15 (ref), v16 (ref) ]]
			setLabelChain(v15, "Create")
			setLabelChain(v16, "Create")
		end)
		v13.MouseButton1Click:Connect(tryCreate)
	end
end

local function BindExitButton() --[[ BindExitButton | Line: 592 | Upvalues: v4 (ref), GuiController (copy) ]]
	if v4 then
		v4.MouseButton1Click:Connect(function() --[[ Line: 594 | Upvalues: GuiController (ref) ]]
			if not GuiController:IsOpen("CreateGuild") then
				return
			end

			GuiController:Close()
		end)
	end
end

local function ResetOnOpen() --[[ ResetOnOpen | Line: 601 | Upvalues: setLabelChain (copy), v15 (ref), v16 (ref), v14 (ref), v5 (ref), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	setLabelChain(v15, "Create")
	setLabelChain(v16, "Create")

	if not v14 then
		return
	end

	local v2 = if v5 then string.gsub(v5.Text, "^%s*(.-)%s*$", "%1") else ""
	local v4 = utf8.len(v2) or #v2
	local v52 = if MIN_NAME_LENGTH <= v4 then v4 <= MAX_NAME_LENGTH else false

	if v52 then
		local v6 = if v7 then string.gsub(v7.Text, "^%s*(.-)%s*$", "%1") else ""
		local v8 = utf8.len(v6) or #v6

		v52 = if MIN_TAG_LENGTH <= v8 then v8 <= MAX_TAG_LENGTH else false

		if v52 then
			local v92 = if v9 then string.gsub(v9.Text, "^%s*(.-)%s*$", "%1") else ""
			local v11 = utf8.len(v92) or #v92

			v52 = if v11 >= 1 then if v11 <= MAX_DESCRIPTION_LENGTH then true else false else false
		end
	end

	v14.Visible = not v52
end

function t.Init(p1) --[[ Init | Line: 610 ]] end
function t.Start(p1) --[[ Start | Line: 612 | Upvalues: PlayerGui (copy), v3 (ref), ResolveRefs (copy), v4 (ref), GuiController (copy), BindTextBoxes (copy), BindColorPickers (copy), BindCreateButton (copy), setLabelChain (copy), v15 (ref), v16 (ref), v14 (ref), v5 (ref), trim (copy), MIN_NAME_LENGTH (copy), MAX_NAME_LENGTH (copy), v7 (ref), MIN_TAG_LENGTH (copy), MAX_TAG_LENGTH (copy), v9 (ref), MAX_DESCRIPTION_LENGTH (copy) ]]
	task.spawn(function() --[[ Line: 613 | Upvalues: PlayerGui (ref), v3 (ref), ResolveRefs (ref), v4 (ref), GuiController (ref), BindTextBoxes (ref), BindColorPickers (ref), BindCreateButton (ref), setLabelChain (ref), v15 (ref), v16 (ref), v14 (ref), v5 (ref), trim (ref), MIN_NAME_LENGTH (ref), MAX_NAME_LENGTH (ref), v7 (ref), MIN_TAG_LENGTH (ref), MAX_TAG_LENGTH (ref), v9 (ref), MAX_DESCRIPTION_LENGTH (ref) ]]
		local CreateGuild = PlayerGui:WaitForChild("CreateGuild", 30)

		if not (CreateGuild and CreateGuild:IsA("ScreenGui")) then
			return
		end

		v3 = CreateGuild
		CreateGuild.Enabled = false
		ResolveRefs(CreateGuild)

		if v4 then
			v4.MouseButton1Click:Connect(function() --[[ Line: 594 | Upvalues: GuiController (ref) ]]
				if not GuiController:IsOpen("CreateGuild") then
					return
				end

				GuiController:Close()
			end)
		end

		BindTextBoxes()
		BindColorPickers()
		BindCreateButton()
		GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 627 | Upvalues: CreateGuild (copy), setLabelChain (ref), v15 (ref), v16 (ref), v14 (ref), v5 (ref), trim (ref), MIN_NAME_LENGTH (ref), MAX_NAME_LENGTH (ref), v7 (ref), MIN_TAG_LENGTH (ref), MAX_TAG_LENGTH (ref), v9 (ref), MAX_DESCRIPTION_LENGTH (ref) ]]
			if p1 ~= CreateGuild then
				return
			end

			setLabelChain(v15, "Create")
			setLabelChain(v16, "Create")

			if not v14 then
				return
			end

			local v2 = if v5 then trim(v5.Text) else ""
			local v3 = utf8.len(v2) or #v2
			local v4 = if MIN_NAME_LENGTH <= v3 then v3 <= MAX_NAME_LENGTH else false

			if v4 then
				local v52 = if v7 then trim(v7.Text) else ""
				local v6 = utf8.len(v52) or #v52

				v4 = if MIN_TAG_LENGTH <= v6 then v6 <= MAX_TAG_LENGTH else false

				if v4 then
					local v72 = if v9 then trim(v9.Text) else ""
					local v8 = utf8.len(v72) or #v72

					v4 = if v8 >= 1 then if v8 <= MAX_DESCRIPTION_LENGTH then true else false else false
				end
			end

			v14.Visible = not v4
		end)
	end)
end

return t