local handler = {}

local players = game:GetService("Players")
local abbreviate = require(game:GetService("ReplicatedStorage").Engine.Modules.Abbreviate2)

local function getTop(datastore:OrderedDataStore)
	local pages = datastore:GetSortedAsync(false, 100)
	local top100 = pages:GetCurrentPage()
	return top100
end

local function clearUnnecessary(scrollingFrame:ScrollingFrame)
	for _, v in pairs(scrollingFrame:GetChildren()) do
		if v.Name ~= "template" and v:IsA("Frame") then
			v:Destroy()
		end
	end
end

function handler.setLeaderboard(mainFrame:ScrollingFrame, template:Frame, datastore:OrderedDataStore, prefix:string)
	clearUnnecessary(mainFrame)
	local top100 = getTop(datastore)
	for rank, data in ipairs(top100) do
		local frame = template:Clone()
		local plrText:TextLabel = frame.player
		local pointsText:TextLabel = frame.points
		local rankText:TextLabel = frame.rank
		
		local plrName = players:GetNameFromUserIdAsync(data.key)
		local plrAmount = abbreviate.abbreviate(data.value)
		
		if prefix then
			plrAmount = prefix..plrAmount
		end
		
		plrText.Text = "@"..plrName
		pointsText.Text = plrAmount
		rankText.Text = "#"..rank
		
		frame.Visible = true
		frame.Parent = mainFrame
		frame.Name = "valid"
	end
end

return handler
