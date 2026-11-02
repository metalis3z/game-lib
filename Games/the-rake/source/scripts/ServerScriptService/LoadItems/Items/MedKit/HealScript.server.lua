local Tool = script.Parent
local Trap = nil
local debris = game:GetService("Debris")

Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end

	local targetPos = humanoid.TargetPoint
	local vCharacter = Tool.Parent
	wait(5)
	script.Parent.Parent.StopScript.Stop.Value = false
	script.Parent.Parent.StopScript.Disabled = true
	script.Parent.Parent.Head.HealSound:Play()
	script.Parent.Parent.Humanoid.Health =script.Parent.Parent.Humanoid.MaxHealth 
	script.Parent.Parent.Humanoid.WalkSpeed=10
	script.Parent.Parent.RunScript.Disabled=false
	Tool.Enabled = true
	Tool.Handle.Transparency = 1
	script.Parent.Heal.Value = false
	script.Parent.Healed.Value = true
	script.Parent.Handle.Sound:Stop()
	script.Parent.Bar.Value = 0
	wait()
    Tool:Destroy()
end

script.Parent.Activated:connect(onActivated)
