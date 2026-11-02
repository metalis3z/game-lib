wait()
local Anim = game.ReplicatedStorage.ReplicatedAnimations.RakeBlindAnimation
local LoadAnim = script.Parent:FindFirstChild("NPC"):LoadAnimation(Anim)
local RandomSound = math.random(1,3)
AlreadyStun = false
if RandomSound == 1 then
script.Parent:FindFirstChild("Head").RakeHurt:Play()
elseif RandomSound == 2 then
script.Parent:FindFirstChild("Head").RakeHurt2:Play()
elseif RandomSound == 3 then
script.Parent:FindFirstChild("Head").RakeHurt3:Play()
end
LoadAnim:Play()
workspace.Blinded.Value = true
workspace.The_Rake.DamageScript.Disabled = true
workspace.The_Rake.HeavyDamageScript.Disabled = true
workspace.The_Rake.NPC.JumpPower = 0
for i = 1,8 do
if not LoadAnim.IsPlaying then
LoadAnim:Play()
end
game.Workspace.The_Rake.Configuration.RunSpeed.Value = 0
game.Workspace.The_Rake.Configuration.WalkSpeed.Value = 0
local StunDebounce = Instance.new("BoolValue",script.Parent)
StunDebounce.Name = "LatestStunDebounce"
game:GetService("Debris"):AddItem(StunDebounce,script.Parent.Configuration.StunTime.Value*1.25)
wait(0.3) --
end
if script.Parent:FindFirstChild("Configuration").StaticSoundVolume.Value > 0 then
script.Parent:FindFirstChild("Head").Static:Play()
end
LoadAnim:Stop()
workspace.Blinded.Value = false
workspace.The_Rake.DamageScript.Disabled = false
workspace.The_Rake.HeavyDamageScript.Disabled = false
workspace.The_Rake.NPC.JumpPower = 80
game.Workspace.The_Rake.Configuration.RunSpeed.Value = 25
game.Workspace.The_Rake.Configuration.WalkSpeed.Value = 12
wait()
script:Destroy()