if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Backpack = Player:FindFirstChild('Backpack')
local InvData = Player:WaitForChild('InvData')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid, HumanoidRootPart = Character:WaitForChild('Humanoid'), Character:WaitForChild('HumanoidRootPart')

if not Humanoid or not HumanoidRootPart or not InvData then return end

local SafeBackpack, SafeInventory = script.Parent:FindFirstChild('Backpack'), script.Parent:FindFirstChild('Inventory')
local Button = script.Parent:FindFirstChild('ButtonClone')

local Max = 10
if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800113546) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 714929470) then 
	Max = 20 
end

for _,v in next, Backpack:GetChildren() do
	if v:IsA('Tool') then
		local Clone = Button:Clone()
		Clone.Parent =  SafeBackpack
		Clone.Visible = true
		Clone.Text = v.Name
	end
end

for _,v in next, InvData:GetChildren() do
	if v:IsA('IntValue') then
		local Clone = Button:Clone()
		Clone.Parent =  SafeInventory
		Clone.Visible = true
		Clone.Text = v.Name
	end
end

script.Parent.Amount.Text = tostring(#InvData:GetChildren() .. '/' .. Max)