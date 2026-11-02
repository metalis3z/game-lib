--!native

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace         = game:GetService("Workspace")

local Net            = require(ReplicatedStorage.Packages.Net)
local PlayerMorph    = Net:RemoteEvent("AdminService/PlayerMorph")
local UpdateChatName = ReplicatedStorage:FindFirstChild("UpdateChatNameServer")
local NotificationService = require(game:GetService("ServerScriptService"):WaitForChild("Services"):WaitForChild("NotificationService"))
local TextService = game:GetService("TextService")
local UserService = game:GetService("UserService")

local function FilterText(text: string, userId: number): string
	if type(text) ~= "string" or text == "" then return "" end

	local success, result = pcall(function()
		local filterResult = TextService:FilterStringAsync(text, userId)
		return filterResult:GetNonChatStringForBroadcastAsync()
	end)

	if success and result then
		return result
	else
		warn("[TextFilter] Failed to filter text for UserId " .. tostring(userId))
		return ""
	end
end

local function ResetPlotLabels(Player: Player)
	local Plots = workspace:FindFirstChild("Plots")
	if not Plots then return end

	for _, plot in pairs(Plots:GetChildren()) do
		if plot:IsA("Model") then
			local sign  = plot:FindFirstChild("PlotSign")
			local gui   = sign and sign:FindFirstChildOfClass("SurfaceGui")
			local frame = gui and gui:FindFirstChild("Frame")
			local label = frame and frame:FindFirstChildOfClass("TextLabel")
			if label then
				label.Text = Player.Name .. "'s Base"
			end
		end
	end
end

local function ResetPlayerAttributes(Player: Player)
	local Character = Player.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			Humanoid.DisplayName = Player.Name
			Humanoid.Health = 0
		end
	end

	Player:SetAttribute("CustomName",        nil)
	Player:SetAttribute("Verified",          nil)
	Player:SetAttribute("MorphedUserId",     nil)
	Player:SetAttribute("MorphedDisplayName",nil)
	Player:SetAttribute("MorphedUsername",   nil)

	if Player.Character then
		Player.Character:SetAttribute("NewHipHeight", nil)
	end

	if UpdateChatName then
		UpdateChatName:Fire(Player, nil, nil)
	end

	ResetPlotLabels(Player)
end

local function HandlePlayerMorph(
	Player: Player,
	TargetUsername: string,
	ChatName: string,
	BaseName: string,
	Verified: string
): (boolean, string?)

	local TargetUserId
	local ok, err = pcall(function()
		TargetUserId = Players:GetUserIdFromNameAsync(TargetUsername)
	end)
	if not ok or not TargetUserId then
		return false, "Unknown user"
	end

	local HumanoidDescription
	local descOk, descErr = pcall(function()
		HumanoidDescription = Players:GetHumanoidDescriptionFromUserId(TargetUserId)
	end)
	if not descOk or not HumanoidDescription then
		return false, "Failed to get description: " .. tostring(descErr)
	end

	local Character = Player.Character
	if not Character then return false, "No character found." end

	local Humanoid = Character:FindFirstChild("Humanoid")
	if not Humanoid then return false, "No humanoid found." end

	local VERIFIED_SYMBOL = utf8.char(0xE000)
	local isVerified      = Verified:lower() == "yes"
	local displayName     = (ChatName ~= "") and ChatName or Player.Name
	local finalDisplay    = isVerified and (displayName .. " " .. VERIFIED_SYMBOL) or displayName

	Humanoid.DisplayName = finalDisplay

	local applyOk, applyErr = pcall(function()
		Humanoid:ApplyDescription(HumanoidDescription)
	end)
	if not applyOk then
		return false, "Failed to apply appearance: " .. tostring(applyErr)
	end

	Character:SetAttribute("NewHipHeight", Humanoid.HipHeight)

	if ChatName ~= "" then
		Player:SetAttribute("CustomName", ChatName)
	else
		Player:SetAttribute("CustomName", nil)
	end
	Player:SetAttribute("Verified", isVerified or nil)

	local TargetDisplayName = TargetUsername
	local infoOk, infoResult = pcall(function()
		return UserService:GetUserInfosByUserIdsAsync({ TargetUserId })
	end)
	if infoOk and typeof(infoResult) == "table" then
		for _, info in ipairs(infoResult) do
			if info.Id == TargetUserId
				and typeof(info.DisplayName) == "string"
				and #info.DisplayName > 0
			then
				TargetDisplayName = info.DisplayName
				break
			end
		end
	end

	Player:SetAttribute("MorphedUserId",      TargetUserId)
	Player:SetAttribute("MorphedDisplayName", TargetDisplayName)
	Player:SetAttribute("MorphedUsername",    TargetUsername)

	local plotLabel = (BaseName ~= "") and BaseName or displayName

	local Plots = workspace:FindFirstChild("Plots")
	if Plots then
		local playerPlot = _G.playerPlots and _G.playerPlots[Player.UserId]

		if playerPlot then
			local sign  = playerPlot:FindFirstChild("PlotSign")
			local label = sign and sign:FindFirstChild("TextLabel", true)
			if label then
				label.Text = plotLabel .. "'s Base"
			end
		else
			warn("[PlayerMorph] No plot found for: " .. Player.Name)
		end
	end

	if UpdateChatName then
		UpdateChatName:Fire(Player, ChatName, Verified)
	end

	return true, string.format("Morphed into %s!", TargetUsername)
end

local function OnCharacterAdded(Player: Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid  = Character:WaitForChild("Humanoid")

	Humanoid.Died:Connect(function()
		Player:SetAttribute("CustomName",        nil)
		Player:SetAttribute("Verified",          nil)
		Player:SetAttribute("MorphedUserId",     nil)
		Player:SetAttribute("MorphedDisplayName",nil)
		Player:SetAttribute("MorphedUsername",   nil)
		Character:SetAttribute("NewHipHeight", nil)
	end)
end

PlayerMorph.OnServerEvent:Connect(function(
	Player: Player,
	TargetUsernameOrUnmorph,
	ChatName,
	BaseName,
	_HeadName,
	Verified
)
	if TargetUsernameOrUnmorph == true then
		local Character = Player.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then Humanoid.DisplayName = Player.Name end
		end
		ResetPlayerAttributes(Player)
		return
	end

	local filteredChatName = FilterText(ChatName, Player.UserId)
	local filteredBaseName = FilterText(BaseName, Player.UserId)
	local filteredHeadName = FilterText(_HeadName, Player.UserId)

	local success, message = HandlePlayerMorph(
		Player,
		TargetUsernameOrUnmorph,
		filteredChatName,
		filteredBaseName,
		Verified or "no"
	)

	if not success then
		NotificationService.Error(Player, message)
		warn("[PlayerMorph] " .. Player.Name .. ": " .. (message or "Unknown error"))
	end
end)

local function OnPlayerAdded(Player: Player)
	if Player.Character then OnCharacterAdded(Player) end
	Player.CharacterAdded:Connect(function() OnCharacterAdded(Player) end)
end

for _, Player in pairs(Players:GetPlayers()) do
	OnPlayerAdded(Player)
end
Players.PlayerAdded:Connect(OnPlayerAdded)