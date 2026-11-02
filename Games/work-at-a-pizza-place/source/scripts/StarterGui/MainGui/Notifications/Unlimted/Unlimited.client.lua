--[[local currentTick = 1459881318
local newTypes = {Monkey = true, Cat = true, Jellyfish = true}

if currentTick + (604800) > tick() then -- one week
	while not _G["StartedPlaying"] do wait(1) end
	wait(10)
	local petData = workspace.PetService.GetPetData:InvokeServer()
	if petData and #petData > 0 then
		
		--set if player already owns new pet breed
		for _,pet in ipairs(petData) do
			if newTypes[pet.Type] then
				return
			end
		end
		script.Parent.Visible = true
	end
	
	
end]]