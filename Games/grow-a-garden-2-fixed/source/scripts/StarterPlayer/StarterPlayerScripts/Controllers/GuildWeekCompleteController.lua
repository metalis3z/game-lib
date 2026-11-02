--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local t = {
	StartOrder = 10
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = false

local function setLabelChain(p1, p2) --[[ setLabelChain | Line: 26 ]]
	if not p1 then
		return
	end

	p1.RichText = true
	p1.Text = p2

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.RichText = true
	TextLabel.Text = p2
end

local function commaSeparate(p1) --[[ commaSeparate | Line: 37 ]]
	return tostring((math.floor(p1))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function hidePopup() --[[ hidePopup | Line: 43 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1.Enabled = false
end

local function findMostRecentGuildReward(p1) --[[ findMostRecentGuildReward | Line: 47 ]]
	local v1 = (-1 / 0)
	local v2 = nil

	for v3, v4 in p1 do
		if typeof(v4) == "table" and v4.Kind == "GuildReward" then
			local v5 = tonumber(v4.SentAt) or 0

			if v1 < v5 then
				v1 = v5
				v2 = v4
			end
		end
	end

	return v2
end

local function showPopupIfNeeded(p1) --[[ showPopupIfNeeded | Line: 62 | Upvalues: v5 (ref), v1 (ref), v2 (ref), findMostRecentGuildReward (copy) ]]
	if v5 then
		return
	end

	if typeof(p1) ~= "table" then
		return
	end

	if not (v1 and v2) then
		return
	end

	local v12 = findMostRecentGuildReward(p1)

	if not v12 then
		return
	end

	local v22 = tonumber(v12.Placement)
	local v3

	if v22 and v22 > 0 then
		local format = string.format

		v3 = format("Your guild placed #%s", (tostring((math.floor(v22))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
	else
		v3 = "Your guild placed in the contest!"
	end

	local v52 = v2

	if not v52 then
		v1.Enabled = true
		v5 = true

		return
	end

	v52.RichText = true
	v52.Text = v3

	local TextLabel = v52:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		v1.Enabled = true
		v5 = true

		return
	end

	TextLabel.RichText = true
	TextLabel.Text = v3
	v1.Enabled = true
	v5 = true
end

local function extractMailbox(p1) --[[ extractMailbox | Line: 77 ]]
	if typeof(p1) ~= "table" then
		return nil
	end

	if typeof(p1.Mailbox) == "table" then
		return p1.Mailbox
	end

	return p1
end

local function resolveRefs(p1) --[[ resolveRefs | Line: 84 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
	local GuildWeekComplete = p1:FindFirstChild("GuildWeekComplete")

	if not GuildWeekComplete then
		return
	end

	local v1 = GuildWeekComplete:FindFirstChild("Content")

	if v1 then
		local Info = v1:FindFirstChild("Info")

		if Info then
			local Placement = Info:FindFirstChild("Placement")

			if Placement and Placement:IsA("TextLabel") then
				v2 = Placement
			end
		end
	end

	local Header = GuildWeekComplete:FindFirstChild("Header")

	if Header then
		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v3 = ExitButton
		end
	end

	local ContinueButton = GuildWeekComplete:FindFirstChild("ContinueButton")

	if not (ContinueButton and ContinueButton:IsA("GuiButton")) then
		return
	end

	v4 = ContinueButton
end

local function bindButtons() --[[ bindButtons | Line: 107 | Upvalues: v3 (ref), hidePopup (copy), v4 (ref) ]]
	if v3 then
		v3.MouseButton1Click:Connect(hidePopup)
	end

	if not v4 then
		return
	end

	v4.MouseButton1Click:Connect(hidePopup)
end

function t.Init(p1) --[[ Init | Line: 113 ]] end
function t.Start(p1) --[[ Start | Line: 115 | Upvalues: PlayerGui (copy), v1 (ref), resolveRefs (copy), v3 (ref), hidePopup (copy), v4 (ref), Networking (copy), showPopupIfNeeded (copy) ]]
	task.spawn(function() --[[ Line: 116 | Upvalues: PlayerGui (ref), v1 (ref), resolveRefs (ref), v3 (ref), hidePopup (ref), v4 (ref), Networking (ref), showPopupIfNeeded (ref) ]]
		local GuildWeekComplete = PlayerGui:WaitForChild("GuildWeekComplete", 30)

		if not (GuildWeekComplete and GuildWeekComplete:IsA("ScreenGui")) then
			return
		end

		v1 = GuildWeekComplete
		GuildWeekComplete.Enabled = false
		resolveRefs(GuildWeekComplete)

		if v3 then
			v3.MouseButton1Click:Connect(hidePopup)
		end

		if not v4 then
			Networking.Mailbox.Updated.OnClientEvent:Connect(function(p13) --[[ Line: 124 | Upvalues: showPopupIfNeeded (ref) ]]
				showPopupIfNeeded(if typeof(p13) == "table" then if typeof(p13.Mailbox) == "table" then p13.Mailbox else p13 else nil)
			end)
			task.spawn(function() --[[ Line: 128 | Upvalues: Networking (ref), showPopupIfNeeded (ref) ]]
				local ok, result = pcall(function() --[[ Line: 129 | Upvalues: Networking (ref) ]]
					return Networking.Mailbox.OpenInbox:Fire()
				end)

				if not ok then
					return
				end

				showPopupIfNeeded(if typeof(result) == "table" then if typeof(result.Mailbox) == "table" then result.Mailbox else result else nil)
			end)

			return
		end

		v4.MouseButton1Click:Connect(hidePopup)
		Networking.Mailbox.Updated.OnClientEvent:Connect(function(p13) --[[ Line: 124 | Upvalues: showPopupIfNeeded (ref) ]]
			showPopupIfNeeded(if typeof(p13) == "table" then if typeof(p13.Mailbox) == "table" then p13.Mailbox else p13 else nil)
		end)
		task.spawn(function() --[[ Line: 128 | Upvalues: Networking (ref), showPopupIfNeeded (ref) ]]
			local ok, result = pcall(function() --[[ Line: 129 | Upvalues: Networking (ref) ]]
				return Networking.Mailbox.OpenInbox:Fire()
			end)

			if not ok then
				return
			end

			showPopupIfNeeded(if typeof(result) == "table" then if typeof(result.Mailbox) == "table" then result.Mailbox else result else nil)
		end)
	end)
end

return t