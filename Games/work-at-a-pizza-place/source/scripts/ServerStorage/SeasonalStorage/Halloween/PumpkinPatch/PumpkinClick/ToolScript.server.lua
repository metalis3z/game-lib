
local tool = script.Parent
local handle = tool.Handle
local glow = handle.Glow
local gyro = Instance.new("BodyGyro",handle)
gyro.MaxTorque = Vector3.new(0,0,0)

function Weld(x,y)
	local W = Instance.new("Weld")
	W.Name = "PizzaWeld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end


function onActivated()
	
	local torsoPos = tool.Parent.HumanoidRootPart.Position
	local handleCFrame = handle.CFrame
	local glowCFrame = glow.CFrame
	
	tool.Parent = workspace.Pumpkins
	
	handle.CFrame = handleCFrame --- Vector3.new(0,3-(handle.Size.Y/2),0)
	glow.CFrame = glowCFrame --- Vector3.new(0,3-(handle.Size.Y/2),0)
	handle.Anchored = false
	glow.Anchored = false
	
	handle.CanCollide = true
	
	gyro.cframe = handle.CFrame
	gyro.MaxTorque = Vector3.new(400000,400000,400000)
	
	handle.Parent = workspace
	glow.Parent = workspace
	glow.Transparency = 0
	
	lightingChanged()
	
	Weld(handle,glow)
	
	tool.Enabled = false
	
	wait(3)
	
	handle.Parent = tool
	glow.Parent = tool
	
	tool.Enabled = true
	
	gyro.MaxTorque = Vector3.new(0,0,0)
	
	handle.CanCollide = false
	
	handle.Anchored = true
	glow.Anchored = true
end

function Equipped()

	--Weld(handle,handle.Glow)

end

function Unequipped()

	--Weld(handle,handle.Glow)

end

tool.Activated:connect(onActivated)
tool.Equipped:connect(Equipped)
tool.Unequipped:connect(Unequipped)


--if player presses backspace or player leaves game
function changed()
	if script.Player.Value == nil or tool.Parent == workspace then
		tool:Destroy()
	elseif tool.Parent:IsA("Model") then
		handle.Anchored = false
		glow.Anchored = false
	--[[elseif tool.Parent:IsA("Backpack") and tool.Parent.Parent.Character and not tool.Parent.Parent.Character:FindFirstChild("Pumpkin") then
		wait()
		tool.Parent = tool.Parent.Parent.Character]]
	end
end
script.Player.Changed:connect(changed)
tool.Changed:connect(changed)
changed()


function lightingChanged()
	if game.Lighting.TimeOfDay == "15:00:00" or game.Lighting.TimeOfDay == "21:00:00" then
		handle.PointLight.Enabled = true
	else
		handle.PointLight.Enabled = false
	end
end
game.Lighting.Changed:connect(lightingChanged)




