local RepStorage = game.ReplicatedStorage
local ClientServices = RepStorage.ClientServices
local ButtonModule = require(ClientServices.Button)
local WindowService = require(RepStorage.Modules.WindowService)
for _, remote in ipairs(RepStorage.Remotes.FollowRewards:GetChildren()) do
	remote:FireServer()
end
local Sync = RepStorage.Database.Sync
local ItemsDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Item")
local RarityDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity")
local FollowRewards = game.ReplicatedStorage.GetSyncData:InvokeServer("FollowRewards")

local PlayersModule = game.ReplicatedStorage.GetSyncData:InvokeServer("FollowRewards")
local ProfileData = require(RepStorage.Modules.ProfileData)

local Template = script.Template
ButtonModule.createButton(script.Parent.Main.Title.Close, function()
	script.Parent.Visible = false
end)
local function CreatePlayerUI(playerData)

	local ui = Template:Clone()
	ui.Parent = script.Parent.Main.Main.ScrollingFrame
	local username = playerData.Username
	local userId = playerData.UserID
	ui.Container.Title.Text = "@" .. username
	local profileLink = "https://www.roblox.com/users/" .. userId .. "/profile"
	ui.Container.ProfileLink.Container.TextBox.Text = profileLink
	ui.Container.ProfileLink.Container.TextBox.PlaceholderText = profileLink
	ui.Container.Icon.Image =
		"https://www.roblox.com/bust-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

	for itemType, itemId in pairs(playerData.Rewards) do
		local itemInfo = ItemsDB[itemId]
		if not itemInfo then
			warn("Item not found in ItemModule:", itemId)
			continue
		end

		local itemName = itemInfo.ItemName or "Unknown"
		local itemImage = itemInfo.Image or "rbxassetid://584555920"

		local rarity = itemInfo.Rarity
		local rarityColor = RarityDB[rarity] or Color3.fromRGB(255,255,255)

		local rewardContainer = ui.Container.Rewards:FindFirstChild(itemType)
		if rewardContainer then
			rewardContainer.Container.ItemName.Text = itemName
			rewardContainer.Container.ItemName.TextColor3 = rarityColor
			rewardContainer.Container.Icon.Image = itemImage
		end
		local hasKnife = false
		local hasGun = false

		for itemType, itemId in pairs(playerData.Rewards) do
			local rewardContainer = ui.Container.Rewards:FindFirstChild(itemType)
			if not rewardContainer then continue end

			if ProfileData.Weapons.Owned[itemId] ~= nil then
				rewardContainer.Container.Owned.Visible = true

				if itemType == "Knife" then
					hasKnife = true
				elseif itemType == "Gun" then
					hasGun = true
				end
			else
				rewardContainer.Container.Owned.Visible = false
			end
		end

		if hasKnife and hasGun then
			ui.Container.Completed.Visible = true
		else
			ui.Container.Completed.Visible = false
		end

	end

	return ui
end
WindowService:RegisterFrame(script.Parent, "FollowRewards")
for name, data in pairs(PlayersModule) do
	CreatePlayerUI(data)
end
