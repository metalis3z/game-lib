local whitelisted = {
	['IJayd_nbeast'] = true,
	['RealSavagebeast5456'] = true,
	['BxJ524'] = true,
	['RhavizinNxtrixz'] = true,
	['ChampulseV0'] = true,
}
local friends = {
	['GoatedNxtrixz'] = true,
}
local GAMEPASS_IDS = {
	['Elite'] = {120067201},
	['Radio'] = {120068667},
}

--local player = game:GetService("Players")

function ownsPass(id, player)
	if whitelisted[player.UserId] or friends[player.UserId] == true then 
		return true 
	end 
	local s,e = pcall(function()
		return game:GetService('MarketplaceService'):UserOwnsGamePassAsync(player.UserId, id)
	end)
	if e == true then 
		return true 
	end
	return false 
end

local player = game:GetService("Players")

for i, v in next, GAMEPASS_IDS.Elite do 
	if ownsPass(v) then 
		_G.GiveGamePassElite(player)
	end
end

for i, v in next, GAMEPASS_IDS.Radio do 
	if ownsPass(v) then 
		_G.GiveGamePassRadio(player)
	end
end