--------|     Setting     |--------
local logTypeImages = {
	Ban = "rbxassetid://2565271176",
	Unban = "rbxassetid://2570781919",
	Warn = "rbxassetid://2565271614",
}
local membershipSubString = {
	Premium = "Premium",
	None = "None",
}

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------
local GUI = {
	Gui = script.Parent,
	Frame = script.Parent:WaitForChild("Frame"),
	Content = script.Parent:WaitForChild("Frame"):WaitForChild("Content"),
	Search = script.Parent:WaitForChild("Frame"):WaitForChild("Search"),
	Player = script.Parent:WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Player"),
	Recent = script.Parent:WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Recent"),
	Keybind = script.Parent:WaitForChild("Keybind"),
}
local luaDate = require(script.LuaDate)

--------|    Variables    |--------
local clickDeb = false
local open = false
local navigationButtonEvents = {}
local actionButtonEvents = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function LoadProfile(userId)
	local profile = _L.Network.Invoke("ModeratorUtil", "GetProfile", userId)
	if profile == nil then  return "Error"  end
	
	local baseOSTime = _L.Network.Invoke("ModeratorUtil", "GetOSTime")
	---
	for i = 1, #actionButtonEvents do
		actionButtonEvents[i]:disconnect()
	end
	actionButtonEvents = {}
	---
	coroutine.wrap(function()
		local username = _L.Functions.UserIdToUsername(userId)
		if username then
			GUI.Player.Title.Text = username
		else
			GUI.Player.Title.Text =  "(Unknown)"
		end
	end)()
	GUI.Player.Title.Text = GUI.Player.Title.Text .. "'s History"
	GUI.Player.Data.Age.Text = "Account Age - " .. _L.Functions.Commas(tonumber(profile.AccountAge)) .. " Days"
	GUI.Player.Data.Gamepasses.Text = "Gamepasses - " .. _L.Functions.Commas(tonumber(profile.Gamepasses))
	GUI.Player.Data.Membership.Text = "Membership - " .. membershipSubString[string.sub(profile.Membership, 21)] or "Unknown (None)"
	
	if profile.Spent ~= nil then
		GUI.Player.Data.Spent.Text = "Robux Spent - " .. _L.Functions.Commas(tonumber(profile.Spent))
		GUI.Player.Data.Spent.Visible = true
	else
		GUI.Player.Data.Spent.Visible = false
	end
	
	if profile.Paid ~= nil then
		if profile.Paid then
			GUI.Player.Data.Paid.Text = "Not a Paid Player"
			GUI.Player.Data.Paid.TextColor3 = Color3.fromRGB(255, 90, 90)
		else
			GUI.Player.Data.Paid.Text = "Paid Player"
			GUI.Player.Data.Paid.TextColor3 = Color3.fromRGB(105, 255, 88)
		end
		GUI.Player.Data.Paid.Visible = true
	else
		GUI.Player.Data.Paid.Visible = false
	end
	
	---
	if profile.IsBanned then
		GUI.Player.Data.Status.Text = "Status - Banned"
		GUI.Player.Data.Status.TextColor3 = Color3.fromRGB(236, 26, 26)
	elseif profile.IsWarned then
		GUI.Player.Data.Status.Text = "Status - Warned"
		GUI.Player.Data.Status.TextColor3 = Color3.fromRGB(228, 211, 20)
	else
		GUI.Player.Data.Status.Text = "Status - Clean"
		GUI.Player.Data.Status.TextColor3 = Color3.fromRGB(105, 255, 88)
	end
	---
	local timePassedSinceLastSeen = (baseOSTime - profile.LastUpdate)
	GUI.Player.Data.Seen.Text = "Last Seen - " .. _L.Functions.TimeString(timePassedSinceLastSeen)
	---
	GUI.Player.Portrait.Image = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size180x180)
	---
	local function LoadProfileHistory()
		GUI.Player.History:ClearAllChildren()
		---
		for _, log in ipairs(profile.History) do
			local logType = log.type
			local logReason = log.reason
			local logModeratorId = log.moderator
			local logDate = log.date
			local logTimePassed = (baseOSTime - logDate)
			--
			local logGui = script.ProfileLog:Clone()
			logGui.Reason.Text = string.upper(logType) .. " - " .. logReason
			logGui.Type.Image = logTypeImages[logType]
			logGui.TimePassed.Text = _L.Functions.TimeString(logTimePassed) .. " ago"
			--
			if logType == "Ban" then
				logGui.Reason.TextColor3 = Color3.fromRGB(236, 26, 26)
			elseif logType == "Warn" then
				logGui.Reason.TextColor3 = Color3.fromRGB(228, 211, 20)
			elseif logType == "Unban" then
				logGui.Reason.TextColor3 = Color3.fromRGB(105, 255, 88)
			end
			--
			coroutine.wrap(function()	
				local username = _L.Functions.UserIdToUsername(logModeratorId)
				if username then
					logGui.Moderator.Text = username
				else
					logGui.Moderator.Text = "(Unknown)"
				end
			end)()
			--
			logGui.LayoutOrder = logTimePassed
			logGui.Parent = GUI.Player.History
		end
		--- padding
		local padding = GUI.Player.History:FindFirstChild("%%Padding")
		if padding == nil then
			padding = Instance.new("UIPadding")
			padding.Name = "%%Padding"
			padding.PaddingRight = UDim.new(0, GUI.Player.History.ScrollBarThickness)
			padding.Parent = GUI.Player.History
		end
		--- layout
		local listLayout = GUI.Player.History:FindFirstChild("%%Layout")
		if listLayout == nil then
			listLayout = script.RecentLayout:Clone()
			listLayout.Name = "%%Layout"
			listLayout.Parent = GUI.Player.History
			coroutine.wrap(function()
				while (listLayout and listLayout.Parent) do
					listLayout:ApplyLayout()
					GUI.Player.History.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y+1)
					_L.Services.RunService.Stepped:wait()
				end
			end)()
		end
	end
	---
	local function GetReason()
		local reason
		local clickEvent
		--
		GUI.Player.Reason.Visible = true
		--
		clickEvent = GUI.Player.Reason.Submit.MouseButton1Click:Connect(function()
			reason = GUI.Player.Reason.Input.Text
			clickEvent:disconnect()
		end)
		--
		repeat  wait()  until GUI.Player.Reason.Visible == false or GUI.Player.Visible == false or GUI.Frame.Visible == false or reason ~= nil
		--
		GUI.Player.Reason.Visible = false
		return reason
	end
	---
	local function PerformAction(action)
		local reason = GetReason()
		if reason and reason ~= "" then
			local areYouSure = _L.Message.New("Are you sure?", true)
			if areYouSure then
				local success = _L.Network.Invoke("ModeratorUtil", action, userId, game.Players.LocalPlayer.UserId, reason)
				if success then
					_L.Message.New("Success!")
					LoadProfile(userId)
				else
					_L.Message.New("Failed!")
				end
			end
		elseif reason == nil or reason == "" then
			_L.Message.New("Reason cannot be blank")
		end
	end
	---
	actionButtonEvents[#actionButtonEvents + 1] = GUI.Player.Ban.MouseButton1Click:Connect(function()
		if clickDeb == false then
			clickDeb = true
			PerformAction("Ban")
			clickDeb = false
		end
	end)
	actionButtonEvents[#actionButtonEvents + 1] = GUI.Player.Clear.MouseButton1Click:Connect(function()
		if clickDeb == false then
			clickDeb = true
			PerformAction("Clear")
			clickDeb = false
		end
	end)
	actionButtonEvents[#actionButtonEvents + 1] = GUI.Player.Warn.MouseButton1Click:Connect(function()
		if clickDeb == false then
			clickDeb = true
			PerformAction("Warn")
			clickDeb = false
		end
	end)
	---
	LoadProfileHistory()
	---
	SwitchWindow("Player")
end


function LoadRecent(pageNum)
	local page = _L.Network.Invoke("ModeratorUtil", game.Players.LocalPlayer.UserId  , "GetList", pageNum)
	---
	GUI.Recent.Content:ClearAllChildren()
	for i = 1, #navigationButtonEvents do
		navigationButtonEvents[i]:disconnect()
	end
	navigationButtonEvents = {}
	---
	--[[if page == nil then
		return
	end]]
	for i, log in ipairs(page) do
		local logType = log.t
		local logTimePassed = log.tp
		local logDate = log.d
		local logModId = log.m
		local logVictimId = log.v
		--
		local logGui = script.RecentLog:Clone()
		logGui.Type.Image = logTypeImages[logType]
		logGui.TimePassed.Text = _L.Functions.TimeString(logTimePassed) .. " ago"
		--
		local date = luaDate(logDate)
		logGui.Date.Text = date:fmt("%c GMT%z")
		--
		coroutine.wrap(function()
			local username = _L.Functions.UserIdToUsername(logVictimId)
			if logGui and logGui:FindFirstChild("Username") then
				if username then
					logGui.Username.Text = username
				else
					logGui.Username.Text =  "(Unknown)"
				end
			end
		end)()
		--
		coroutine.wrap(function()
			local username = _L.Functions.UserIdToUsername(logModId)
			if logGui and logGui:FindFirstChild("Username") then
				if username then
					logGui.Moderator.Text = logType .. " from: " .. username
				else
					logGui.Moderator.Text = logType .. " from: (Unknown)"
				end
			end
		end)()
		--
		logGui.Details.MouseButton1Click:Connect(function()
			if clickDeb == false then
				clickDeb = true
				LoadProfile(logVictimId)
				clickDeb = false
			end
		end)
		logGui.LayoutOrder = logTimePassed
		logGui.Parent = GUI.Recent.Content
	end
	--- padding
	local padding = GUI.Recent.Content:FindFirstChild("%%Padding")
	if padding == nil then
		padding = Instance.new("UIPadding")
		padding.Name = "%%Padding"
		padding.PaddingRight = UDim.new(0, GUI.Recent.Content.ScrollBarThickness)
		padding.Parent = GUI.Recent.Content
	end
	--- layout
	local listLayout = GUI.Recent.Content:FindFirstChild("%%Layout")
	if listLayout == nil then
		listLayout = script.RecentLayout:Clone()
		listLayout.Name = "%%Layout"
		listLayout.Parent = GUI.Recent.Content
		coroutine.wrap(function()
			while (listLayout and listLayout.Parent) do
				listLayout:ApplyLayout()
				GUI.Recent.Content.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y+1)
				_L.Services.RunService.Stepped:wait()
			end
		end)()
	end
	---
	GUI.Recent.Page.Text = "Page " .. pageNum
	navigationButtonEvents[#navigationButtonEvents + 1] = GUI.Recent.Forward.MouseButton1Click:Connect(function()
		if clickDeb == false then
			clickDeb = true
			LoadRecent(pageNum + 1)
			clickDeb = false
		end
	end)
	navigationButtonEvents[#navigationButtonEvents + 1] = GUI.Recent.ForwardFast.MouseButton1Click:Connect(function()
		if clickDeb == false then
			clickDeb = true
			LoadRecent(pageNum + 3)
			clickDeb = false
		end
	end)
	if pageNum > 1 then
		navigationButtonEvents[#navigationButtonEvents + 1] = GUI.Recent.Back.MouseButton1Click:Connect(function()
			if clickDeb == false then
				clickDeb = true
				LoadRecent(pageNum - 1)
				clickDeb = false
			end
		end)
		navigationButtonEvents[#navigationButtonEvents + 1] = GUI.Recent.BackFast.MouseButton1Click:Connect(function()
			if clickDeb == false then
				clickDeb = true
				LoadRecent(math.max(pageNum - 3, 1))
				clickDeb = false
			end
		end)
	end
	---
	SwitchWindow("Recent")
end


------------------------------------------------------------------------------


function SwitchWindow(window)
	for _, otherWIndow in ipairs(GUI.Content:GetChildren()) do
		if otherWIndow.ClassName == "Frame" then
			otherWIndow.Visible = false
		end
	end
	---
	GUI[window].Visible = true
end


function ToggleOpen()
	open = not open
	GUI.Frame.Visible = open
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


GUI.Search:WaitForChild("Go").MouseButton1Click:Connect(function()
	if not clickDeb then
		clickDeb = true
		local searchField = GUI.Search.Field.Text
		if searchField ~= "" then
			local userId
			local success = pcall(function()
				userId = game.Players:GetUserIdFromNameAsync(searchField)
			end)
			if success and userId then
				if LoadProfile(userId) == "Error" then
					_L.Message.New("Failed to fetch " .. searchField .. "'s history")
				end
			else
				_L.Message.New("Username does not exist")
			end
		else
			_L.Message.New("Enter username first")
		end
		clickDeb = false
	end
end)


GUI.Player:WaitForChild("Back").MouseButton1Click:Connect(function()
	--if not clickDeb then
	--	clickDeb = true
		SwitchWindow("Recent")
		--clickDeb = false
	--end
end)


game:GetService("UserInputService").InputBegan:connect(function(input, event)
	if input.KeyCode == Enum.KeyCode.F8 then
		ToggleOpen()
	end
end)


GUI.Keybind.MouseButton1Click:Connect(function()
	ToggleOpen()
end)


------------------------------------------------------------------------------

--- Console selection locks up. Not needed!
if _L.Variables.Console then
	script.Parent:Destroy()
	return
end

--- Load
LoadRecent(1)

