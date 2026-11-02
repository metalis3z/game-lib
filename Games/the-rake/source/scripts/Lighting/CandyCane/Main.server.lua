repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Equip = script.parent.parent.Humanoid:LoadAnimation(script.parent.Equip)
local Idle = script.parent.parent.Humanoid:LoadAnimation(script.parent.Idle)
local Eat = script.parent.parent.Humanoid:LoadAnimation(script.parent.Eat)
local Clicked = false
Tool.Enabled = true

script.Parent.Equipped:Connect(function()
	Equip:Play()
	Idle:Play()
end)

script.Parent.Activated:Connect(function()
if Clicked == false then
Clicked = true
Eat:Play()
Idle:Stop()
wait(0.5)
if not Tool.Enabled then
	return
end

Tool.Enabled = false

local character = Tool.Parent;
local humanoid = character.Humanoid
if humanoid == nil then
	return 
end

local targetPos = humanoid.TargetPoint
local vCharacter = Tool.Parent
script.Parent.Parent.Humanoid.Health =script.Parent.Parent.Humanoid.MaxHealth 
script.Parent:Destroy()
wait(1)
Clicked = false
end
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)