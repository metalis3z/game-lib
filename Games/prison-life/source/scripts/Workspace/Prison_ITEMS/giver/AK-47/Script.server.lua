Toolname = "AK-47"

function boop(Player)
 if not Player.Backpack:FindFirstChild(Toolname) then
  local Tool = game.ServerStorage[Toolname]:clone()
  Tool.Parent = Player.Backpack
 end
end
script.Parent.ClickDetector.MouseClick:Connect(boop)
