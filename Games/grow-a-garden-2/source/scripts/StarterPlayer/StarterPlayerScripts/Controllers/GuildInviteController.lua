--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local t = {
	not_in_guild = "You\'re not in a guild",
	no_invite_permission = "Only Owners and Elders can invite",
	already_member = "They\'re already in your guild",
	target_in_guild = "They\'re already in a guild",
	guild_full = "Your guild is full",
	invite_cooldown = "Slow down -- wait a few seconds",
	already_invited_recently = "You already invited them recently",
	target_not_in_server = "They need to be in this server"
}
local t2 = {
	StartOrder = 9
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = false
local t3 = {}
local t4 = {}

local function trackRowConn(p1) --[[ trackRowConn | Line: 48 | Upvalues: t3 (copy) ]]
	table.insert(t3, p1)
end

local function clearRows() --[[ clearRows | Line: 52 | Upvalues: t3 (copy), t4 (copy) ]]
	for v1, v2 in t3 do
		pcall(function() --[[ Line: 54 | Upvalues: v2 (copy) ]]
			v2:Disconnect()
		end)
	end

	table.clear(t3)

	for v3, v4 in t4 do
		if v4.Parent then
			v4:Destroy()
		end
	end

	table.clear(t4)
end

local function setNameChain(p1, p2) --[[ setNameChain | Line: 65 ]]
	p1.Text = p2

	local GuildTextLabelName2 = p1:FindFirstChild("GuildTextLabelName2")

	if not (GuildTextLabelName2 and GuildTextLabelName2:IsA("TextLabel")) then
		return
	end

	GuildTextLabelName2.Text = p2
end

local function applyHeadshot(p1, p2) --[[ applyHeadshot | Line: 73 | Upvalues: Players (copy) ]]
	task.spawn(function() --[[ Line: 74 | Upvalues: Players (ref), p2 (copy), p1 (copy) ]]
		local ok, result = pcall(function() --[[ Line: 75 | Upvalues: Players (ref), p2 (ref) ]]
			return Players:GetUserThumbnailAsync(p2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		end)

		if not ok or (typeof(result) ~= "string" or not p1.Parent) then
			return
		end

		p1.Image = result
	end)
end

local function sendInvite(p1, p2) --[[ sendInvite | Line: 88 | Upvalues: Networking (copy), NotificationController (copy), t (copy) ]]
	p2.Active = false

	if p2:IsA("TextButton") or p2:IsA("ImageButton") then
		p2.AutoButtonColor = false
	end

	task.spawn(function() --[[ Line: 93 | Upvalues: Networking (ref), p1 (copy), NotificationController (ref), p2 (copy), t (ref) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 94 | Upvalues: Networking (ref), p1 (ref) ]]
			return Networking.Guild.Invite:Fire(p1)
		end)

		if not ok then
			NotificationController:CreateNotification("Try again")
		else
			if result then
				NotificationController:CreateNotification("Guild invite sent!")

				return
			end

			local v1 = tostring(result2 or "")

			NotificationController:CreateNotification(t[v1] or (if v1 == "" or not v1 then "Could not invite" else v1))
		end

		p2.Active = true
	end)
end

local function fetchMemberSet() --[[ fetchMemberSet | Line: 120 | Upvalues: Networking (copy) ]]
	local t = {}
	local ok, result = pcall(function() --[[ Line: 122 | Upvalues: Networking (ref) ]]
		return Networking.Guild.GetMyGuild:Fire()
	end)

	if ok and typeof(result) == "table" and (typeof(result.Guild) == "table" and typeof(result.Guild.Members) == "table") then
		for v1 in result.Guild.Members do
			local v2 = tonumber(v1)

			if v2 then
				t[v2] = true
			end
		end
	end

	return t
end

local function renderRow(p1, p2, p3) --[[ renderRow | Line: 136 | Upvalues: t4 (copy), Players (copy), sendInvite (copy), t3 (copy) ]]
	local v1 = p1:Clone()

	v1.Name = ("Player_%*"):format(p3.UserId)
	v1.LayoutOrder = #t4 + 1
	v1.Visible = true
	v1.Parent = p2
	table.insert(t4, v1)

	local PlayerName = v1:FindFirstChild("PlayerName")

	if PlayerName and PlayerName:IsA("TextLabel") then
		local DisplayName = p3.DisplayName

		PlayerName.Text = DisplayName

		local GuildTextLabelName2 = PlayerName:FindFirstChild("GuildTextLabelName2")

		if GuildTextLabelName2 and GuildTextLabelName2:IsA("TextLabel") then
			GuildTextLabelName2.Text = DisplayName
		end
	end

	local PlayerImage = v1:FindFirstChild("PlayerImage")
	local v3 = PlayerImage and PlayerImage:FindFirstChild("Icon")

	if v3 and v3:IsA("ImageLabel") then
		local UserId = p3.UserId

		task.spawn(function() --[[ Line: 74 | Upvalues: Players (ref), UserId (copy), v3 (copy) ]]
			local ok, result = pcall(function() --[[ Line: 75 | Upvalues: Players (ref), UserId (ref) ]]
				return Players:GetUserThumbnailAsync(p2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			if not ok or (typeof(result) ~= "string" or not v3.Parent) then
				return
			end

			v3.Image = result
		end)
	end

	local InviteButton = v1:FindFirstChild("InviteButton")

	if not (InviteButton and InviteButton:IsA("GuiButton")) then
		return
	end

	local v4 = InviteButton.MouseButton1Click:Connect(function() --[[ Line: 157 | Upvalues: sendInvite (ref), p3 (copy), InviteButton (copy) ]]
		sendInvite(p3.UserId, InviteButton)
	end)

	table.insert(t3, v4)
end

local function populate() --[[ populate | Line: 163 | Upvalues: v6 (ref), v2 (ref), v3 (ref), clearRows (copy), fetchMemberSet (copy), Players (copy), LocalPlayer (copy), renderRow (copy), v4 (ref) ]]
	if not v6 then
		return
	end

	if not (v2 and v3) then
		return
	end

	local v1 = v2
	local v22 = v3

	clearRows()

	local v32 = fetchMemberSet()

	if not v6 then
		return
	end

	local count = 0

	for v42, v5 in Players:GetPlayers() do
		if v5 ~= LocalPlayer and not (v32[v5.UserId] or v5:GetAttribute("GuildId")) then
			renderRow(v22, v1, v5)
			count = count + 1
		end
	end

	if v4 then
		v4.Visible = count == 0
	end

	v1.Visible = if count > 0 then true else false
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 191 | Upvalues: v5 (ref), v4 (ref), v2 (ref), v3 (ref) ]]
	local Frame = p1:FindFirstChild("Frame")

	if not Frame then
		return
	end

	local Header = Frame:FindFirstChild("Header")

	if Header then
		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v5 = ExitButton
		end
	end

	local v1 = Frame:FindFirstChild("Content")

	if not v1 then
		return
	end

	local StatusLabel = v1:FindFirstChild("StatusLabel")

	if StatusLabel and StatusLabel:IsA("TextLabel") then
		v4 = StatusLabel
	end

	local ScrollingFrame = v1:FindFirstChild("ScrollingFrame")

	if not (ScrollingFrame and ScrollingFrame:IsA("ScrollingFrame")) then
		return
	end

	v2 = ScrollingFrame

	local PlayerTemplate = ScrollingFrame:FindFirstChild("PlayerTemplate")

	if not (PlayerTemplate and PlayerTemplate:IsA("GuiObject")) then
		return
	end

	v3 = PlayerTemplate
	PlayerTemplate.Visible = false
end

local function BindButtons() --[[ BindButtons | Line: 218 | Upvalues: v5 (ref), GuiController (copy) ]]
	if not v5 then
		return
	end

	v5.MouseButton1Click:Connect(function() --[[ Line: 220 | Upvalues: GuiController (ref) ]]
		if not GuiController:IsOpen("GuildInvite") then
			return
		end

		GuiController:Open("ViewGuildPage", nil, { "HUD" })

		if not GuiController:IsOpen("GuildInvite") then
			return
		end

		GuiController:Close()
	end)
end

function t2.Init(p1) --[[ Init | Line: 232 ]] end
function t2.Start(p1) --[[ Start | Line: 234 | Upvalues: PlayerGui (copy), v1 (ref), ResolveRefs (copy), v5 (ref), GuiController (copy), v6 (ref), populate (copy), clearRows (copy), Players (copy) ]]
	task.spawn(function() --[[ Line: 235 | Upvalues: PlayerGui (ref), v1 (ref), ResolveRefs (ref), v5 (ref), GuiController (ref), v6 (ref), populate (ref), clearRows (ref), Players (ref) ]]
		local GuildInvite = PlayerGui:WaitForChild("GuildInvite", 30)

		if not (GuildInvite and GuildInvite:IsA("ScreenGui")) then
			return
		end

		v1 = GuildInvite
		GuildInvite.Enabled = false
		ResolveRefs(GuildInvite)

		if v5 then
			v5.MouseButton1Click:Connect(function() --[[ Line: 220 | Upvalues: GuiController (ref) ]]
				if not GuiController:IsOpen("GuildInvite") then
					return
				end

				GuiController:Open("ViewGuildPage", nil, { "HUD" })

				if not GuiController:IsOpen("GuildInvite") then
					return
				end

				GuiController:Close()
			end)
		end

		GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 245 | Upvalues: GuildInvite (copy), v6 (ref), populate (ref) ]]
			if p1 ~= GuildInvite then
				return
			end

			v6 = true
			populate()
		end)
		GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 251 | Upvalues: GuildInvite (copy), v6 (ref), clearRows (ref) ]]
			if p1 ~= GuildInvite then
				return
			end

			v6 = false
			clearRows()
		end)
		Players.PlayerAdded:Connect(function() --[[ Line: 259 | Upvalues: v6 (ref), populate (ref) ]]
			if not v6 then
				return
			end

			populate()
		end)
		Players.PlayerRemoving:Connect(function() --[[ Line: 262 | Upvalues: v6 (ref), populate (ref) ]]
			if not v6 then
				return
			end

			task.defer(populate)
		end)
	end)
end

return t2