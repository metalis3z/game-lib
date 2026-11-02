--# Services
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

--# Settings
local ENABLE_RAINBOW = true

local GAMEPASSES = {
	['VIP'] = 1,
	['Super VIP'] = 1048321311,
	['Mega VIP'] = 1048121782,
	['Ultra VIP'] = 1048465026,
	['Rainbow'] = 12271556
}

local TAG_COLORS = {
	['VIP'] = '#ffeca7',
	['Super VIP'] = '#a7e2ff',
	['Mega VIP'] = '#a7ffa7',
	['Ultra VIP'] = '#ffa7a7'
}

-- Manually assigned tags
local CUSTOM_TAGS = {
	["HOST"] = "nvm",
	["CO-OWNER"] = "SPECIAL USER"
}

--# Variables
local display = script:WaitForChild("PlayerDisplay")
local counter = 1

local marketplaceCache = {}

--# Functions
local function checkVip(player)
	if marketplaceCache[player] then
		return table.concat(marketplaceCache[player], ' | ')
	end

	local owned = {}

	for i, v in pairs(GAMEPASSES) do
		if not (i == 'Rainbow') then
			if MarketplaceService:UserOwnsGamePassAsync(player.UserId, v) then
				local str = string.gsub('<font color="'.. TAG_COLORS[i]..'">'.. string.upper(i) .. '</font>', '%s+VIP', '') 
				table.insert(owned, str)
			end
		end
	end

	if not owned[1] then
		return
	end
	marketplaceCache[player] = owned
	return table.concat(owned, ' | ')
end

local function heartbeat()
	if counter >= 255 then
		counter = 1
	end
	for _, v in ipairs(CollectionService:GetTagged("Rainbow")) do
		coroutine.wrap(function()
			v.TextColor3 = Color3.fromHSV(counter/255, 0.5, 1)
		end)()
	end
	counter += 1
end

local function onPlayerAdded(player)
	local clone = display:Clone()
	local frame = clone.Frame
	local nameDisplay = frame.NameDisplay
	local vipDisplay = frame.VIPDisplay
	local badges = frame.Badges

	local function characterAdded(character)
		local head = character:WaitForChild("Head")
		local humanoid = character:WaitForChild("Humanoid")

		-- Check if the player has a manually assigned tag
		if CUSTOM_TAGS[player.Name] then
			nameDisplay.Text = CUSTOM_TAGS[player.Name]
		else
			nameDisplay.Text = player.Name
		end

		-- Check for Rainbow or Ultra VIP game pass
		if MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASSES['Rainbow']) or 
			MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASSES['Ultra VIP']) then
			CollectionService:AddTag(nameDisplay, 'Rainbow')
		end

		-- Check for VIP game pass
		local checkVip = checkVip(player)
		if checkVip then
			vipDisplay.RichText = true
			vipDisplay.Text = checkVip
			vipDisplay.Visible = true
		else
			badges.AnchorPoint = vipDisplay.AnchorPoint
			badges.Position = vipDisplay.Position
		end

		humanoid.NameDisplayDistance = 0

		clone.Parent = character
		clone.Adornee = head
	end

	if player.Character then
		characterAdded(player.Character)
	end
	player.CharacterAdded:Connect(characterAdded)
end

--# Implicits
for _, v in ipairs(Players:GetPlayers()) do
	coroutine.wrap(onPlayerAdded)(v)
end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
	marketplaceCache[player] = nil
end)

if ENABLE_RAINBOW then
	RunService.Heartbeat:Connect(heartbeat)
end
