-- Reference copy for study. Game: the-rake
-- Original: StarterPlayer/StarterCharacterScripts/RunScript.client.lua  (LocalScript, 62 lines)
-- What it does: Shift to run via ContextActionService (with a mobile button), tween FOV 80 -> 90 while running, tell the server's stamina script, and drop back to walking when stamina hits 0.

wait(0.03)
local Player = game.Players.LocalPlayer
	local Character = workspace:WaitForChild(Player.Name)
local Humanoid = Character:WaitForChild('Humanoid')
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(0.7,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local RunFov = tweenService:Create(workspace.Camera,TweenInfoo,{FieldOfView = 90})
local WalkFov = tweenService:Create(workspace.Camera,TweenInfoo,{FieldOfView = 80})

Running = false
Debounce = false

function Handler(BindName, InputState)
	if InputState == Enum.UserInputState.Begin and BindName == 'RunBind' and Debounce == false then
		Running = true
		Humanoid.WalkSpeed = script.Parent.RunSpeed.Value
		RunFov:Play()
		script.Parent.StaminaBar.Running:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = true
	elseif InputState == Enum.UserInputState.End and BindName == 'RunBind' or script.Parent.StaminaBar.Stamina.Value < 1 then
		Running = false
		script.Parent.StaminaBar.Walking:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = false
		Humanoid.WalkSpeed = 10
		WalkFov:Play()
	end
end

Humanoid.Running:connect(function(Speed)
	if Speed >= 10 and Running and Debounce == false then
		Humanoid.WalkSpeed = script.Parent.RunSpeed.Value
		RunFov:Play()
		script.Parent.StaminaBar.Running:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = true
	elseif Speed >= 10 and not Running or script.Parent.StaminaBar.Stamina.Value < 1 then
		Humanoid.WalkSpeed = 10
		WalkFov:Play()
		script.Parent.StaminaBar.Walking:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = false
	elseif Speed < 10 or script.Parent.StaminaBar.Stamina.Value < 1 then
		Humanoid.WalkSpeed = 10
		WalkFov:Play()
		script.Parent.StaminaBar.Walking:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = false
	end
end)

game:GetService('ContextActionService'):BindAction('RunBind', Handler, true, Enum.KeyCode.LeftShift)
game:GetService('ContextActionService'):SetPosition("RunBind", UDim2.new(0.22, -10, 0.7, -25))
game:GetService('ContextActionService'):SetImage("RunBind", "rbxassetid://541620958")

while wait() do
	if script.Parent.StaminaBar.Stamina.Value < 1 then
		Humanoid.WalkSpeed = 10
		WalkFov:Play()
		script.Parent.StaminaBar.Walking:FireServer()
		script.Parent.BreathSounds.PlaySound.Value = false
		Debounce = true	
	elseif script.Parent.StaminaBar.Stamina.Value > 0 then
		Debounce = false
	end
end
