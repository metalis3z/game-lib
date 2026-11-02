local Players = game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage
local sg = script.Parent 
local sample = script:WaitForChild("Sample") --Our Sample frame
local sf = sg:WaitForChild("List") --The scrolling frame
local ui = sf.UIGridLayout
local LeaderboardModel = sg.Parent.Parent.Parent

local dataStoreService = game:GetService("DataStoreService")
--The data store service
local dataStore = dataStoreService:GetOrderedDataStore("leaderboard2")
--Get the data store with key "Leaderboard"

wait(5)
local smallestFirst = true
local numberToShow = 100
local minValue = 0
local maxValue = 10^25--(10^30), any numbers higher than this will be excluded
local pages = dataStore:GetSortedAsync(smallestFirst, numberToShow)
--Get data
local top = pages:GetCurrentPage()
local data = {}

for a,b in ipairs(top) do--Loop through data
	local userid = b.key--User id
	local points = b.value--Points
	local username = "[Failed To Load]"--If it fails, we let them know
	local s,e = pcall(function()
		username = game.Players:GetNameFromUserIdAsync(userid)--Get username
	end)
	if not s then--Something went wrong
		warn("Error getting name for "..userid..". Error: "..e)
	end
	print(points)
	local image = game.Players:GetUserThumbnailAsync(userid, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
	if points > minValue and points < maxValue then
		table.insert(data,{username,points,image,userid})--Put new data in new table
	end
end

local function toHMS(s)
	return string.format("%02i:%02i:%02i", s/60^2, s/60%60, s%60)
end

ui.Parent = script
sf:ClearAllChildren()--Remove old frames
ui.Parent = sf
for number,d in pairs(data) do--Loop through our new data
	local name = d[1]
	local val = d[2]
	local image = d[3]
	local userid = d[4]
	local color = Color3.new(1, 1, 1)--Default color
	local new = sample:Clone()--Make a clone of the sample frame
	new.Name = name--Set name for better recognition and debugging
	new.LayoutOrder = number--UIListLayout uses this to sort in the correct order
	new.Username.Text = name--Set the username
	new.Stat.TextColor3 = color--Set the place color (Gold = 1st)
	new.UserImage.Image = image
	new.Username.TextColor3 = color--Set the place color (Gold = 1st)
	new.Stat.Text = toHMS(val)
	new.Parent = sf--Parent to scrolling frame
end
