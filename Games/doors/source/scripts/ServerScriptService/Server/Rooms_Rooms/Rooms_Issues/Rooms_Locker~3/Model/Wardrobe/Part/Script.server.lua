local Hiding = false
local HidingPos = script.Parent.Parent.HidePosition
local ExitPos = script.Parent.Parent.ExitPosition
local sc = script.LockerClose
local so = script.LockerOpen
function Hide(Clicker)
	if Hiding == false and Clicker.Character.Humanoid.Health >= 1 then
		Hiding = true
		so:Play()
		workspace.CurrentCamera.CameraSubject = Clicker.Character.Head
		Clicker.Character.HumanoidRootPart.Anchored = true
		Clicker.Character.HumanoidRootPart.CFrame = CFrame.new(HidingPos.Position, ExitPos.Position)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://6534522042"
		Anim.Name = "Enter"
		Anim.Parent = Clicker.Character
		local Hum = Clicker.Character.Humanoid:LoadAnimation(Clicker.Character.Enter)
		Hum:Play()
		wait(0.8)
		local Anim2 = Instance.new("Animation")
		Anim2.AnimationId = "rbxassetid://6534399775"
		Anim2.Name = "Hiding"
		Anim2.Parent = Clicker.Character
		local Hum = Clicker.Character.Humanoid:LoadAnimation(Clicker.Character.Hiding)
		Hum:Play()
	elseif Hiding == true then
		sc:Play()
		local Hum = Clicker.Character.Humanoid:LoadAnimation(Clicker.Character.Hiding)
		Hum:Stop()
		local Anim3 = Instance.new("Animation")
		Anim3.AnimationId = "rbxassetid://6555451457"
		Anim3.Name = "Leave"
		Anim3.Parent = Clicker.Character
		local Hum = Clicker.Character.Humanoid:LoadAnimation(Clicker.Character.Leave)
		Hum:Play()
		workspace.CurrentCamera.CameraSubject = Clicker.Character.Humanoid
		Clicker.Character.HumanoidRootPart.Anchored = false
		Clicker.Character.HumanoidRootPart.CFrame = CFrame.new(ExitPos.Position, HidingPos.Position)
		Hiding = false
	end
end

script.Parent.ProximityPrompt.Triggered:Connect(Hide)