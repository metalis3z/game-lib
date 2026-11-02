local Cooldown_Time = 200
local Money = {
	Min = 200 * 2,
	Max = 325 * 2
}

local Glass = script.Parent.Parent.Parent
local Break, Alarm = script.Parent.Parent:FindFirstChild('Break'), script.Parent.Parent:FindFirstChild('Alarm')
local Front = Glass.Light:FindFirstChildOfClass('SurfaceLight')

local Cooldown = false
script.Parent.Triggered:Connect(function(Player)
	local Character = Player.Character
	local Humanoid, HumanoidRootPart = Character:FindFirstChild('Humanoid'), Character:FindFirstChild('HumanoidRootPart')
	if not Character or not Humanoid or not HumanoidRootPart or Character.Humanoid.Health <= 0 or not script.Parent.Enabled then return end
	if Cooldown == true then 
		local Stored = Player:FindFirstChild('stored')
		if script.Parent.ObjectText == 'Grab Cash' and script.Parent.Enabled and Stored then
			script.Parent.Enabled = false
			local Amount = math.random(Money.Min, Money.Max)
			if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = '+$' .. tostring(Amount)
			Stored.Money.Value += Amount
			task.wait(.2)
			script.Parent.ObjectText = 'Break Glass'
			task.wait(3.8)
			for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
			Adder:Destroy()
		end
		return
	end
	Cooldown = true
	local Animation = Humanoid:LoadAnimation(game:FindService('ReplicatedStorage').AnimationEvents:FindFirstChild('GlassPunch'))
	Animation:Play()
	script.Parent.Enabled = false
	Animation.Stopped:Wait()
	Break:Play()
	Glass.Transparency = 1
	task.wait(.5)
	Alarm:Play()
	task.spawn(function()
		for _ = 1, 10 do Front.Brightness += 5 task.wait(.04) end
		for _ = 1, 40 do
			for _ = 1, 5 do Front.Brightness -= 5 task.wait(.04) end
			for _ = 1, 5 do Front.Brightness += 5 task.wait(.04) end
		end
		for _ = 1, 10 do Front.Brightness -= 5 task.wait(.04) end
	end)
	task.wait(1)
	script.Parent.ObjectText = 'Grab Cash'
	script.Parent.Enabled = true
	task.wait(Cooldown_Time)
	Glass.Transparency = .6
	script.Parent.Enabled = true
	script.Parent.ObjectText = 'Break Glass'
	Cooldown = false
end)