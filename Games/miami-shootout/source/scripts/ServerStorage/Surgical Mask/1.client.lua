wait()
local player = game.Players.LocalPlayer
repeat wait() until player.Character~= nil
local character = player.Character
local humanoid = character.Humanoid
local Tool2 = script.Parent:FindFirstChild("1")
local Tool = script.Parent
local Mask2 = game.ReplicatedStorage:FindFirstChild("Mask1")
local specialanim = humanoid:LoadAnimation(Tool.special)


Tool.Activated:connect(function()
specialanim:Play()
   wait(1)
   script.Parent.Stranger:FireServer(player,character)
   script.Parent:FindFirstChild("2").Disabled = false
  Tool2.Disabled = true
end)
