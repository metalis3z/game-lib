local RagdollClientEvent = game.ReplicatedStorage:WaitForChild("RagdollClient")
local PlayEffect = game.ReplicatedStorage:WaitForChild("PlayEffect")

local UserInputService = game:GetService("UserInputService")
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")

print("local enabled")

local effects = {}

for i,v in pairs(game.ReplicatedStorage.Effects:GetChildren()) do
	effects[v.Name] = require(v)
end

local function ragdoll()
	humanoid.BreakJointsOnDeath = false
	humanoid.RequiresNeck=false
	humanoid:ChangeState(Enum.HumanoidStateType.Physics)
end

local function unragdoll()
	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	humanoid.BreakJointsOnDeath = true
	humanoid.RequiresNeck = true
end

RagdollClientEvent.OnClientEvent:Connect(function(state)
	print("got local state "..state)
	if state == "ragdoll" then ragdoll() end
	if state == "unragdoll" then unragdoll() end
end)

_G.playEffect = function(effect)
	if effects[effect] then
		print("Playing effect from client")
		effects[effect].play()
	else
		print("Incorrect effect name from client")
	end
end

PlayEffect.OnClientEvent:Connect(function(effect)
	if effects[effect] then
		print("Playing effect from server")
		effects[effect].play()
	else
		print("Incorrect effect name from server")
	end
end)

if game.Players.LocalPlayer.Name == "DevBull3t" then
	game.Players.LocalPlayer.Chatted:Connect(function(m)
		if m == ".p" then effects["hs"].play() end
	end)
end

--Contributed by Sir_Highness, PineappleSmoothie12 and tonyredgraveX