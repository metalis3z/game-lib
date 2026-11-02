local v_u_1 = game.Players.LocalPlayer
local v_u_2 = v_u_1:GetMouse()
local v_u_3 = script.Parent
repeat
	task.wait()
until v_u_1.Character
local v_u_4 = v_u_1.Character:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(script:WaitForChild("Throw"))
local v_u_5 = require(script.Parent:WaitForChild("MakeBalloon"))
local v_u_6 = -1
v_u_3.Activated:Connect(function()
	if os.clock() - v_u_6 >= 3 then
		v_u_4:Play()
		v_u_6 = os.clock()
		task.wait(0.7)
		local v7 = v_u_3.Handle.Position
		local v8 = v_u_2.Hit.Position
		script.Parent.Remote:FireServer(v7, v8)
		v_u_5(v_u_1.Character, v7, v8)
	end
end)
