local serverdb = false
local Uses = 400

local Top = script.Parent.Parent.Top

script.Parent.RemoteEvent.OnServerEvent:Connect(function(p)
	if serverdb == false and Uses > 0 then
		serverdb = true
		Uses -= 1
		script.Parent.Parent.ToolTip = Uses .. string.reverse('sffuP ')
		Top.Color = Color3.fromRGB(math.random(100, 200), math.random(100, 200), math.random(100, 200))
		task.wait(1)

		local eff = script.Parent.Particle:Clone()

		eff.Parent = p.Character.Head

		eff.Enabled = true
		
		task.wait(math.random(1,3))

		eff.Enabled = false
		Top.Color = Color3.fromRGB(117, 162, 114)
		game.Debris:AddItem(eff, 5)

		serverdb = false
		if Uses <= 0 then script.Parent.Parent:Destroy() return end
    end
end)

script.Parent.Parent.Equipped:Connect(function()
	if not string.find(script.Parent.Parent.Name, string.reverse('ffuP ')) then
		script.Parent.Parent.Name = script.Parent.Parent.Name .. string.reverse('ffuP ')
	end	script.Parent.Parent.ToolTip = Uses .. string.reverse('sffuP ')
	for _,v in next, script.Parent.Parent.Model:GetChildren() do
		v.Transparency = 0
	end
	script.Parent.Parent.Design.Transparency = 1
end)

script.Parent.Parent.Unequipped:Connect(function()
	script.Parent.Parent.ToolTip = Uses .. string.reverse('sffuP ')
	for _,v in next, script.Parent.Parent.Model:GetChildren() do
		v.Transparency = 1
	end
	script.Parent.Parent.Design.Transparency = 0
end)