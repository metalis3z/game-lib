script.Parent.Check.OnServerInvoke = function(Player: Player): ()
	if Player:GetAttribute('Donttriggerlol') then
		Player:SetAttribute('Donttriggerlol', nil);
		
		return true
	end
	
	return false
end

script.Parent.RemoteEvent.OnServerEvent:Connect(function(Player: Player, Bool: boolean): ()
	if not Bool then
		return
	end
	
	warn('Hm')
	
	if Player:GetAttribute('LOADED') ~= true then
		Player:SetAttribute('LOADED', true);
		Player:AddTag('LOADED')
	end
end)