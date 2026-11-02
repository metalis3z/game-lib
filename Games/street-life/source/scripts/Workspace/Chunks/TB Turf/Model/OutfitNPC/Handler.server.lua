task.wait(5)

local GroupID = 17259706
local ShirtID = 'http://www.roblox.com/asset/?id=15877720080'
local PantsID = 'http://www.roblox.com/asset/?id=17819638858'

local Click = script:FindFirstChildOfClass('ClickDetector')

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
			if Player.Character:FindFirstChildOfClass('Shirt') then Player.Character:FindFirstChildOfClass('Shirt'):Destroy() end
			Shirt:Clone().Parent = Player.Character
		end
	end
end)

local PantsPress = Click:Clone()
PantsPress.Parent = script.Parent:WaitForChild('Bottom')
PantsPress.MouseClick:Connect(function(Player)
	if Player.Character and Player.Character:FindFirstChild('Humanoid') then
		if Player:IsInGroup(GroupID) then
			if Player.Character:FindFirstChildOfClass('Pants') then Player.Character:FindFirstChildOfClass('Pants'):Destroy() end
			Pants:Clone().Parent = Player.Character
		end
	end
end)

Click:Destroy()