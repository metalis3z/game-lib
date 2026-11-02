--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.NotificationController)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local FenceData = require(ReplicatedStorage.SharedModules.FenceData)
local CrateData = require(ReplicatedStorage.SharedModules.CrateData)
local FenceThemes = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("PlotAssets"):WaitForChild("FenceThemes")
local Gardens = workspace:WaitForChild("Gardens")
local CustomiseFenceTheme = LocalPlayer.PlayerGui:WaitForChild("CustomiseFenceTheme")
local FenceScrollingFrame = CustomiseFenceTheme:WaitForChild("Frame"):WaitForChild("FenceScrollingFrame")
local tbl = {}
local GardenStatsHeader = CustomiseFenceTheme:WaitForChild("Frame"):WaitForChild("GardenStatsHeader")

table.insert(tbl, GardenStatsHeader:WaitForChild("ExitButton"))

local FenceSkinHeader = CustomiseFenceTheme:WaitForChild("Frame"):WaitForChild("FenceSkinHeader")

table.insert(tbl, FenceSkinHeader:WaitForChild("ExitButton"))

local Template = script:WaitForChild("Template")

Template.Visible = false
Template:WaitForChild("Unowned")

local t = {}
local v1 = 0

for v2, v3 in FenceData.Data do
	t[v3.PropName] = v3.IMG
end

local t2 = {}

for v4, v5 in CrateData.GetAllCrates() do
	if v5.CrateType == "Fence" and v5.Items then
		for v6, v7 in v5.Items do
			if v7.Name then
				t2[v7.Name] = v6
			end
		end

		break
	end
end

local v8 = false
local v9 = PlayerStateClient:WaitForLocalReplica(30)
local CurrentCamera = game.Workspace.CurrentCamera

local function parseOwnedAndEquippedSkins(p1) --[[ parseOwnedAndEquippedSkins | Line: 57 ]]
	local t = {}
	local v1 = ""

	for v2 in p1:gmatch("[^,]+") do
		local v3 = v2:match("^%s*(.-)%s*$")

		if v3 ~= "" then
			if v3:sub(-1) == "+" then
				local v4 = v3:sub(1, -2)

				v3 = v4
				v1 = v4
			end

			t[v3] = true
		end
	end

	return t, v1
end

local function getAllSkinNames() --[[ getAllSkinNames | Line: 73 | Upvalues: FenceThemes (copy), t2 (copy) ]]
	local t = {}

	for v1, v2 in FenceThemes:GetChildren() do
		table.insert(t, v2.Name)
	end

	table.sort(t, function(p1, p2) --[[ Line: 80 | Upvalues: t2 (ref) ]]
		if p1 == "Default" then
			return true
		end

		if p2 == "Default" then
			return false
		end

		local v1 = t2[p1] or 10000
		local v2 = t2[p2] or 10000

		if v1 == v2 then
			return p1 < p2
		end

		return v1 < v2
	end)

	return t
end

local function Track(p1) --[[ Track | Line: 100 ]]
	local Equipped = p1:WaitForChild("Equipped")
	local Checkmark = p1:WaitForChild("Checkmark")

	Checkmark.Visible = Equipped.Value
	Equipped:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 105 | Upvalues: Checkmark (copy), Equipped (copy) ]]
		Checkmark.Visible = Equipped.Value
	end)
end

local function v10() --[[ refreshFenceSkinsList | Line: 110 | Upvalues: v9 (copy), parseOwnedAndEquippedSkins (copy), getAllSkinNames (copy), FenceScrollingFrame (copy), Template (copy), t (copy), Track (copy), v8 (ref), v1 (ref), NotificationController (copy), Networking (copy), v10 (copy) ]]
	local v12 = if v9 then v9.Data.OwnedFenceSkins or "" else ""
	local v2, v3 = parseOwnedAndEquippedSkins(v12)
	local t2 = {}

	for v4, v5 in getAllSkinNames() do
		t2[v5] = true

		local v6 = FenceScrollingFrame:FindFirstChild(v5)

		if not v6 then
			v6 = Template:Clone()
			v6.Name = v5
			v6.Visible = true
			v6.LayoutOrder = v4
			v6.Parent = FenceScrollingFrame

			local Vector = v6:FindFirstChild("Vector")

			if Vector and t[v5] then
				Vector.Image = t[v5]
			end

			Track(v6)
			v6.Activated:Connect(function() --[[ Line: 134 | Upvalues: v8 (ref), v6 (ref), v9 (ref), parseOwnedAndEquippedSkins (ref), v5 (copy), v1 (ref), NotificationController (ref), Networking (ref), v10 (ref) ]]
				if v8 then
					return
				end

				local Equipped = v6:FindFirstChild("Equipped")

				if Equipped and Equipped.Value then
					return
				end

				if not parseOwnedAndEquippedSkins(if v9 then v9.Data.OwnedFenceSkins or "" else "")[v5] then
					return
				end

				local v2 = 5 - (os.clock() - v1)

				if v2 > 0 then
					NotificationController:CreateNotification(("Please wait %*s"):format((math.ceil(v2))), false, 2)
				else
					v8 = true
					v1 = os.clock()

					local _, _2 = pcall(function() --[[ Line: 151 | Upvalues: Networking (ref), v5 (ref) ]]
						return Networking.Actions.ChangeFenceTheme:Fire(v5)
					end)

					v8 = false
					v10()
				end
			end)
		end

		v6.LayoutOrder = v4

		local Equipped = v6:FindFirstChild("Equipped")
		local FenceName = v6:FindFirstChild("FenceName")

		if FenceName then
			FenceName.Value = v5
		end

		if Equipped then
			Equipped.Value = v3 == v5
		end

		local Unowned = v6:FindFirstChild("Unowned")

		if Unowned then
			Unowned.Visible = not (v2[v5] == true)
		end

		v6.Active = if v2[v5] == true then true else false
		v6.AutoButtonColor = if v2[v5] == true then true else false
	end

	for v11, v122 in FenceScrollingFrame:GetChildren() do
		if v122:IsA("ImageButton") and (v122 ~= Template and not t2[v122.Name]) then
			v122:Destroy()
		end
	end
end

local function getPromptPlotId(p1) --[[ getPromptPlotId | Line: 189 | Upvalues: Gardens (copy) ]]
	local v1 = p1.Parent

	while v1 do
		if v1.Parent == Gardens and v1:IsA("Model") then
			return tonumber(v1.Name:match("%d+"))
		end

		v1 = v1.Parent
	end

	return nil
end

local function getPlotOwner(p1) --[[ getPlotOwner | Line: 200 | Upvalues: Players (copy) ]]
	if p1 == nil then
		return nil
	end

	for v1, v2 in Players:GetPlayers() do
		if tonumber(v2:GetAttribute("PlotId")) == p1 then
			return v2
		end
	end

	return nil
end

local function isCustomiseThemePrompt(p1) --[[ isCustomiseThemePrompt | Line: 210 ]]
	return p1:IsA("ProximityPrompt") and (if p1.Name == "CustomiseTheme" then true else p1.ActionText == "Customise Theme")
end

local v11 = Vector2.new(0, -35)
local v12 = Vector2.new(0, 35)
local v13 = 0

local function isGuildInviter() --[[ isGuildInviter | Line: 238 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer:GetAttribute("GuildRole")

	if typeof(v1) ~= "string" then
		return false
	end

	return if v1 == "Owner" then true else v1 == "Elder"
end

local function fireGuildInvite(p1) --[[ fireGuildInvite | Line: 251 | Upvalues: v13 (ref), NotificationController (copy), Networking (copy) ]]
	local v1 = os.clock()

	if v1 - v13 < 5 then
		NotificationController:CreateNotification(string.format("Wait %ds before inviting again", (math.max(1, (math.ceil(5 - (v1 - v13)))))), false, 4)
	else
		v13 = v1
		task.spawn(function() --[[ Line: 266 | Upvalues: Networking (ref), p1 (copy), NotificationController (ref) ]]
			local ok, result, result2 = pcall(function() --[[ Line: 267 | Upvalues: Networking (ref), p1 (ref) ]]
				return Networking.Guild.Invite:Fire(p1)
			end)

			if not ok then
				NotificationController:CreateNotification("Try again", false, 4)

				return
			end

			if result then
				NotificationController:CreateNotification("Guild invite sent!", false, 4)

				return
			end

			local v1 = tostring(result2 or "")

			NotificationController:CreateNotification(({
				not_in_guild = "You\'re not in a guild",
				no_invite_permission = "Only Owners and Elders can invite",
				already_member = "They\'re already in your guild",
				target_in_guild = "They\'re already in a guild",
				guild_full = "Your guild is full",
				invite_cooldown = "Slow down \226\128\148 wait a few seconds",
				already_invited_recently = "You already invited them recently",
				target_not_in_server = "They need to be in this server"
			})[v1] or (if v1 == "" or not v1 then "Could not invite" else v1), false, 4)
		end)
	end
end

local t3 = {}

local function findSiblingPrompt(p1, p2) --[[ findSiblingPrompt | Line: 316 ]]
	local v1 = p1.Parent

	if not v1 then
		return nil
	end

	local v2 = v1:FindFirstChild(p2)

	if v2 and v2:IsA("ProximityPrompt") then
		return v2
	end

	return nil
end

local function ensureSocialPrompts(p1) --[[ ensureSocialPrompts | Line: 326 | Upvalues: v11 (copy), v12 (copy) ]]
	local v1 = p1.Parent

	if not v1 then
		return nil, nil
	end

	local v2 = p1.Parent
	local v3

	if v2 then
		local GardenSignFriend = v2:FindFirstChild("GardenSignFriend")

		v3 = if GardenSignFriend and GardenSignFriend:IsA("ProximityPrompt") then GardenSignFriend else nil
	else
		v3 = nil
	end

	if not v3 then
		local GardenSignFriend = Instance.new("ProximityPrompt")

		GardenSignFriend.Name = "GardenSignFriend"
		GardenSignFriend.Style = Enum.ProximityPromptStyle.Custom
		GardenSignFriend.ActionText = "Add Friend"
		GardenSignFriend.ObjectText = ""
		GardenSignFriend.KeyboardKeyCode = Enum.KeyCode.E
		GardenSignFriend.GamepadKeyCode = Enum.KeyCode.ButtonX
		GardenSignFriend.UIOffset = v11
		GardenSignFriend.RequiresLineOfSight = false
		GardenSignFriend.Enabled = false
		GardenSignFriend.Parent = v1
		v3 = GardenSignFriend
	end

	local v4 = p1.Parent
	local v5

	if v4 then
		local GardenSignInvite = v4:FindFirstChild("GardenSignInvite")

		v5 = if GardenSignInvite and GardenSignInvite:IsA("ProximityPrompt") then GardenSignInvite else nil
	else
		v5 = nil
	end

	if not v5 then
		local GardenSignInvite = Instance.new("ProximityPrompt")

		GardenSignInvite.Name = "GardenSignInvite"
		GardenSignInvite.Style = Enum.ProximityPromptStyle.Custom
		GardenSignInvite.ActionText = "Invite To Guild"
		GardenSignInvite.ObjectText = ""
		GardenSignInvite.KeyboardKeyCode = Enum.KeyCode.F
		GardenSignInvite.GamepadKeyCode = Enum.KeyCode.ButtonY
		GardenSignInvite.UIOffset = v12
		GardenSignInvite.RequiresLineOfSight = false
		GardenSignInvite.Enabled = false
		GardenSignInvite.Parent = v1
		v5 = GardenSignInvite
	end

	return v3, v5
end

local function bindSocialPromptTriggers(p1, p2, p3) --[[ bindSocialPromptTriggers | Line: 363 | Upvalues: t3 (copy), LocalPlayer (copy), CurrentCamera (copy), getPlotOwner (copy), getPromptPlotId (copy), NotificationController (copy), fireGuildInvite (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	if not v1.FriendTriggered then
		v1.FriendTriggered = p2.Triggered:Connect(function() --[[ Line: 368 | Upvalues: LocalPlayer (ref), CurrentCamera (ref), getPlotOwner (ref), getPromptPlotId (ref), p1 (copy) ]]
			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChild("Humanoid")

			if not Humanoid then
				return
			end

			if CurrentCamera.CameraSubject ~= Humanoid then
				return
			end

			local v1 = getPlotOwner((getPromptPlotId(p1)))

			if not v1 then
				return
			end

			game.StarterGui:SetCore("PromptSendFriendRequest", v1)
		end)
	end

	if v1.InviteTriggered then
		return
	end

	v1.InviteTriggered = p3.Triggered:Connect(function() --[[ Line: 383 | Upvalues: LocalPlayer (ref), CurrentCamera (ref), getPlotOwner (ref), getPromptPlotId (ref), p1 (copy), NotificationController (ref), fireGuildInvite (ref) ]]
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if not Humanoid then
			return
		end

		if CurrentCamera.CameraSubject ~= Humanoid then
			return
		end

		local v1 = getPlotOwner((getPromptPlotId(p1)))

		if not v1 then
			return
		end

		if v1:GetAttribute("GuildId") then
			NotificationController:CreateNotification("They\'re already in a guild", false, 4)

			return
		end

		fireGuildInvite(v1.UserId)
	end)
end

local function updateThemePromptVisibility() --[[ updateThemePromptVisibility | Line: 406 | Upvalues: LocalPlayer (copy), Gardens (copy), getPromptPlotId (copy), getPlotOwner (copy) ]]
	local v2 = tonumber(LocalPlayer:GetAttribute("PlotId"))
	local v3 = LocalPlayer:GetAttribute("OfflineCutscenePlaying") == true
	local v4 = LocalPlayer:GetAttribute("GuildRole")
	local v5 = if typeof(v4) == "string" then if v4 == "Owner" then true elseif v4 == "Elder" then true else false else false

	for v8, v9 in Gardens:GetDescendants() do
		local v6, v7

		if v9:IsA("ProximityPrompt") and (if v9.Name == "CustomiseTheme" then true elseif v9.ActionText == "Customise Theme" then true else false) then
			local v11 = getPromptPlotId(v9)
			local v12 = v9.Parent

			if v12 then
				local GardenSignFriend = v12:FindFirstChild("GardenSignFriend")

				v6 = if GardenSignFriend and GardenSignFriend:IsA("ProximityPrompt") then GardenSignFriend else nil
			else
				v6 = nil
			end

			local v13 = v9.Parent

			if v13 then
				local GardenSignInvite = v13:FindFirstChild("GardenSignInvite")

				v7 = if GardenSignInvite and GardenSignInvite:IsA("ProximityPrompt") then GardenSignInvite else nil
			else
				v7 = nil
			end

			if v3 or v2 == nil then
				v9.Enabled = false

				if v6 then
					v6.Enabled = false
				end

				if v7 then
					v7.Enabled = false
				end

				continue
			end

			if v11 == v2 then
				v9.Enabled = true
				v9.ActionText = "Edit"
				v9.ObjectText = "Garden"

				if v6 then
					v6.Enabled = false
				end

				if v7 then
					v7.Enabled = false
				end

				continue
			end

			v9.Enabled = false

			local v14 = getPlotOwner(v11)

			if v14 and (v6 and v7) then
				v6.Enabled = true
				v6.ObjectText = v14.DisplayName
				v7.Enabled = if v5 then if v14:GetAttribute("GuildId") == nil then true else false else v5
				v7.ObjectText = v14.DisplayName

				continue
			end

			if v6 then
				v6.Enabled = false
			end

			if v7 then
				v7.Enabled = false
			end
		end
	end
end

local function bindSinglePrompt(p1) --[[ bindSinglePrompt | Line: 443 | Upvalues: t3 (copy), LocalPlayer (copy), CurrentCamera (copy), getPromptPlotId (copy), GuiController (copy), v10 (copy), ensureSocialPrompts (copy), bindSocialPromptTriggers (copy) ]]
	if t3[p1] then
		return
	end

	t3[p1] = {
		FriendTriggered = nil,
		InviteTriggered = nil,
		ThemeTriggered = p1.Triggered:Connect(function() --[[ Line: 446 | Upvalues: LocalPlayer (ref), CurrentCamera (ref), getPromptPlotId (ref), p1 (copy), GuiController (ref), v10 (ref) ]]
			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChild("Humanoid")

			if not Humanoid then
				return
			end

			if CurrentCamera.CameraSubject ~= Humanoid then
				return
			end

			if tonumber(LocalPlayer:GetAttribute("PlotId")) ~= getPromptPlotId(p1) then
				return
			end

			GuiController:Open("CustomiseFenceTheme")
			v10()
		end)
	}

	local v1, v2 = ensureSocialPrompts(p1)

	if not (v1 and v2) then
		return
	end

	bindSocialPromptTriggers(p1, v1, v2)
end

local function unbindPrompt(p1) --[[ unbindPrompt | Line: 473 | Upvalues: t3 (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	v1.ThemeTriggered:Disconnect()

	if v1.FriendTriggered then
		v1.FriendTriggered:Disconnect()
	end

	if not v1.InviteTriggered then
		t3[p1] = nil

		return
	end

	v1.InviteTriggered:Disconnect()
	t3[p1] = nil
end

for v14, v15 in Gardens:GetDescendants() do
	if v15:IsA("ProximityPrompt") and (if v15.Name == "CustomiseTheme" then true elseif v15.ActionText == "Customise Theme" then true else false) then
		bindSinglePrompt(v15)
	end
end

Gardens.DescendantAdded:Connect(function(p1) --[[ Line: 490 | Upvalues: bindSinglePrompt (copy), updateThemePromptVisibility (copy) ]]
	if not (p1:IsA("ProximityPrompt") and (if p1.Name == "CustomiseTheme" then true elseif p1.ActionText == "Customise Theme" then true else false)) then
		return
	end

	bindSinglePrompt(p1)
	updateThemePromptVisibility()
end)
Gardens.DescendantRemoving:Connect(function(p1) --[[ Line: 498 | Upvalues: t3 (copy) ]]
	if not (p1:IsA("ProximityPrompt") and t3[p1]) then
		return
	end

	local v1 = t3[p1]

	if not v1 then
		return
	end

	v1.ThemeTriggered:Disconnect()

	if v1.FriendTriggered then
		v1.FriendTriggered:Disconnect()
	end

	if v1.InviteTriggered then
		v1.InviteTriggered:Disconnect()
	end

	t3[p1] = nil
end)
LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(updateThemePromptVisibility)
LocalPlayer:GetAttributeChangedSignal("GuildRole"):Connect(updateThemePromptVisibility)

local function watchPlayerPlotId(p1) --[[ watchPlayerPlotId | Line: 512 | Upvalues: updateThemePromptVisibility (copy) ]]
	p1:GetAttributeChangedSignal("PlotId"):Connect(updateThemePromptVisibility)
end

for v17, v18 in Players:GetPlayers() do
	if v18 ~= LocalPlayer then
		v18:GetAttributeChangedSignal("PlotId"):Connect(updateThemePromptVisibility)
	end
end

Players.PlayerAdded:Connect(function(p1) --[[ Line: 522 | Upvalues: updateThemePromptVisibility (copy) ]]
	p1:GetAttributeChangedSignal("PlotId"):Connect(updateThemePromptVisibility)
	updateThemePromptVisibility()
end)
Players.PlayerRemoving:Connect(updateThemePromptVisibility)

if v9 then
	v9:OnSet({ "OwnedFenceSkins" }, function() --[[ Line: 531 | Upvalues: GuiController (copy), v10 (copy) ]]
		if not GuiController:IsOpen("CustomiseFenceTheme") then
			return
		end

		v10()
	end)
end

FenceThemes.ChildAdded:Connect(function() --[[ Line: 539 | Upvalues: GuiController (copy), v10 (copy) ]]
	if not GuiController:IsOpen("CustomiseFenceTheme") then
		return
	end

	v10()
end)
FenceThemes.ChildRemoved:Connect(function() --[[ Line: 544 | Upvalues: GuiController (copy), v10 (copy) ]]
	if not GuiController:IsOpen("CustomiseFenceTheme") then
		return
	end

	v10()
end)

for k, v in pairs(tbl) do
	v.Activated:Connect(function() --[[ Line: 552 | Upvalues: GuiController (copy) ]]
		if not GuiController:IsOpen("CustomiseFenceTheme") then
			return
		end

		GuiController:Close()
	end)
end

LocalPlayer:GetAttributeChangedSignal("OfflineCutscenePlaying"):Connect(updateThemePromptVisibility)
updateThemePromptVisibility()