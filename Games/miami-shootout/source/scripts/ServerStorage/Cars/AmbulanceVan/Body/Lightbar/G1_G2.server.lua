grp1 = script.Parent.G1:GetChildren()
grp2 = script.Parent.G2:GetChildren()
--------------------------------------------------------------------------------
local Motor1 = {}
local Motor2 = {}
local Motor3 = {}
local Motor4 = {}
--------------------------------------------------------------------------------
for _,i in pairs(script.Parent.RotLights:GetChildren()) do
	if i.Name == "Motor1" then
		table.insert(Motor1,i.Motor)
	elseif i.Name == "Motor2" then
		table.insert(Motor2,i.Motor)
	elseif i.Name == "Motor3" then
		table.insert(Motor3,i.Motor)
	elseif i.Name == "Motor4" then
		table.insert(Motor4,i.Motor)
	end
end

function change(on)
	for _,i in pairs(script.Parent.RotLights:GetChildren()) do
		if i.Name == "RotLight" then
			if on then
				if i:FindFirstChild("red") then
					i.red.Material = Enum.Material.Neon
					i.red.Color = script.Parent.RotLights.Colors.red.Value
					i.red.SpotLight.Enabled = true
				elseif i:FindFirstChild("blue") then
					i.blue.Material = Enum.Material.Neon
					i.blue.Color = script.Parent.RotLights.Colors.blue.Value
					i.blue.SpotLight.Enabled = true
				elseif i:FindFirstChild("white") then
					i.white.Material = Enum.Material.Neon
					i.white.Color = script.Parent.RotLights.Colors.white.Value
					i.white.SpotLight.Enabled = true
				end
			else
				if i:FindFirstChild("red") then
					i.red.Material = Enum.Material.Glass
					i.red.BrickColor = BrickColor.new("Institutional white")
					i.red.SpotLight.Enabled = false
				elseif i:FindFirstChild("blue") then
					i.blue.Material = Enum.Material.Glass
					i.blue.BrickColor = BrickColor.new("Institutional white")
					i.blue.SpotLight.Enabled = false
				elseif i:FindFirstChild("white") then
					i.white.Material = Enum.Material.Glass
					i.white.BrickColor = BrickColor.new("Institutional white")
					i.white.SpotLight.Enabled = false
				end
			end
		end
	end
end

local Rotate = false

function RotateAction(Item)
	for _,i in pairs(Motor1)do
		repeat
			i.DesiredAngle = 1.5
			wait(0.5)
			i.DesiredAngle = 0
			wait(0.2)
			break
		until Rotate == false	
	end
end
--------------------------------------------------------------------------------
while true do
wait()
if script.Parent.on.Value == true then
--------------------------------------------------------------------------------	
	change(true)
	Rotate = true
	RotateAction()	
	for _,i in pairs(Motor2)do
		i.MaxVelocity = 0.3
		i.DesiredAngle = 99999999999999999999999999999999999
	end
	for _,i in pairs(Motor3)do
		i.MaxVelocity = 0.2
		i.DesiredAngle = 99999999999999999999999999999999999
	end
	for _,i in pairs(Motor4)do
		i.MaxVelocity = 0.25
		i.DesiredAngle = 99999999999999999999999999999999999
	end
	
--------------------------------------------------------------------------------	
else
	change(false)
	Rotate = false
	for _,i in pairs(Motor1)do
		i.MaxVelocity = 5555555555555555555555
		i.DesiredAngle = 0
	end
	for _,i in pairs(Motor2)do
		i.MaxVelocity = 5555555555555555555555
		i.DesiredAngle = 0
	end
	for _,i in pairs(Motor3)do
		i.MaxVelocity = 5555555555555555555555
		i.DesiredAngle = 0
	end
	for _,i in pairs(Motor4)do
		i.MaxVelocity = 5555555555555555555555
		i.DesiredAngle = 0
	end
end
end