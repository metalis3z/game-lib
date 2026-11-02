local Follow = {4680951413, 2307592501}
local RandomOrder = {10, 18, 25, 50, 100}

local function onPlayerJoin(Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "stored"
	leaderstats.Parent = Player

	local cash = Instance.new("IntValue")
	cash.Name = "Money"
	cash.Value = 500
	cash.Parent = leaderstats


	local Bank = Instance.new("IntValue")
	Bank.Name = "Bank"
	Bank.Value = 0
	Bank.Parent = leaderstats

	if cash.Value > 2000000 then cash.Value = 2000000 end
	cash:GetPropertyChangedSignal('Value'):Connect(function()
		if cash.Value > 2000000 then
			cash.Value = 2000000
		end
	end)

	if Bank.Value > 3000000 then Bank.Value = 3000000 end
	Bank:GetPropertyChangedSignal('Value'):Connect(function()
		if Bank.Value > 3000000 then
			Bank.Value = 3000000
		end
	end)

	local LevelValue = Instance.new('NumberValue', leaderstats)
	LevelValue.Value = 0
	LevelValue.Name = 'Level'

	local XPValue = Instance.new('NumberValue', leaderstats)
	XPValue.Value = 0
	XPValue.Name = 'XP'

	local Jailed = Instance.new('NumberValue', leaderstats)
	Jailed.Value = 0
	Jailed.Name = 'Jailed'

	local Harvested = Instance.new('NumberValue', Player)
	Harvested.Name = 'Harvested'
	Harvested.Value = 0
	
	local CHarvested = Instance.new('NumberValue', Player)
	CHarvested.Name = 'CHarvested'
	CHarvested.Value = 0

	local Gang = Instance.new('NumberValue', leaderstats)
	Gang.Name = 'Gang'
	Gang.Value = 0

	local ClaimedGroup = Instance.new('BoolValue', leaderstats)
	ClaimedGroup.Name = 'ClaimedGroup'
	ClaimedGroup.Value = false

	local ClaimedFollow = Instance.new('BoolValue', leaderstats)
	ClaimedFollow.Name = 'ClaimedFollow'
	ClaimedFollow.Value = false

	local Crypto = Instance.new('NumberValue', Player)
	Crypto.Name = 'Crypto'
	Crypto.Value = 0

	local ETH = Instance.new('NumberValue', Player)
	ETH.Name = 'ETH'
	ETH.Value = 0

	local DOGE = Instance.new('NumberValue', Player)
	DOGE.Name = 'DOGE'
	DOGE.Value = 0

	local CustomName = Instance.new('StringValue', leaderstats)
	CustomName.Name = 'CustomName'
	CustomName.Value = ''

	local CustomEmoji = Instance.new('StringValue', leaderstats)
	CustomEmoji.Name = 'CustomEmoji'
	CustomEmoji.Value = ''

	local Crosshair = Instance.new('StringValue', leaderstats)
	Crosshair.Name = 'Crosshair'
	Crosshair.Value = '973818318 1.5'
	
	local Spawners = Instance.new('StringValue', leaderstats)
	Spawners.Name = 'Spawners'
	Spawners.Value = ''
	
	local Clothing = Instance.new('StringValue', leaderstats)
	Clothing.Name = 'Clothing'
	Clothing.Value = 'nil nil'
	
	local Tattoos = Instance.new('StringValue', leaderstats)
	Tattoos.Name = 'Tattoos'
	Tattoos.Value = ''
	
	local Wipes = Instance.new('NumberValue', leaderstats)
	Wipes.Name = 'Wipes'
	Wipes.Value = 0
	
	local Accessories = Instance.new('StringValue', leaderstats)
	Accessories.Name = 'Accessories'
	Accessories.Value = ''

	local Extra = Instance.new("Folder")
	Extra.Name = 'Extra'
	Extra.Parent = Player
	local Job = Instance.new("StringValue")
	Job.Name = 'Job'
	Job.Parent = Extra
	local PlayTime = Instance.new("NumberValue")
	PlayTime.Name = 'PlayTime'
	PlayTime.Parent = Extra
	local Device = Instance.new("StringValue")
	Device.Name = 'Device'
	Device.Parent = Extra

	local GymStamina = Instance.new('NumberValue', leaderstats)
	GymStamina.Name = 'GymStamina'
	GymStamina.Value = 0

	local GymStrength = Instance.new('NumberValue', leaderstats)
	GymStrength.Name = 'GymStrength'
	GymStrength.Value = 0

	if LevelValue.Value >= 10 then
		if not game:GetService('BadgeService'):UserHasBadgeAsync(Player.UserId, 1713442706802769) then
			game:GetService('BadgeService'):AwardBadge(Player.UserId, 1713442706802769)
		end
	end

	LevelValue:GetPropertyChangedSignal('Value'):Connect(function()
		if type(LevelValue.Value) == "number" then
			if LevelValue.Value >= 10 then
				if not game:GetService('BadgeService'):UserHasBadgeAsync(Player.UserId, 1713442706802769) then
					game:GetService('BadgeService'):AwardBadge(Player.UserId, 1713442706802769)
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(400) and (true) and Player do
			if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
				if XPValue.Value + 10 >= 100 then
					if LevelValue.Value >= 200 then
					else
						LevelValue.Value += 1
						XPValue.Value = 0
					end
				else
					XPValue.Value += 25
				end
			else
				if XPValue.Value + 20 >= 100 then
					if LevelValue.Value >= 200 then
					else
						LevelValue.Value += 1
						XPValue.Value = 0
					end
				else
					XPValue.Value += 50
				end
			end
		end
	end)

	task.wait(10)
	
	if XPValue.Value >= 100 then
		if LevelValue.Value < 200 then
			XPValue.Value = 0
			LevelValue.Value += 1
		end
	end
	
	

	if cash.Value < 0 then cash.Value = 0 end
	if Bank.Value < 0 then Bank.Value = 0 end

	task.spawn(function()
		if not ClaimedFollow.Value then
			local HttpService = game:GetService('HttpService')
			local Request = HttpService:RequestAsync({
				Url = 'https://friends.roproxy.com/v1/users/' .. Player.UserId .. '/followings?sortOrder=Asc&limit=' .. RandomOrder[math.random(1, #RandomOrder)],
				Method = 'GET'
			})

			if Request and Request.Success then
				local FollowingData = HttpService:JSONDecode(Request.Body).data
				local FollowingRightAmount = 0

				for _, v in next, FollowingData do
					if v.id == Follow[1] or v.id == Follow[2] then
						FollowingRightAmount += 1
					end
					if FollowingRightAmount >= 2 then break end
				end
				if FollowingRightAmount >= 2 then
					ClaimedFollow.Value = true
					cash.Value += 15000
				end
			end
		end
	end)
	
	task.wait(10)
	
	if Player:IsInGroup(34979842) then
		if not string.find('⭐', CustomEmoji.Value) or string.find('🌟', CustomEmoji.Value)  or string.find('💫', CustomEmoji.Value)  then
			if Player:GetRankInGroup(34979842) == 1 then
				CustomEmoji.Value = '⭐'
			elseif Player:GetRankInGroup(34979842) == 2 then
				CustomEmoji.Value = '🌟'
			elseif Player:GetRankInGroup(34979842) == 253 then
				CustomEmoji.Value = '💫'
			end
		end
	else
		if string.find('⭐', CustomEmoji.Value) or string.find('🌟', CustomEmoji.Value) or string.find('💫', CustomEmoji.Value) then
			CustomEmoji.Value = ''
		end
	end
	
	if Wipes.Value == 0 then
		Wipes.Value = 1
		cash.Value = 5000
		Bank.Value = 0
	end

	while task.wait(1) do
		PlayTime.Value += 1
	end
end

game.Players.PlayerAdded:Connect(onPlayerJoin) 