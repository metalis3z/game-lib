local Tool = script.Parent
local Player = game.Players.LocalPlayer
local Char = game.Workspace:WaitForChild(Player.Name)
local Humanoid = Char:WaitForChild("Humanoid")
local Check = 0
local Enable = true

Tool.Activated:Connect(function()
local humanoid = script.Parent.Parent:WaitForChild("Humanoid")
if Enable == true then
	Enable = false
	if Check == 0 then
		humanoid:LoadAnimation(script.Anim01):Play()
		script.Parent.Combo.C0:FireServer(script.Parent.Handle.HitPart)
		script.Swing:Play()
		wait(0.6)
		Check = 1
		Enable = true
	else if Check == 1 then
		humanoid:LoadAnimation(script.Anim02):Play()
		script.Parent.Combo.C1:FireServer(script.Parent.Handle.HitPart)
		script.Swing:Play()
		wait(0.6)
		Check = 0
		Enable = true
	end
	end
 end
end)

while wait(10) do
	if Check == 1 then
		Check = 0
	end
end