local SprintTrail = script.SpeedTrail:Clone()
repeat wait() until script.Parent:WaitForChild('Humanoid')
SprintTrail.Parent = script.Parent.UpperTorso
SprintTrail.Attachment0 = script.Parent.UpperTorso.NeckAttachment
SprintTrail.Attachment1 = script.Parent.UpperTorso.WaistRigAttachment
script.Toggle.OnServerEvent:Connect(function(Player,boolean)
	if Player == game.Players:GetPlayerFromCharacter(script.Parent) then
		if boolean then
			SprintTrail.Enabled = true
		elseif not boolean then
			SprintTrail.Enabled = false
		end
	end
end)