if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart', true)

local Gang = Player:WaitForChild('stored'):WaitForChild('Gang')
local GangRemote = game:FindService('ReplicatedStorage'):WaitForChild('Gang')
local NotifyRemote = game:FindService('ReplicatedStorage'):WaitForChild('Notify')

local Error, Press = script:FindFirstChild('Error'), script:FindFirstChild('Press')

Gang_Info = function(Gang)
	if Gang ~= nil and Gang ~= '' then
		local Info = game:FindService('GroupService'):GetGroupInfoAsync(Gang)
		if Info then
			if Info.Name then return Info.Name end
		end
	end
	return nil
end 

task.wait(5)

if Player:IsInGroup(tonumber(Gang.Value)) then
	script.Parent:FindFirstChild('Frame'):FindFirstChild('Current').Text = 'CURRENT GROUP: ' .. tonumber(Gang.Value)
	script.Parent:FindFirstChild('Frame'):FindFirstChild('Name').Text = '(' .. Gang_Info(tonumber(Gang.Value)) .. ')'
end

script.Parent:FindFirstChild('Interact').MouseButton1Click:Connect(function()
	script.Parent:FindFirstChild('Frame').Visible = not script.Parent:FindFirstChild('Frame').Visible
	if not Press.IsPlaying then Press:Play() end
end)

script.Parent:FindFirstChild('Frame'):FindFirstChild('Apply').MouseButton1Click:Connect(function()
	local NewGang = tonumber(script.Parent:FindFirstChild('Frame'):FindFirstChild('Group').Text)
	if NewGang ~= nil and NewGang ~= '' then
		if Player:IsInGroup(NewGang) or NewGang == 0 then
			if Gang.Value ~= NewGang then
				GangRemote:FireServer(NewGang)
				if NewGang ~= 0 then
					script.Parent:FindFirstChild('Frame'):FindFirstChild('Current').Text = 'CURRENT GROUP: ' .. tostring(NewGang)
					script.Parent:FindFirstChild('Frame'):FindFirstChild('Name').Text = '(' .. Gang_Info(NewGang) .. ')'
					NotifyRemote:FireServer('You joined ' .. Gang_Info(NewGang) .. '.' , 2)
				else
					script.Parent:FindFirstChild('Frame'):FindFirstChild('Current').Text = 'CURRENT GROUP: NONE'
					script.Parent:FindFirstChild('Frame'):FindFirstChild('Name').Text = ''
					NotifyRemote:FireServer('You left your gang.', 2)
				end
				if not Press.IsPlaying then Press:Play() end
			else
				NotifyRemote:FireServer('You are already in this group.', 2)
				if not Error.IsPlaying then Error:Play() end
			end
		else
			NotifyRemote:FireServer('You are not in this group.', 2)
			if not Error.IsPlaying then Error:Play() end
		end
	else
		NotifyRemote:FireServer('Group not found.', 2)
		if not Error.IsPlaying then Error:Play() end
	end
end)

task.wait(3)

if Player:IsInGroup(tonumber(Gang.Value)) then
	script.Parent:FindFirstChild('Frame'):FindFirstChild('Current').Text = 'CURRENT GROUP: ' .. tonumber(Gang.Value)
	script.Parent:FindFirstChild('Frame'):FindFirstChild('Name').Text = '(' .. Gang_Info(tonumber(Gang.Value)) .. ')'
end