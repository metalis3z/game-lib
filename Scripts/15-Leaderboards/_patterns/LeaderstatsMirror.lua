--[[
	LeaderstatsMirror  (ModuleScript, server only)

	Builds the `leaderstats` folder (the Roblox player list columns) from your data table and
	keeps it in sync. The data table stays the source of truth; leaderstats is only a display,
	so exploit-free code never reads money back from a Value object.

	  * IntValue / NumberValue columns for numbers that sort correctly in the player list
	  * optional abbreviated text columns ("1.2M") using a StringValue
	  * one cheap sync loop for every player instead of hand-written updates everywhere

	Credit: aura-ascension PlayerService (_ensureLeaderstats / _syncLeaderstats with StringValue
	+ FormatNumber), drill-and-mine PlayerDataService (leaderstats cache + updateLeaderstatVisual),
	forsaken LeaderStats (mirror data values into a cloned template), steal-an-egg Core_PlayerData
	(attribute + leaderstats mirrors).

	Usage (server, after the player's data has loaded):
		local LeaderstatsMirror = require(game.ServerScriptService.LeaderstatsMirror)

		LeaderstatsMirror.Setup(player, {
			{ Name = "Cash", Get = function() return data.Cash end, Abbreviate = true },
			{ Name = "Rebirths", Get = function() return data.Rebirths end },
		})

		-- Values refresh automatically twice a second. Call this after a big change if you
		-- want it to show instantly:
		LeaderstatsMirror.Sync(player)

	Note: the default player list sorts by the FIRST column. StringValue columns sort as text
	("9" above "10"), so put a numeric column first if ranking matters.
]]

local Players = game:GetService("Players")

local LeaderstatsMirror = {}

local SYNC_INTERVAL = 0.5
local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }

local tracked = {} -- [player] = { { Column, Value object, last } }

function LeaderstatsMirror.Abbreviate(value)
	value = tonumber(value) or 0
	local sign = if value < 0 then "-" else ""
	value = math.abs(value)
	if value < 1000 then
		return sign .. tostring(math.floor(value))
	end
	local tier = math.floor(math.log10(value) / 3)
	if tier >= #SUFFIXES then
		return sign .. string.format("%.2e", value)
	end
	local scaled = value / 10 ^ (tier * 3)
	local text = (string.format("%.2f", scaled):gsub("%.?0+$", ""))
	if scaled >= 100 then
		text = tostring(math.floor(scaled))
	end
	return sign .. text .. SUFFIXES[tier + 1]
end

local function display(column, raw)
	raw = tonumber(raw) or 0
	if column.Abbreviate then
		return LeaderstatsMirror.Abbreviate(raw)
	end
	if column.Integer == false then
		return raw
	end
	return math.floor(raw)
end

function LeaderstatsMirror.Setup(player, columns)
	local folder = player:FindFirstChild("leaderstats")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "leaderstats"
	end

	local entries = {}
	for order, column in ipairs(columns) do
		local className = if column.Abbreviate then "StringValue" elseif column.Integer == false then "NumberValue" else "IntValue"
		local valueObject = folder:FindFirstChild(column.Name)
		if valueObject and valueObject.ClassName ~= className then
			valueObject:Destroy()
			valueObject = nil
		end
		if not valueObject then
			valueObject = Instance.new(className)
			valueObject.Name = column.Name
			valueObject:SetAttribute("Order", order)
			valueObject.Parent = folder
		end
		table.insert(entries, { Column = column, Object = valueObject, Last = nil })
	end

	folder.Parent = player -- parent last so the player list sees every column at once
	tracked[player] = entries
	LeaderstatsMirror.Sync(player)
	return folder
end

function LeaderstatsMirror.Sync(player)
	local entries = tracked[player]
	if not entries then
		return
	end
	for _, entry in ipairs(entries) do
		local ok, raw = pcall(entry.Column.Get)
		if ok and raw ~= nil and raw ~= entry.Last then
			entry.Last = raw
			entry.Object.Value = display(entry.Column, raw)
		end
	end
end

Players.PlayerRemoving:Connect(function(player)
	tracked[player] = nil
end)

task.spawn(function()
	while true do
		task.wait(SYNC_INTERVAL)
		for player in pairs(tracked) do
			LeaderstatsMirror.Sync(player)
		end
	end
end)

return LeaderstatsMirror
