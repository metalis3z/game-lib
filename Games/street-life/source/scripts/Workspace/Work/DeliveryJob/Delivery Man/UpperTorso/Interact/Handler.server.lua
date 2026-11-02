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
		Extra.Job.Value = 'Delivery'
		JobRemote:FireClient(Player, 'Delivery', script.Parent)
		NotifyRemote:FireClient(Player, 'Delivery Job Started.', 2)
		local Earned = Instance.new('NumberValue', Player)
		Earned.Value = 0
		Earned.Name = 'FoodJobEarned'
		Outfit(Player, true)
	elseif Extra.Job.Value == 'Delivery' then
		Extra.Job.Value = ''
		JobRemote:FireClient(Player, 'Quit', script.Parent)
		NotifyRemote:FireClient(Player, 'Delivery Job Ended.', 2)
		for _,v in ipairs(workspace:GetChildren()) do
			if v.Name == 'NPC' then
				if v:FindFirstChild('Interact') then
					if v.Interact:FindFirstChild(Player.Name) then
						v:Destroy()
					end
				end
			end
		end
		Outfit(Player, false)
		if Player.Backpack:FindFirstChild('DeliveryFood') then
			Player.Backpack:FindFirstChild('DeliveryFood'):Destroy()
		elseif Player.Character:FindFirstChild('DeliveryFood') then
			Player.Character:FindFirstChild('DeliveryFood'):Destroy()
		end
		if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
		local MoneyEarned = Player:WaitForChild('FoodJobEarned').Value
		local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
		Adder.Parent = Player.PlayerGui
		if MoneyEarned ~= 0 then
			Adder.Amount.Text = '+$' .. tostring(MoneyEarned)
		else
			Adder.Amount.Text = ''
		end
		Stored.Money.Value += MoneyEarned
		Player:FindFirstChild('FoodJobEarned'):Destroy()
		task.wait(2)
		for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
		Adder:Destroy()
	end
end)