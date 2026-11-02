Toolname = "Potato chips"

function boop(Player)
 if not Player.Backpack:FindFirstChild(Toolname) then
  local Tool = game.ServerStorage[Toolname]:clone()
  Tool.Parent = Player.Backpack
 end
end
script.Parent.cd.MouseClick:Connect(boop)
