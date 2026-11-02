local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")

local PREFIX = "SantaMerchant_"
local TOPIC = "SantaMerchant_CrossServerRestock"

local BRAINROTS = {
	{Name = "Los Jolly Combinasionas"}, 
	{Name = "Money Money Reindeer"},
	{Name = "Jolly Jolly Sahur"},
	{Name = "Ginger Cerat"}
}

local function cleanName(name)
	return string.gsub(name, "%s", "_")
end

local function applychanges(itemName, amount)
	local attr = PREFIX .. cleanName(itemName)
	local actual = ReplicatedStorage:GetAttribute(attr) or 0
	local newAmount = math.max(0, actual + amount)
	ReplicatedStorage:SetAttribute(attr, newAmount)
end

MessagingService:SubscribeAsync(TOPIC, function(message)
	local data = message.Data
	applychanges(data.Name, data.Amount)
end)

return function (context, id, amount, scope)

	local selectedId = tonumber(id)

	if not selectedId or selectedId < 1 or selectedId > 4 then
		return "HI: " .. tostring(id)
	end

	local item = BRAINROTS[selectedId]

	local negativeAmount = -math.abs(amount)

	local notificationText = '<font color="rgb(255,255,255)">Sammy removed </font>' ..
		'<font color="rgb(255,100,100)">' .. amount .. ' stock </font>' ..
		'<font color="rgb(255,255,255)">from ' .. item.Name .. ' in the </font>' ..
		'<font color="rgb(255,150,150)">Santa Merchant</font>' ..
		'<font color="rgb(255,255,255)">!</font>'

	if scope:lower() == "global" then

		MessagingService:PublishAsync(TOPIC, {
			Name = item.Name,
			Amount = negativeAmount
		})

		for _, player in ipairs(game.Players:GetPlayers()) do
			NotifyEvent:FireClient(player, notificationText, 5, "Sounds.Sfx.Success")
		end

		return "Global remove: " .. item.Name
	else

		applychanges(item.Name, negativeAmount)

		for _, player in ipairs(game.Players:GetPlayers()) do
			NotifyEvent:FireClient(player, notificationText, 5, "Sounds.Sfx.Success")
		end

		return "Local remove: " .. item.Name
	end
end