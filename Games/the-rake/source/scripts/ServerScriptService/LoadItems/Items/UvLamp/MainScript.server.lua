-- Script by Xcorrectgamermaster
repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Clicked = false

script.parent.Equipped:Connect(function()
end)

script.parent.Unequipped:Connect(function()
	script.Parent.On.Value = 3
end)

function ToolClicked()
	if script.Parent.On.Value == 0 and Clicked == false or script.Parent.On.Value == 3 and Clicked == false then
		Clicked = true
		script.Parent.PowerEnabler.Disabled = true
		script.Parent.PowerRecharge2.Disabled = true
		script.Parent.On.Value=1
		--wait(0.7)
	Clicked = false
	elseif script.Parent.On.Value == 1 and Clicked == false then
		Clicked = true
		script.Parent.PowerEnabler.Disabled = false
		script.Parent.On.Value=0
		--wait(0.7)
		Clicked = false
		--wait(2)
		--script.Parent.PowerRecharge2.Disabled = false
  end
  end

Tool.Activated:Connect(ToolClicked)