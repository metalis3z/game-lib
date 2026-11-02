while true do
	wait()
	if script.Parent.Parent.StunTime.Value > 0 and script.Parent.Parent.Parent.NPC.Health > 0 then
repeat
	wait(1)
			script.Parent.Parent.StunTime.Value = script.Parent.Parent.StunTime.Value - 1
		until script.Parent.Parent.StunTime.Value == 0
	end
	end