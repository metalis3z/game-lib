local Missile = script.Parent
local Tracker = Missile.Tracker
local BV = Missile.BodyVelocity
-------------------------------------------
while true do
	if Tracker.Value then
		if Tracker.Value.Parent == game.Workspace then
			Missile.CFrame = CFrame.new(Missile.Position,Tracker.Value.Position)
			BV.velocity = Missile.CFrame.lookVector * 1500
		elseif Tracker.Value.Parent == game.Lighting then
			break
		end
	end
	wait()
end