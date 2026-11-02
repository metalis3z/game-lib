local Universal = {}

-- <- Public Functions -> --
function Universal.Crouch(Player: Player): ()
	local Character = Player.Character
	if not Character then
		return
	end
	
	local IsCrouching = Character:GetAttribute('Crouching') or false
	
	Character:SetAttribute('Crouching', not IsCrouching);
end

function Universal.Running(Player: Player, Value: boolean): ()
	local Character = Player.Character
	if not Character then
		return
	end
	
	Character:SetAttribute('Running', Value);
end

-- <- Return -> --
return Universal