repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Drink = script.parent.parent.Humanoid:LoadAnimation(script.parent.Drink)
local Tool = script.Parent;

function onActivated()
	Drink:Play()
	script.Parent.Parent.Head.DrinkSound:Play()
	script.Disabled = true
	
end

script.Parent.Activated:connect(onActivated)