
local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Paycheck = Global.Paycheck
local Houses = Global.Houses
local Players = Global.Players
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Tutorial = require(ServerScriptService:WaitForChild("Tutorial"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

print("Paycheck Dependencies loaded")

Paycheck.ManagerBonusPlayer = nil




function Paycheck:GiveCheck(player,Type)
	spawn(function()
		
		local playerData = Players[player]
		if playerData and not playerData.TutorialObject then
			
			
		
			while not playerData.StartedPlaying do
				wait(1)
			end
			
			wait(1)
			
			local amount =  (Type == "Moneyz Purchase Check" and playerData.PaycheckName ~= "" and Enums.Moneyz[playerData.PaycheckName].Amount) or
	 						(Type == "Paycheck" and playerData.Paycheck > 0 and playerData.Paycheck) or
							 Enums.Paychecks[Type] 
							
			if amount then
				workspace.Main.GivePaycheck:FireClient(player,amount,Type)
			end
		end
	end)
end


function Paycheck:GiveEveryonePaychecks()
	spawn(function()
		for _,player in ipairs(game.Players:GetPlayers()) do
			self:GiveCheck(player,"Paycheck")
			wait(2)
		end
	end)
end



local gotPaycheck = {}

game.Workspace.Main.GivePaycheck.OnServerEvent:connect(function(player,Type)
	
	local playerData = Players[player]
	
	if playerData  then
		
		if Type == "Paycheck" and playerData.Paycheck > 0 then
			playerData:AddMoneyz(playerData.Paycheck,true)
			playerData.Paycheck = 0
		
		elseif Type == "Daily Check" and tick() - playerData.Last_Played > 12 * 3600 then
			playerData:AddMoneyz(Enums.Paychecks[Type])
			playerData.Last_Played = tick()
		
		elseif Type == "Bonus Check from Manager" and player == Paycheck.ManagerBonusPlayer then
			playerData:AddMoneyz(Enums.Paychecks[Type],true)
			Paycheck.ManagerBonusPlayer = nil
			
		elseif Type == "Moneyz Purchase Check" and playerData.PaycheckName ~= "" then
			playerData:AddMoneyz(Enums.Moneyz[playerData.PaycheckName].Amount,true)
			playerData.PaycheckName = ""
			workspace.Main.SetWindowVisible:FireClient(player,"Catalog",true) --reopen the catalog after purchase
		
		elseif (Type == "Starter Check" and playerData.IsNewPlayer and not gotPaycheck[player]) then --if got startercheck
			playerData:AddMoneyz(Enums.Paychecks[Type])
			gotPaycheck[player] = true
		
			if not Enums.IsPartyServer then
				playerData.TutorialObject = Tutorial.new(player,1)
				if playerData.TutorialObject then
					playerData.TutorialObject:Start()
				end
			end
	
		end
	end
end)

--player might try to buy more moneyz before cash out and old check
workspace.Main.CheckForUncashedChecks.OnServerInvoke = function(player)
	local playerData = Players[player]
	if playerData  then
		if playerData.PaycheckName ~= "" then
			return true
		end
	end
end



return Paycheck


