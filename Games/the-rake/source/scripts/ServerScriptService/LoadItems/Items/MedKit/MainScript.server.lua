repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Clicked = false
local Healing = script.parent.parent.Humanoid:LoadAnimation(script.parent.Healing)
local Hold = script.parent.parent.Humanoid:LoadAnimation(script.parent.Hold)

script.parent.Equipped:Connect(function()
	if script.Parent.Healed.Value == false then
	--Tool.Handle.Transparency = 0
		Hold:Play()
	end	
end)

script.parent.Unequipped:Connect(function()
	script.Parent.Heal.Value = false
	--Tool.Handle.Transparency = 0
	Healing:Stop()
	Tool.Handle.Sound:Stop()
	Hold:Stop()
	wait()
end)

function ToolClicked()
	if script.Parent.Heal.Value == false then
		script.Parent.Heal.Value = true
		script.Parent.Parent.StopScript.Stop.Value = true
		script.Parent.Parent.StopScript.Disabled = false
		Tool.Handle.Transparency = 1
		script.Parent.HealScript.Disabled=false
		Healing:Play()
		Tool.Handle.Sound:Play()
		script.Parent.Parent.Humanoid.WalkSpeed=0
		script.Parent.Parent.RunScript.Disabled=true
		Hold:Stop()
	elseif script.Parent.Heal.Value == true then
		script.Parent.Heal.Value = false
		script.Parent.Parent.StopScript.Stop.Value = false
		script.Parent.Parent.StopScript.Disabled = true
		Tool.Handle.Transparency = 0
		script.Parent.HealScript.Disabled=true
		Healing:Stop()
		Tool.Handle.Sound:Stop()
		Hold:Play()
		script.Parent.Parent.Humanoid.WalkSpeed=10
		script.Parent.Parent.RunScript.Disabled=false
		wait()
		script.Parent.HealScript.Disabled=false
  end
  end

Tool.Activated:Connect(ToolClicked)