local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

local Misc = game:FindService('ReplicatedStorage').Misc
local WShirt, WPants, WVisor = Misc.WShirt, Misc.WPants, Misc.WVisor

Outfit = function(Player, Arg)
	if Arg == true then
		local Shirt, Pants = WShirt:Clone(), WPants:Clone()
		Shirt.Parent = Player.Character
		Pants.Parent = Player.Character
		for _,v in next, Player.Character:GetChildren() do
			if v:IsA('Shirt') and v.Name ~= 'WShirt' then
				v.Parent = Shirt
			elseif v:IsA('Pants') and v.Name ~= 'WPants' then
				v.Parent = Pants
			end
		end
		WVisor:Clone().Parent = Player.Character
	elseif Arg == false then
		for _,v in next, Player.Character:GetChildren() do
			if v:IsA('Shirt') and v.Name == 'WShirt' then
				if v:FindFirstChildOfClass('Shirt') then
					v:FindFirstChildOfClass('Shirt').Parent = Player.Character
				end
				v:Destroy()
			elseif v:IsA('Pants') and v.Name == 'WPants' then
				if v:FindFirstChildOfClass('Pants') then
					v:FindFirstChildOfClass('Pants').Parent = Player.Character
				end
				v:Destroy()
			end
		end
		if Player.Character:FindFirstChild('WVisor') then Player.Character:FindFirstChild('WVisor'):Destroy() end
	end
end

script.Parent.Triggered:Connect(function(Player)
	local Extra = Player:WaitForChild('Extra')
	local Stored = Player:WaitForChild('stored')

	if Extra.Job.Value == '' then
		Extra.Job.Value = 'Clean'
		JobRemote:FireClient(Player, 'Clean', script.Parent)
		NotifyRemote:FireClient(Player, 'Cleaning Job Started.', 2)
		local Earned = Instance.new('NumberValue', Player)
		Earned.Value = 0
		Earned.Name = 'CleanJobEarned'
	elseif Extra.Job.Value == 'Clean' then
		Extra.Job.Value = ''
		JobRemote:FireClient(Player, 'CleanQuit', script.Parent)
		NotifyRemote:FireClient(Player, 'Cleaning Job Ended.', 2)
		if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
		local MoneyEarned = Player:WaitForChild('CleanJobEarned').Value
		local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
		Adder.Parent = Player.PlayerGui
		Adder.Amount.Text = '+$' .. tostring(MoneyEarned)
		Stored.Money.Value += MoneyEarned
		Player:FindFirstChild('CleanJobEarned'):Destroy()
		task.wait(2)
		for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
		Adder:Destroy()
	end
end)