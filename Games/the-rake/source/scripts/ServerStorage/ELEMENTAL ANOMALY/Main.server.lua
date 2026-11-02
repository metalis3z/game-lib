repeat wait() until script.Parent.Parent:FindFirstChildOfClass("Humanoid")

local Tool = script.Parent
local Clicked = false
local Equip = script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Equip)
local Idle = script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Idle)
local Throw = script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Throw)

script.Parent.Equipped:Connect(function()
	wait(0.03)
	Idle:Play()
	Equip:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
	Equip:Stop()
end)

script.Parent.Activated:Connect(function()
	if Clicked == false and script.Parent.Done.Value == true then
Clicked = true
		Throw:Play()
		Idle:Stop()
		Equip:Stop()
		local p = Tool.Handle:Clone()
		Tool.Parent.Torso["Right Shoulder"].MaxVelocity = 0.7
		Tool.Parent.Torso["Right Shoulder"].DesiredAngle = 0
		Tool.Parent.Torso["Right Shoulder"].MaxVelocity = 1
		local dir = script.Parent.Parent.Head.CFrame.lookVector
		p.Velocity = (dir * 14) + Vector3.new(0,30,0)
		p.Throw:Play()
		p.CanCollide = true
		p.Massless = false
		local scripts = math.random(1,5)
		if scripts == 1 then
			p.eeriescript.Disabled = false
		elseif scripts == 2 then
			p.darkseedscript.Disabled = false
		elseif scripts == 3 then
			p.icescript.Disabled = false
		elseif scripts == 4 then
			p.grassscript.Disabled = false
		elseif scripts == 5 then
			p.firescript.Disabled = false
		end
		p.Parent = game.Workspace
		script.Parent:Remove()
Clicked = false
end
end)