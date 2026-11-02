local Character = script.Parent
local Humanoid = Character:WaitForChild("NPC")
local tweenService = game:GetService("TweenService")
local Run = {WalkSpeed = 25}
local TweenInfoo = TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.In)
local WalkAnim = tweenService:Create(script.Parent.NPC,TweenInfoo,Run)
local Debounce = false

while true do
	wait()
	if script.Parent.NPC.Health < 990 and Character ~= nil and Debounce == false then
		Debounce = true
		script.Parent.NPC:MoveTo(workspace.EscapePart.Position)
		WalkAnim:Play()
		Debounce = false
	end
end