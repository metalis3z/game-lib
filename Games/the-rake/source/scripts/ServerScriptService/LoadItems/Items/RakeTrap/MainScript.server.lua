repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Humanoid = script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Clicked = false
local PlantAnim = Humanoid:LoadAnimation(script.parent.Action)
local HoldAnim = Humanoid:LoadAnimation(script.parent.Idle)
local Tool = script.Parent
local Trap = nil
local debris = game:GetService("Debris")
local CanPlace = false

script.parent.Equipped:Connect(function()
	script.Parent.PlaceTrap.Disabled = false
	HoldAnim:Play()
end)

script.parent.Unequipped:Connect(function()
	script.Parent.PlaceTrap.Disabled = true
	script.Parent.Placing.Value = false
	PlantAnim:Stop()
	Tool.Handle.Sound:Stop()
	HoldAnim:Stop()
end)

function ToolClicked()
	if script.Parent.Placing.Value == false then
		script.Parent.Placing.Value = true
		script.Parent.Parent.StopScript.Stop.Value = true		
		script.Parent.Parent.StopScript.Disabled = false
		script.Parent.PlaceTrap.Disabled = false
		PlantAnim:Play()
		Tool.Handle.Sound:Play()
		script.Parent.Parent.Humanoid.WalkSpeed=0
		script.Parent.Parent.RunScript.Disabled=true
		HoldAnim:Stop()
	elseif script.Parent.Placing.Value == true then
		script.Parent.Placing.Value = false
		script.Parent.Parent.StopScript.Stop.Value = false
		script.Parent.Parent.StopScript.Disabled = true
		script.Parent.PlaceTrap.Disabled = true
		PlantAnim:Stop()
		Tool.Handle.Sound:Stop()
		if script.Parent.Placed.Value == false then
			HoldAnim:Play()
		end
		script.Parent.Parent.Humanoid.WalkSpeed=10
		script.Parent.Parent.RunScript.Disabled=false
		wait()
		script.Parent.PlaceTrap.Disabled=false
  end
  end

Tool.Activated:Connect(ToolClicked)