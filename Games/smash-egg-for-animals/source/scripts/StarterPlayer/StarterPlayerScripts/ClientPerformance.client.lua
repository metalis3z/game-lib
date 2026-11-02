-- Gardien côté joueur de l'anti-triche (voir ServerScriptService.AntiCheatServer, qui vérifie tout avant d'agir).
-- Il signale seulement ce qui arrive au personnage de CE joueur : WalkSpeed / JumpHeight changées en local, forces de
-- déplacement ajoutées en local (fly), gravité changée en local, fin de la cinématique d'arrivée, et un signe de vie.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("ClientPerformance")

-- forces qui DÉPLACENT le personnage (celles qui ne font que le tourner sont ignorées : la caméra VR de Roblox en ajoute une)
local MOVERS = {BodyVelocity = true, BodyPosition = true, BodyForce = true, BodyThrust = true, LinearVelocity = true, AlignPosition = true, VectorForce = true}

local function watch(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end
	local function report() remote:FireServer("walk", humanoid.WalkSpeed, humanoid.UseJumpPower and humanoid.JumpPower / 7 or humanoid.JumpHeight) end
	humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(report)
	humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(report)
	humanoid:GetPropertyChangedSignal("JumpPower"):Connect(report)
	humanoid:GetPropertyChangedSignal("UseJumpPower"):Connect(report)
	character.DescendantAdded:Connect(function(d)
		if MOVERS[d.ClassName] then remote:FireServer("mover", d.ClassName, d.Name) end
	end)
end
player.CharacterAdded:Connect(watch)
if player.Character then task.spawn(watch, player.Character) end

workspace:GetPropertyChangedSignal("Gravity"):Connect(function() remote:FireServer("gravity", workspace.Gravity) end)

local function intro()
	local st = player:GetAttribute("IntroState")
	if st == "done" or st == "none" then remote:FireServer("intro") end
end
player:GetAttributeChangedSignal("IntroState"):Connect(intro)
intro()

while true do
	remote:FireServer("alive")
	task.wait(5)
end
