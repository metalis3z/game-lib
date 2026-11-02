--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = {
	7627847305,
	71552399,
	8095632868,
	1755750680,
	355661302,
	9568431755,
	1787623041,
	6785965,
	4925297398,
	1848784060,
	1836038679,
	7805349940,
	1833666230,
	2882755487,
	2213470865,
	5455502981,
	95217455
}

local function IsAllowed(p1) --[[ IsAllowed | Line: 22 | Upvalues: RunService (copy), t (copy) ]]
	if RunService:IsStudio() then
		return true
	end

	if p1.UserId == game.CreatorId then
		return true
	end

	if table.find(t, p1.UserId) then
		return true
	end

	return game.PlaceId == 1
end

return {
	StartOrder = 10,
	Init = function(p1) --[[ Init | Line: 32 | Upvalues: Players (copy), RunService (copy), t (copy), ReplicatedStorage (copy) ]]
		if not (if RunService:IsStudio() or Players.LocalPlayer.UserId == game.CreatorId or table.find(t, Players.LocalPlayer.UserId) then true else game.PlaceId == 1) then
			return
		end

		local topbarplus = require(ReplicatedStorage.ClientModules.topbarplus)
		local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient", 10)

		if CmdrClient then
			local v2 = require(CmdrClient)

			-- Cmdr bloquea TODO comando en el juego publicado si no hay un hook
			-- BeforeRun configurado (en Studio no bloquea). Registramos uno no-op:
			-- el GUI ya esta gated a admins por IsAllowed, y el servidor revalida
			-- admin en ServerScriptService.CmdrPetCommands antes de conceder nada.
			pcall(function()
				if v2.Registry and v2.Registry.RegisterHook then
					v2.Registry:RegisterHook("BeforeRun", function()
						return nil
					end)
				end
			end)

			local v3 = topbarplus.new()

			v3:setName("CmdrIcon")
			v3:setLabel("Cmdr")
			v3:setRight()
			v3:setOrder(100)
			v3:setCaption("Toggle command console (F2)")
			v3:bindToggleKey(Enum.KeyCode.F2)
			v3.deselectWhenOtherIconSelected = false
			v3.selected:Connect(function() --[[ Line: 53 | Upvalues: v2 (copy) ]]
				v2:Show()
			end)
			v3.deselected:Connect(function() --[[ Line: 57 | Upvalues: v2 (copy) ]]
				v2:Hide()
			end)
			v2:SetActivationKeys({})
		end
	end,
	Start = function(p1) --[[ Start | Line: 64 ]] end
}
