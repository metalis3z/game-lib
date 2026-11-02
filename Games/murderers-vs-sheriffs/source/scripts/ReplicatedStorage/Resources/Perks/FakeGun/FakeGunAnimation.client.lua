-------------------------- << SNIPER HOLD >> ------------------------------------
local gHoldAnim = Instance.new("Animation")
gHoldAnim.AnimationId = "rbxassetid://131108855357502"
--------------------------------------------------------------------------------------
local gAnimTrack
script.Parent.Equipped:Connect(function()
	local tool = script.Parent
	local character = tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	local animator = humanoid:FindFirstChildOfClass("Animator") 
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	gAnimTrack = animator:LoadAnimation(gHoldAnim)
	if tool.Handle:FindFirstChild("IsGingerscope") then
		gAnimTrack:Play()
	end
	tool.Unequipped:Connect(function()
		if gAnimTrack and tool.Handle:FindFirstChild("IsGingerscope") then
			gAnimTrack:Stop()
		end
	end)
end)