local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local localPlayer = Players.LocalPlayer
local friendNames = {}

local CFG = {
	CheckInterval = 30, -- Checks every 50 seconds
	TriggerChance = 20, -- 20% chance to trigger

	CreepyMessages = {
		"Run.",
		"LEAVE.",
		"It's behind you.",
		"Don't look back.",
		"Why did you come here?",
		"Help me",
		"It's here."
	},

	FallbackNames = {
		"UnknownUser",
		"Builderman",
		"TheWatcher",
		"Player"
	}
}

-- Safely fetches real friend usernames
local function fetchFriendsList()
	local success, pages = pcall(function()
		return Players:GetFriendsAsync(localPlayer.UserId)
	end)

	if success and pages then
		local names = {}
		local count = 0
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				table.insert(names, item.Username)
				count = count + 1
				if count >= 100 then break end -- Capped to prevent infinite loading on massive friend lists
			end
			if pages.IsFinished or count >= 100 then break end
			pcall(function() pages:AdvanceToNextPageAsync() end)
		end
		friendNames = names
	end
end

task.spawn(fetchFriendsList)

-- Robust sender that works with BOTH modern TextChatService and legacy Chat
local function sendFakeChatMessage(text, isSystemFormat)
	-- System check: Roblox modern TextChatService
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local textChannels = TextChatService:FindFirstChild("TextChannels")
		local generalChannel = textChannels and textChannels:FindFirstChild("RBXGeneral")

		if generalChannel then
			if isSystemFormat then
				-- Formats it as an official looking grey bold system notification
				generalChannel:DisplaySystemMessage("<font color='rgb(235, 235, 235)'><b>" .. text .. "</b></font>")
			else
				-- Formats it as standard white player text
				generalChannel:DisplaySystemMessage("<font color='rgb(255, 255, 255)'>" .. text .. "</font>")
			end
			return
		end
	end

	-- Fallback: Old Legacy Roblox Chat Engine
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = text,
			Color = isSystemFormat and Color3.fromRGB(235, 235, 235) or Color3.fromRGB(255, 255, 255),
			Font = isSystemFormat and Enum.Font.SourceSansBold or Enum.Font.SourceSansMedium,
			TextSize = 18
		})
	end)
end

-- Hidden Background Psychological Loop
while true do
	task.wait(CFG.CheckInterval)

	if math.random(1, 100) <= CFG.TriggerChance then
		local chosenName = ""
		if #friendNames > 0 then
			chosenName = friendNames[math.random(1, #friendNames)]
		else
			chosenName = CFG.FallbackNames[math.random(1, #CFG.FallbackNames)]
		end

		-- 1. Display the system join message
		sendFakeChatMessage("Your friend " .. chosenName .. " has joined the experience.", true)

		-- 2. Wait 3 to 4 seconds before the panic message hits
		task.wait(math.random(3, 4))

		-- 3. Display the mimic user message
		local randomCreepyText = CFG.CreepyMessages[math.random(1, #CFG.CreepyMessages)]
		sendFakeChatMessage(chosenName .. ": " .. randomCreepyText, false)
	end
end