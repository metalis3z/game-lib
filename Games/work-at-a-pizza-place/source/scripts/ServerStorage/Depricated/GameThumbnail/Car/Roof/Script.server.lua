function touch(hit)
if hit.Position.y < 3 then
game.Workspace.Regen.Cars.Value = game.Workspace.Regen.Cars.Value - 1
script.Parent.Parent:remove()
end
end
script.Parent.Touched:connect(touch)

function remover(part)
if part.Name == "VehicleSeat" then
game.Workspace.Regen.Cars.Value = game.Workspace.Regen.Cars.Value - 1
script.Parent.Parent:remove()
end
end
script.Parent.Parent.ChildRemoved:connect(remover)

wait(math.random(500,600))
game.Workspace.Regen.Cars.Value = game.Workspace.Regen.Cars.Value - 1
script.Parent.Parent:remove()
