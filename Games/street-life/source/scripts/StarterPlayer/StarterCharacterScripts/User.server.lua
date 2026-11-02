task.wait(1)
local data = require(game.ServerScriptService.ProfileCache)

local Character = script.Parent
local Player = game:FindService('Players'):GetPlayerFromCharacter(Character)
Character:WaitForChild('HumanoidRootPart')
local Head = Character:WaitForChild('Head')

task.wait(1)

repeat task.wait(.5) until data[Player] and data[Player].Data and data[Player].Data.level

local Level = data[Player].Data.level
local Name = data[Player].Data.customname
local Emoji = data[Player].Data.customemoji

local CurrentName = Player.DisplayName .. ' (@' .. Player.Name .. ')'

if Name ~= nil and Name ~= '' then
	CurrentName = Name
end

if Emoji ~= nil and Emoji ~= '' then
	CurrentName = '[' .. Emoji .. '] ' .. CurrentName
end

local Billboard = script:WaitForChild('BillboardGui')
Billboard:WaitForChild('Level')
Billboard.TextLabel.Text = CurrentName
Billboard.Level.Text = 'Level: ' .. tostring(data[Player].Data.level)
Billboard.Parent = Head
script:WaitForChild('Police').Parent = Head

if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
	Billboard.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
end

task.wait(1)

while task.wait(1) do
	if Level ~= data[Player].Data.level and Billboard:FindFirstChild('Level') then
		Billboard:FindFirstChild('Level').Text = 'Level: ' .. tostring(data[Player].Data.level)
		Level = data[Player].Data.level
	end
end