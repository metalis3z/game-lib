while true do
	wait()
	if workspace.Blinded.Value == true then
		script.Parent.NPC.JumpPower = 0
	elseif workspace.Blinded.Value == false then
	    script.Parent.NPC.JumpPower = 80
	end
end