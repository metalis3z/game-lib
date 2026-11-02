local Gets = script.Parent.Parent.Get
local Set = script.Parent.Parent.Set;

function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local DataModule = require(script.Parent.Parent.DataModule);

local Module = function(Player,Character)
	local function WeldAndEquip(Player)
		local char = Player.Character
		if not char then return end
		local humanoid = char:FindFirstChild("Humanoid")
		if not humanoid then return end

		local data = DataModule.GetDataTable()[Player.Name]
		if not data then return end

		local OutfitItem = data.Outfits.Equipped[1]

		if OutfitItem ~= nil then
			local outfitId = data.Outfits.OutfitId
			if outfitId and outfitId ~= 0 then
				local success, desc = pcall(function()
					return game.Players:GetHumanoidDescriptionFromUserId(outfitId)
				end)
				if success and desc then
					humanoid:ApplyDescription(desc)
				end
			end

			DataModule.ChangeOutfit(Player, OutfitItem)
		else
			local success, desc = pcall(function()
				return game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
			end)
			if success and desc then
				humanoid:ApplyDescription(desc)
			end
		end

		local HasRadio, CanUse = _G.CheckRadio(Player)
		if HasRadio and CanUse then 
			_G.WeldRadio(Player)
		end	

		_G.GivePet(Player)
		_G.WeldWeapons(Player)
	end


	Player.Character.HumanoidRootPart.CanCollide = false
	local humanoid = Player.Character:FindFirstChildOfClass("Humanoid") or Player.Character:WaitForChild("Humanoid", 5)
	if humanoid then
		humanoid.BreakJointsOnDeath = false
	end
	repeat wait(); until Player.Parent == game.Players and Player.Character ~= nil
	WeldAndEquip(Player)
	Player.HealthDisplayDistance = 0;
	Player.NameDisplayDistance = 100;
	Player.Backpack.ChildAdded:connect(function(Child)
		if Get("PlayerData")[Player.Name] ~= nil then
			if Get("PlayerData")[Player.Name]["Role"] == "Murderer" and Child:FindFirstChild("IsGun") then
				repeat Child:Destroy(); wait();
				until Child.Parent == nil;
			end;
		end
	end)		
	Player.Character.Humanoid.Died:connect(function()
		if Get("PlayerData")[Player.Name] ~= nil and not Get("PlayerData")[Player.Name]["Dead"] then
			local plosione = game.ServerStorage.Gameplay.ConfettiCannon:Clone()
			plosione.Parent = workspace
			plosione.Position = Player.Character.UpperTorso.Position
			game.Debris:AddItem(plosione,5)
			if Player.Character.Humanoid:FindFirstChild("Creator") then
				spawn(function()
					if require(script.Parent.StandardFunctions).CountAlive(Get("PlayerData")) <= 0 then	
						for i,bit in pairs(plosione:GetChildren()) do
							if bit:IsA("ParticleEmitter") then
								bit.Enabled = true
							end
						end
						wait(0.3)
						for i,bit in pairs(plosione:GetChildren()) do
							if bit:IsA("ParticleEmitter") then
								bit.Enabled = false
							end
						end
					end
				end)
				pcall(function()
					local Killer = Player.Character.Humanoid.Creator.Value;
					DataModule.GiveStatus(Killer,"Murderer")
					if Get("PlayerData")[Killer.Name]["Effect"] ~= "Ninja" then
						local Sound = game.ServerStorage.Sounds.Kill:Clone();
						Sound.Parent = Killer.Character.UpperTorso;
						Sound:Play();
						game.Debris:AddItem(Sound,2)
					end;
				end);
			elseif Player.Character.Humanoid:FindFirstChild("Creator2") then
				spawn(function()
					if require(script.Parent.StandardFunctions).CountAlive(Get("PlayerData")) <= 0 then	
						spawn(function()
							for i,bit in pairs(plosione:GetChildren()) do
								if bit:IsA("ParticleEmitter") then
									bit.Enabled = true
								end
							end
							wait(0.3)
							for i,bit in pairs(plosione:GetChildren()) do
								if bit:IsA("ParticleEmitter") then
									bit.Enabled = false
								end
							end
						end)
					end
				end)
				local Killer = Player.Character.Humanoid.Creator2.Value;
				Get("PlayerData")[Killer.Name]["Eliminations"] += 1 
				DataModule.GiveStatus(Killer,"Murderer")
				if Get("PlayerData")[Killer.Name]["Effect"] ~= "Ninja" then
					pcall(function() 
						local Sound = game.ServerStorage.Sounds.Kill:Clone();
						Sound.Parent = Killer.Character.UpperTorso;
						Sound:Play();
						game.Debris:AddItem(Sound,2)
					end)
				end;
			end
			Get("GameMode").Died(Player);			

			Set.PlayerData:Fire(Player.Name,"Dead",true);

			game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients( Get("PlayerData") )

			pcall(function() 

				if Player.Character.Humanoid:FindFirstChild("Creator") then
					local Killer = Player.Character.Humanoid.Creator.Value;
					--	DataModule.Give(Killer,"NewXP",250);
				elseif Player.Character.Humanoid:FindFirstChild("Creator2") then
					local Killer = Player.Character.Humanoid.Creator2.Value;
					--	DataModule.Give(Killer,"NewXP",100);
				else
				end;	
			end)	

			wait(9)

			if Get("GameTimer") > -1 or Player.Character == nil or (Player.Character and Player.Character.Parent == nil) then
				if Player ~= nil then
					Player:LoadCharacter();
					WeldAndEquip(Player)
					game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard:FireAllClients();
				end;
			end
		else
			Player:LoadCharacter();
			WeldAndEquip(Player)
			game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard:FireAllClients();
		end
	end)


end

return Module;
