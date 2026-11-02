local ape = 60

while ape >0 do
	
	wait(.05)
	ape = ape - 1
	local ape = math.abs(-.2,.2)
delay(0, function()
local r  = ape
local ran = math.random(-1, 1)
game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.CurrentCamera.Focus.p) * (game.Workspace.CurrentCamera.CoordinateFrame - game.Workspace.CurrentCamera.CoordinateFrame.p) * CFrame.Angles(r,  r*ran, 0) * CFrame.new(0, 0, (game.Workspace.CurrentCamera.Focus.p - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude)
local c = -r/20
local cx = -(r*ran)/20
for i = 1, math.random(5, 25) do
game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.CurrentCamera.Focus.p) * (game.Workspace.CurrentCamera.CoordinateFrame - game.Workspace.CurrentCamera.CoordinateFrame.p) * CFrame.Angles(c,  cx, 0) * CFrame.new(0, 0, (game.Workspace.CurrentCamera.Focus.p - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude)
wait()
end
end)


end

print("ending")
wait(2)
script:Destroy()