local v1 = script.Parent
local v2 = game.Players.LocalPlayer
repeat
	task.wait()
until v2.Character
local v_u_3 = v2.Character:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(script:WaitForChild("UseAnim"))
v1.Activated:Connect(function()
	if not v_u_3.IsPlaying then
		v_u_3:Play()
	end
end)
