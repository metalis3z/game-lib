local OverheadNameService = {}

local NameGuiTemplate

local VERIFIED_SYMBOL = utf8.char(0xE000)
local PREMIUM_SYMBOL = utf8.char(0xE001)

local function getSymbols(player)
	local symbols = ""
	
	if player.HasVerifiedBadge then
		symbols = symbols .. " " .. VERIFIED_SYMBOL
	end

	if player.MembershipType == Enum.MembershipType.Premium then
		symbols = symbols .. " " .. PREMIUM_SYMBOL
	end

	return symbols
end

local function setupCharacterNameTag(character, player)
	if not NameGuiTemplate then return end
	local overheadGui = NameGuiTemplate:Clone()
	local symbols = getSymbols(player)
	overheadGui.NameLabel.Text = player.Name .. symbols
	overheadGui.Parent = character:WaitForChild("Head")
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		setupCharacterNameTag(character, player)
	end)

	if player.Character then
		setupCharacterNameTag(player.Character, player)
	end
end

function OverheadNameService.Init()
	NameGuiTemplate = game.ReplicatedStorage:FindFirstChild("OverheadGui")
	game.Players.PlayerAdded:Connect(onPlayerAdded)

	for _, player in ipairs(game.Players:GetPlayers()) do
		onPlayerAdded(player)
	end
end

return OverheadNameService