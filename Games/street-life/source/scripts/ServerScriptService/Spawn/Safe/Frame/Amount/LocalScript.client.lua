if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Backpack = Player:FindFirstChild('Backpack')
local InvData = Player:WaitForChild('InvData')

local Max = 10
if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800113546) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 714929470) then 
	Max = 20 
end

while script.Parent do
	script.Parent.Text = #InvData:GetChildren() .. '/' .. Max
	task.wait(.05)
end