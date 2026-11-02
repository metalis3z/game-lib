local player = game.Players.LocalPlayer
local Tool2 = script.Parent:FindFirstChild("2")
local Mask2 = game.ReplicatedStorage:FindFirstChild("Mask1")
local Tool = script.Parent
local character = player.Character
local humanoid = character.Humanoid
local specialanim = humanoid:LoadAnimation(Tool.special)

Tool.Activated:connect(function()
   specialanim:Play()
   wait(1)
script.Parent.Namer:FireServer(player,character)
   script.Parent:FindFirstChild("1").Disabled = false
  Tool2.Disabled = true
end)
