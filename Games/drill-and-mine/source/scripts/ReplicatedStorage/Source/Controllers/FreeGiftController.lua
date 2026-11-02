-- Client side of the free "like + join group" reward (GUI.Folder.FreeGiftFrame).
-- The HUD chip (HUD.RightSide.FreeGift.BuyButton, Toggle attribute) already
-- opens the frame through FrameAnimator; this controller wires the Claim
-- button, shows the success / "join the group" toasts and hides the HUD chip
-- once the reward has been claimed.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GroupService = game:GetService("GroupService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local FreeGiftController = {}

local player = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GiftRemotes = Remotes:WaitForChild("FreeGiftService")
local ClaimFunc = GiftRemotes:WaitForChild("Claim")
local RequestDataFunc = GiftRemotes:WaitForChild("RequestData")
local DataUpdateEvent = GiftRemotes:WaitForChild("DataUpdate")

local frame = nil
local chip = nil
local claiming = false

local function getNotifications()
	local ok, controller = pcall(function()
		return require(ReplicatedStorage.Source.Controllers.NotificationsController)
	end)
	if ok then return controller end
	return nil
end

local function formatCash(amount)
	local formatted = tostring(amount)
	repeat
		local replaced
		formatted, replaced = formatted:gsub("^(%d+)(%d%d%d)", "%1,%2")
	until replaced == 0
	return formatted
end

local function closeFrame()
	if not frame or not frame.Visible then return end
	local ok, FrameAnimator = pcall(function()
		return require(ReplicatedStorage.Source.Modules.FrameAnimator)
	end)
	if ok and FrameAnimator then
		FrameAnimator:Close(frame)
	else
		frame.Visible = false
	end
end

local function applyState(payload)
	if type(payload) ~= "table" then return end
	if chip then
		chip.Visible = payload.Claimed ~= true
	end
end

local function invokeClaim()
	return pcall(function()
		return ClaimFunc:InvokeServer()
	end)
end

local function onClaimClicked()
	if claiming then return end
	claiming = true
	local ok, result = invokeClaim()

	local notifications = getNotifications()

	-- Not in the group yet: pop the native Roblox community-join dialog
	-- (GroupService:PromptJoinAsync, client-only, yields until the player
	-- answers) and re-claim automatically when they join through it.
	local failReason = ok and type(result) == "table" and result.Reason or nil
	if failReason == "NotInGroup" then
		local groupId = (GameConfig.Group and GameConfig.Group.GroupId) or 0
		local status = nil
		if groupId ~= 0 then
			local okPrompt, promptStatus = pcall(function()
				return GroupService:PromptJoinAsync(groupId)
			end)
			if okPrompt then status = promptStatus end
		end
		if status == Enum.GroupMembershipStatus.Joined
			or status == Enum.GroupMembershipStatus.AlreadyMember then
			-- freshly joined: the server re-checks membership with a live
			-- GetGroupsAsync lookup, but give the backend a couple of beats
			-- to propagate before giving up
			for attempt = 1, 3 do
				ok, result = invokeClaim()
				if ok and type(result) == "table"
					and (result.Success or result.Reason ~= "NotInGroup") then
					break
				end
				if attempt < 3 then task.wait(attempt) end
			end
		elseif status == Enum.GroupMembershipStatus.JoinRequestPending then
			if notifications then
				notifications.SendRed("Join request sent! Claim once you're accepted.")
			end
			claiming = false
			return
		end
	end
	claiming = false
	if ok and type(result) == "table" and result.Success then
		if notifications then
			notifications.SendGreen(("You claimed $%s!"):format(formatCash(result.Amount or 0)))
		end
		-- celebrate like a rebirth: firework ring around the player; the
		-- module plays its own sound full-length
		local okFw, FireworkModule = pcall(function()
			return require(ReplicatedStorage.Source.Modules.FireworkModule)
		end)
		if okFw and FireworkModule then
			FireworkModule.PlayAtPlayer()
		end
		if chip then chip.Visible = false end
		closeFrame()
		return
	end

	local reason = ok and type(result) == "table" and result.Reason or nil
	if notifications then
		if reason == "NotInGroup" then
			local groupName = (GameConfig.Group and GameConfig.Group.Name) or "the group"
			notifications.SendRed(("Join the %s group on Roblox to claim!"):format(groupName))
		elseif reason == "AlreadyClaimed" then
			notifications.SendRed("You already claimed this reward!")
		else
			notifications.SendRed("Couldn't claim right now, try again!")
		end
	end
end

function FreeGiftController.Init()
	local playerGui = player:WaitForChild("PlayerGui")
	local gui = playerGui:WaitForChild("GUI")
	local folder = gui:WaitForChild("Folder", 10)
	frame = folder and folder:WaitForChild("FreeGiftFrame", 10)
	if not frame then return end

	local claimButton = frame:WaitForChild("ClaimButton", 10)

	local hud = gui:FindFirstChild("HUD")
	local rightSide = hud and hud:FindFirstChild("RightSide")
	chip = rightSide and rightSide:FindFirstChild("FreeGift")

	DataUpdateEvent.OnClientEvent:Connect(applyState)

	if claimButton then
		claimButton.MouseButton1Click:Connect(onClaimClicked)
	end

	task.spawn(function()
		local ok, payload = pcall(function()
			return RequestDataFunc:InvokeServer()
		end)
		if ok then
			applyState(payload)
		end
	end)
end

return FreeGiftController
