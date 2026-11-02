local target = workspace.asdf
local c = workspace.CurrentCamera
c.CameraType = Enum.CameraType.Scriptable
c.CameraSubject = target
local angle = 0
local i = 0
 function tweenCam(c1,f1,speed)
	local c0,f0 = c.CoordinateFrame,c.Focus
	for i = -90,90,speed do
		local r = ((math.sin(math.rad(i))+1)/2)
		c.CoordinateFrame = CFrame.new(c0.p:lerp(c1.p,r))
		c.Focus = CFrame.new(f0.p:lerp(f1.p,r))
		wait()
	end
end
if script.Parent.Parent:FindFirstChild('Donewe') then
else
	Instance.new('ForceField', script.Parent.Parent.Character)
tweenCam(game.Workspace.Focus1.CFrame, game.Workspace.Focus2.CFrame, 3)
Instance.new('Model',script.Parent.Parent).Name = "Donewe"
local a = script.GUI:Clone()
a.Parent = script.Parent
a.Script.Disabled = false
end