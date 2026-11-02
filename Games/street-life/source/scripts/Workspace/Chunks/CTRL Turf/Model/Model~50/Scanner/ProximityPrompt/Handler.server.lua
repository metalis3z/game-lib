task.wait(5)

local Door = script:FindFirstChildOfClass('ObjectValue').Value
local Cooldown = false

local Toggle = function(Arg)
	if Arg == 'Open' then
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(0, 255, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(0, 255, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = true
		game:FindService('TweenService'):Create(Door, TweenInfo.new(1), {CFrame = Door:FindFirstChild('Open').CFrame}):Play()
		Cooldown = true
	elseif Arg == 'Close' then
		game:FindService('TweenService'):Create(Door, TweenInfo.new(1), {CFrame = Door:FindFirstChild('Closed').CFrame}):Play()
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = false
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(255, 255, 255)
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(255, 255, 255)
		task.wait(1)
		Cooldown = false
	elseif Arg == 'Wrong' then
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(255, 0, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(255, 0, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = true
		Cooldown = true
		task.wait(1)
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(255, 255, 255)
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(255, 255, 255)
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = false
		Cooldown = false
	elseif Arg == 'OpenInside' then
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(255, 255, 255)
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(0, 255, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = false
		game:FindService('TweenService'):Create(Door, TweenInfo.new(1), {CFrame = Door:FindFirstChild('Open').CFrame}):Play()
	elseif Arg == 'CloseInside' then
		script.Parent.Parent.Parent.Face.Color = Color3.fromRGB(255, 255, 255)
		Door:FindFirstChildOfClass('SurfaceLight').Color = Color3.fromRGB(0, 255, 0)
		Door:FindFirstChildOfClass('SurfaceLight').Enabled = false
		game:FindService('TweenService'):Create(Door, TweenInfo.new(1), {CFrame = Door:FindFirstChild('Closed').CFrame}):Play()
	end
end

script.Parent.Triggered:Connect(function(Player)
	if Cooldown then return end
	if Player:IsInGroup(34619750) then
		Toggle('Open')
		task.wait(math.random(5, 8))
		Toggle('Close')
	else
		Toggle('Wrong')
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You arent in the group!', 3)
	end
end)

script.Parent.Parent.Scanner.ProximityPrompt.Triggered:Connect(function()
	if Door.CFrame == Door:FindFirstChild('Closed').CFrame then
		Toggle('OpenInside')
		task.wait(3)
		Toggle('Close')
	elseif Door.CFrame == Door:FindFirstChild('Open').CFrame then
		Toggle('CloseInside')
	end
end)