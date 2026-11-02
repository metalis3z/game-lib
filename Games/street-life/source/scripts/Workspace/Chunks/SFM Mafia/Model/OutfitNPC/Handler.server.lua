task.wait(5)

local GroupID = 14692389
local ShirtID = 'http://www.roblox.com/asset/?id=14453584700'
local PantsID = 'http://www.roblox.com/asset/?id=14453593169'

local Click = script:FindFirstChildOfClass('ClickDetector')

local Shirt = Instance.new('Shirt', script.Parent)
Shirt.Color3 = Color3.fromRGB(255, 255, 255)
Shirt.ShirtTemplate = ShirtID

local Pants = Instance.new('Pants', script.Parent)
Pants.Color3 = Color3.fromRGB(255, 255, 255)
Pants.PantsTemplate = PantsID

local Shirt = Instance.new('Shirt', script.Parent)
Shirt.Color3 = Color3.fromRGB(255, 255, 255)
Shirt.ShirtTemplate = ShirtID

local Pants = Instance.new('Pants', script.Parent)
Pants.Color3 = Color3.fromRGB(255, 255, 255)
Pants.PantsTemplate = PantsID

local ShirtPress = Click:Clone()
ShirtPress.Parent = script.Parent:WaitForChild('Top')
ShirtPress.MouseClick:Connect(function(Player)
	if Player.Character and Player.Character:FindFirstChild('Humanoid') then
		if Player:IsInGroup(GroupID) then
			if Player:GetRankInGroup(GroupID) >= 6 then
				if Player.Character:FindFirstChildOfClass('Shirt') then Player.Character:FindFirstChildOfClass('Shirt'):Destroy() end
				Shirt:Clone().Parent = Player.Character
				if Player.Character:FindFirstChildOfClass('Pants') then Player.Character:FindFirstChildOfClass('Pants'):Destroy() end
				Pants:Clone().Parent = Player.Character
			end
		end
	end
end)
Click:Destroy()