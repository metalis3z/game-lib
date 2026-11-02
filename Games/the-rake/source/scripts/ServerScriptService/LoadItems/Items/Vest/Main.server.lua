repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local animations = script.Parent.Animations
local human = script.Parent.Parent:FindFirstChild("Humanoid")
local head = script.Parent.Parent:FindFirstChild("Head")
local char = script.Parent.Parent

local Equip = human:LoadAnimation(animations.Equip)
local Hold = human:LoadAnimation(animations.Hold)
local Wear = human:LoadAnimation(animations.Wear)
local debounce = false

script.parent.Equipped:Connect(function()
	Hold:Play()
	Equip:Play()
end)

script.parent.Activated:Connect(function()
	if debounce == false then
		debounce = true
		Wear:Play()
		wait(0.8)
		head.VestSound:Play()
		script.Parent.Base.Transparency = 1
	    if script.parent.parent:FindFirstChild("CreateArmour") then
		script.parent.parent.CreateArmour.Disabled = false
		end
		Hold:Stop()
		Equip:Stop()
		script.Parent:Destroy()
	end
end)

script.parent.Unequipped:Connect(function()
	Hold:Stop()
end)