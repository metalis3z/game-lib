Toolname = "M9"

function boop(Player)
 if not Player.Backpack:FindFirstChild(Toolname) then
  local Tool = game.ServerStorage[Toolname]:clone()
		Tool.Parent = Player.Backpack
		wait(0.5)
		script.Parent:Destroy()
 end
end
script.Parent.ClickDetector.MouseClick:Connect(boop)
