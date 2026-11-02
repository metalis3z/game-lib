local Tool = script.Parent
local IsUsing = false
local LickSound = Tool:WaitForChild("Handle"):WaitForChild("LickSound")
local CanActivate = true
local AnimationTrack = nil

local function onEquipped()
	CanActivate = true
end

local function onActivated()
	if IsUsing or not CanActivate then
		return
	end

	IsUsing = true
	CanActivate = false

	local Character = Tool.Parent
	local Humanoid = Character:FindFirstChild("Humanoid")

	if Humanoid then
		local Animation = script:FindFirstChild("UseAnim")
		if Animation then
			AnimationTrack = Humanoid:LoadAnimation(Animation)
			AnimationTrack:Play()
		end

		LickSound:Play()

		task.wait(0.3)
		IsUsing = false

		task.wait(2)
		if AnimationTrack then
			AnimationTrack:Stop()
		end
	end

	CanActivate = true
end

local function onUnequipped()
	if AnimationTrack then
		AnimationTrack:Stop()
	end
	IsUsing = false
end

Tool.Equipped:Connect(onEquipped)
Tool.Unequipped:Connect(onUnequipped)
Tool.Activated:Connect(onActivated)