--[[
     Made by arxx plz no
]]

local _Booths = game.ServerStorage.BoothModels
local _HttpService = game:GetService("HttpService")
local _Events = game:GetService("ReplicatedStorage").Events
local _NumberHelpers = require(game.ReplicatedStorage.Common.NumberHelpers)
local _DataService = game:GetService("DataStoreService")
local _TextData = _DataService:GetDataStore("TextData")
local _BoothData = _DataService:GetDataStore("BoothData")

local function getGamesIds(userId, cursor, gamesIds)
	cursor = cursor or ""
	gamesIds = gamesIds or {}
	local success, result = pcall(_HttpService.GetAsync, _HttpService, `https://games.roproxy.com/v2/users/{userId}/games?limit=50&cursor={cursor}`)
	if success and result then
		local data = _HttpService:JSONDecode(result)
		for _, _game in data.data do
			table.insert(gamesIds, _game.id)
		end
		if data.nextPageCursor then
			getGamesIds(userId, data.nextPageCursor, gamesIds)
		end
	else
		warn(result)
		getGamesIds(userId, cursor, gamesIds)
	end
	return gamesIds
end

_Events.ClaimBooth.OnServerEvent:Connect(function(player, booth, slot, interaction)
	local CurrentBooth = booth
	local NewBooth = _Booths:FindFirstChild("BasicBooth"):Clone()
	local boothui = script.BoothUI:Clone()
	local truraised = _NumberHelpers.format(player:FindFirstChild("leaderstats").Raised.Value)
	
	boothui.Parent = NewBooth
	boothui.Details.Adornee = NewBooth:FindFirstChild("Base")
	boothui.Items.Adornee = NewBooth:FindFirstChild("ItemsPart")
	boothui.Sign.Adornee = NewBooth:FindFirstChild("SignPart")
	boothui.Details.Raised.Visible = true
	
	boothui.Details.Owner.Text = player.DisplayName .. "'s stand"
	boothui.Details.Raised.Text = string.format("" .. truraised .. " raised")
	boothui.Sign.TextLabel.Text =  _TextData:GetAsync(player.UserId) or "Actually PLS DONATE! 💸"
	
	NewBooth.Parent = workspace:FindFirstChild("BoothModels")
	NewBooth:SetAttribute("BoothID", slot)
	NewBooth:SetPrimaryPartCFrame(CurrentBooth.PrimaryPart.CFrame)
	CurrentBooth:Destroy()
	player:SetAttribute("Claimed", true)
	player:SetAttribute("OwnedBooth", slot)
	interaction.Claim.Enabled = false
	
	local function getGamePasses(userId, gamePasses, universeIds)
		gamePasses = gamePasses or {}
		universeIds =  universeIds or getGamesIds(userId)
		for i, universeId in universeIds do
			local success, result = pcall(_HttpService.GetAsync, _HttpService, `https://games.roproxy.com/v1/games/{universeId}/game-passes?limit=50`)
			if success and result then
				table.remove(universeIds, i)
				local data = _HttpService:JSONDecode(result)
				for _, gamePass in data.data do
					if gamePass.price and gamePass.price > 0 then
						local itemtemp = script.ItemTemplate:Clone()
						
						table.insert(gamePasses, {
							Name = gamePass.name,
							Price = gamePass.price,
							Id = gamePass.id,
							ItemType = Enum.InfoType.GamePass
						})
					
						itemtemp.Name = gamePass.name
						itemtemp.Text = tostring("" .. gamePass.price)
						itemtemp.Gamepass.Value = gamePass.id
						itemtemp.Robux.Value = gamePass.price
						itemtemp.OwnerID.Value = gamePass.sellerId
						itemtemp.Parent = NewBooth.BoothUI.Items.Frame
						itemtemp.LayoutOrder = gamePass.price
					end
				end
			else
				warn(result)
				getGamePasses(userId, gamePasses, universeIds)
			end
		end
		return gamePasses
	end
	
	getGamePasses(player.UserId)
end)

_Events.Changetext.OnServerEvent:Connect(function(player, booth, text)
	booth.BoothUI.Sign.TextLabel.Text = text
	_TextData:SetAsync(player.UserId, text)
end)

_Events.Refresh.OnServerEvent:Connect(function(player, booth)
	local truraised = _NumberHelpers.format(player:FindFirstChild("leaderstats").Raised.Value)
	
	for i,v in pairs(booth.BoothUI.Items.Frame:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	
	booth.BoothUI.Details.Raised.Text = string.format("" .. truraised .. " raised")

	local function getGamePasses(userId, gamePasses, universeIds)
		gamePasses = gamePasses or {}
		universeIds =  universeIds or getGamesIds(userId)
		for i, universeId in universeIds do
			local success, result = pcall(_HttpService.GetAsync, _HttpService, `https://games.roproxy.com/v1/games/{universeId}/game-passes?limit=50`)
			if success and result then
				table.remove(universeIds, i)
				local data = _HttpService:JSONDecode(result)
				for _, gamePass in data.data do
					if gamePass.price and gamePass.price > 0 then
						local itemtemp = script.ItemTemplate:Clone()

						table.insert(gamePasses, {
							Name = gamePass.name,
							Price = gamePass.price,
							Id = gamePass.id,
							ItemType = Enum.InfoType.GamePass
						})

						itemtemp.Name = gamePass.name
						itemtemp.Text = tostring("" .. gamePass.price)
						itemtemp.Gamepass.Value = gamePass.id
						itemtemp.Robux.Value = gamePass.price
						itemtemp.OwnerID.Value = gamePass.sellerId
						itemtemp.Parent = booth.BoothUI.Items.Frame
						itemtemp.LayoutOrder = gamePass.price
					end
				end
			else
				warn(result)
				getGamePasses(userId, gamePasses, universeIds)
			end
		end
		return gamePasses
	end

	getGamePasses(player.UserId)
end)

_Events.Unclaim.OnServerEvent:Connect(function(player, booth, slot, interaction)
	local CurrentBooth = booth
	local NewBooth = _Booths:FindFirstChild("BasicBooth"):Clone()
	local boothui = script.BoothUI:Clone()

	boothui.Parent = NewBooth
	boothui.Details.Adornee = NewBooth:FindFirstChild("Base")
	boothui.Items.Adornee = NewBooth:FindFirstChild("ItemsPart")
	boothui.Sign.Adornee = NewBooth:FindFirstChild("SignPart")
	boothui.Details.Raised.Visible = false

	boothui.Details.Owner.Text = "unclaimed"
	boothui.Details.Raised.Text = "100R$"
	boothui.Sign.TextLabel.Text = "your text here"

	NewBooth.Parent = workspace:FindFirstChild("BoothModels")
	NewBooth:SetAttribute("BoothID", slot)
	NewBooth:SetPrimaryPartCFrame(CurrentBooth.PrimaryPart.CFrame)
	CurrentBooth:Destroy()
	player:SetAttribute("Claimed", false)
	player:SetAttribute("OwnedBooth", "None")
	interaction.Claim.Enabled = true
end)

_Events.left.OnServerEvent:Connect(function(player, booth, slot, i)
	local CurrentBooth = booth
	local NewBooth = _Booths:FindFirstChild("BasicBooth"):Clone()
	local boothui = script.BoothUI:Clone()

	boothui.Parent = NewBooth
	boothui.Details.Adornee = NewBooth:FindFirstChild("Base")
	boothui.Items.Adornee = NewBooth:FindFirstChild("ItemsPart")
	boothui.Sign.Adornee = NewBooth:FindFirstChild("SignPart")
	boothui.Details.Raised.Visible = false

	boothui.Details.Owner.Text = "unclaimed"
	boothui.Details.Raised.Text = "100R$"
	boothui.Sign.TextLabel.Text = "your text here"

	NewBooth.Parent = workspace:FindFirstChild("BoothModels")
	NewBooth:SetAttribute("BoothID", slot)
	NewBooth:SetPrimaryPartCFrame(CurrentBooth.PrimaryPart.CFrame)
	CurrentBooth:Destroy()
	i.Claim.Enabled = true
end)

_Events.ChangeBooth.OnServerEvent:Connect(function(player, newbooth, booth, slot)
	local CurrentBooth = booth
	local NewBooth = newbooth:Clone()
	local boothui = script.BoothUI:Clone()
	local truraised = _NumberHelpers.format(player:FindFirstChild("leaderstats").Raised.Value)

	boothui.Parent = NewBooth
	boothui.Details.Adornee = NewBooth:FindFirstChild("Base")
	boothui.Items.Adornee = NewBooth:FindFirstChild("ItemsPart")
	boothui.Sign.Adornee = NewBooth:FindFirstChild("SignPart")
	boothui.Details.Raised.Visible = true

	boothui.Details.Owner.Text = player.DisplayName .. "'s stand"
	boothui.Details.Raised.Text = string.format("" .. truraised .. " raised")
	boothui.Sign.TextLabel.Text = CurrentBooth.BoothUI.Sign.TextLabel.Text

	NewBooth.Parent = workspace:FindFirstChild("BoothModels")
	NewBooth:SetAttribute("BoothID", slot)
	NewBooth:SetPrimaryPartCFrame(CurrentBooth.PrimaryPart.CFrame)
	CurrentBooth:Destroy()

	local function getGamePasses(userId, gamePasses, universeIds)
		gamePasses = gamePasses or {}
		universeIds =  universeIds or getGamesIds(userId)
		for i, universeId in universeIds do
			local success, result = pcall(_HttpService.GetAsync, _HttpService, `https://games.roproxy.com/v1/games/{universeId}/game-passes?limit=50`)
			if success and result then
				table.remove(universeIds, i)
				local data = _HttpService:JSONDecode(result)
				for _, gamePass in data.data do
					if gamePass.price and gamePass.price > 0 then
						local itemtemp = script.ItemTemplate:Clone()

						table.insert(gamePasses, {
							Name = gamePass.name,
							Price = gamePass.price,
							Id = gamePass.id,
							ItemType = Enum.InfoType.GamePass
						})

						itemtemp.Name = gamePass.name
						itemtemp.Text = tostring("" .. gamePass.price)
						itemtemp.Gamepass.Value = gamePass.id
						itemtemp.OwnerID.Value = gamePass.sellerId
						itemtemp.Robux.Value = gamePass.price
						itemtemp.Parent = NewBooth.BoothUI.Items.Frame
						itemtemp.LayoutOrder = gamePass.price
					end
				end
			else
				warn(result)
				getGamePasses(userId, gamePasses, universeIds)
			end
		end
		return gamePasses
	end

	getGamePasses(player.UserId)
end)