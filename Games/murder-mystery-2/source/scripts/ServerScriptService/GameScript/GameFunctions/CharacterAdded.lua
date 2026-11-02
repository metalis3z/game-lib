local Gets = script.Parent.Parent.Get
local Set = script.Parent.Parent.Set;
local OutfitEvents = game.ReplicatedStorage.OutfitEvents
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local DataModule = require(script.Parent.Parent.DataModule);

local Module = function(Player,Character)
	pcall(function()
		coroutine.wrap(function()
			local loaded = Player:HasAppearanceLoaded()
			while not loaded do
				if not Player or not Player.Character then break end
				loaded = Player:HasAppearanceLoaded()
				task.wait()
			end

			if not loaded then return end
			Player.HealthDisplayDistance = 0;
			Player.NameDisplayDistance = 100;		

			if DataModule.TradingPlayers[Player] == true then --
				game.ServerStorage.TradingGUI:Clone().Parent = Character;
			end

			Player.Character.Humanoid.Died:connect(function()
				if Get("PlayerData")[Player.Name] ~= nil and not Get("PlayerData")[Player.Name]["Dead"] then

					local IsDead = Get("PlayerData")[Player.Name]["Dead"];	

					Get("GameMode").Died(Player);			

					Set.PlayerData:Fire(Player.Name,"Dead",true);

					if IsDead == false then
						if Get("PlayerData")[Player.Name]["Role"] == "Sheriff" and Get("GameMode").Name == "Classic" then
							Get("GameFunctions").GunDrop.Drop(Player,Get("PlayerData"));
						elseif Get("PlayerData")[Player.Name]["Role"] == "Hero" and Get("GameMode").Name == "Classic" then
							Get("GameFunctions").GunDrop.Drop(Player,Get("PlayerData"));
						end
					end;

					game.ReplicatedStorage.UpdatePlayerData:FireAllClients( Get("PlayerData") )

					if Get("GameMode").Coins then
						if Get("PlayerData")[Player.Name]["Coins"] > 1 then
							local DroppedCoins = Get("PlayerData")[Player.Name]["Coins"] - math.ceil(Get("PlayerData")[Player.Name]["Coins"]/2);
							Set.PlayerData:Fire(Player.Name,"Coins",math.ceil(Get("PlayerData")[Player.Name]["Coins"]/2));

							for i = 1,DroppedCoins do

								local NewCoin = game.ServerStorage.Coin:Clone();
								NewCoin.CFrame = (CFrame.new(Player.Character.UpperTorso.CFrame.p)+Vector3.new(math.random(1,5)/10,math.random(1,5)/10,math.random(1,5)/10)) * CFrame.Angles(math.pi/2, -math.pi/2, 0);
								NewCoin.Parent = Get("Map").CoinContainer;
								local DeathTimer = time();
								local TouchCon;
								TouchCon = NewCoin.Touched:connect(function(Toucher)
									if time()-DeathTimer > 0.25 then
										local Coiner = game.Players:GetPlayerFromCharacter(Toucher.Parent);
										if Coiner ~= nil and Coiner ~= Player then
											if Get("PlayerData")[Coiner.Name] ~= nil then
												if Get("PlayerData")[Coiner.Name]["Coins"] < Get("PlayerData")[Coiner.Name]["MaxCoins"] then
													TouchCon:disconnect();
													local Sound = game.ServerStorage.CoinSound:Clone();
													pcall(function()
														Sound.Parent = Coiner.Character.UpperTorso;
														Sound:Play();
													end)
													game.Debris:AddItem(Sound,3)
													NewCoin:Destroy();
													game.ReplicatedStorage.GetCoin:FireClient(Coiner);
													Set.PlayerData:Fire(Player.Name,"Coins",Get("PlayerData")[Coiner.Name]["Coins"] + 1);
													DataModule.Give(Coiner,"Credits",1);
												end
											end
										end
									end;
								end)
							end
						end;
					end

					if Player.Character.Humanoid:FindFirstChild("Creator") then
						pcall(function()
							local Killer = Player.Character.Humanoid.Creator.Value;
							if Get("PlayerData")[Killer.Name]["Role"] == "Murderer" then
								if Get("PlayerData")[Killer.Name]["Effect"] ~= "Ninja" then
							
									Player.Character.Head.Died:Play();
									local Sound = game.ServerStorage.Kill:Clone();
									Sound.Parent = Player.Character.UpperTorso;
									Sound:Play();
									game.Debris:AddItem(Sound,2)
								end;
							end
							game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"Melee Kill!")
							DataModule.Give(Killer,"XP",25);
						end);
					elseif Player.Character.Humanoid:FindFirstChild("Creator2") then
						pcall(function()
							local Killer = Player.Character.Humanoid.Creator2.Value;
							if Get("PlayerData")[Killer.Name]["Role"] == "Murderer" then
								if Get("PlayerData")[Killer.Name]["Effect"] ~= "Ninja" then
					
									Player.Character.Head.Died:Play();
									local Sound = game.ServerStorage.Kill:Clone();
									Sound.Parent = Player.Character.UpperTorso;
									Sound:Play();
									game.Debris:AddItem(Sound,2)
								end;
							end
							game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"Throwing Kill!")
							DataModule.Give(Killer,"XP",10);
						end);
					else
		
						Player.Character.Head.Died:Play();
					end;		

					wait(4)

					if Get("GameTimer") > -1 or Player.Character == nil or (Player.Character and Player.Character.Parent == nil) then
						if Player ~= nil then
							Player:LoadCharacter();
							OutfitEvents.SetAvatars:Fire(Player)
						end;
					end
				else
			
					Player.Character.Head.Died:Play();
					Player:LoadCharacter();
					OutfitEvents.SetAvatars:Fire(Player)
				end
			end)

			---------------------

			local HasRadio,CanUse = _G.CheckRadio(Player)
			local UseRadio = (HasRadio and CanUse);

			if UseRadio then 
				_G.WeldRadio(Player);
			end	

			_G.GivePet(Player);

			------- WELD WEAPONS
			local Effects = Get("Sync").Data["Effects"];
			local ItemsDB = Get("Sync").Data["Item"];
			local KnifeName = DataModule.Get(Player,"Weapons").Equipped.Knife;
			local EquippedKnife = game.ServerStorage.Default.Knife:Clone(); 
			local EquippedGun = game.ServerStorage.Default.Gun:Clone();
			local GunName = DataModule.Get(Player,"Weapons").Equipped.Gun;	
			pcall(function() EquippedKnife = game.InsertService:LoadAsset(ItemsDB[KnifeName]["ItemID"]):GetChildren()[1]; EquippedKnife.TextureId = ItemsDB[KnifeName].Image; end);
			pcall(function() EquippedGun = game.InsertService:LoadAsset(ItemsDB[GunName]["ItemID"]):GetChildren()[1]; end);
			require(script.Weld)(EquippedKnife.Handle);	
			require(script.Weld)(EquippedGun.Handle);	
			local EquippedEffect = DataModule.Get(Player,"Effects").Equipped[1];
			if Effects[EquippedEffect] ~= nil and EquippedEffect ~= "None" and EquippedEffect ~= "Dual" then
				if Effects[EquippedEffect]["KnifeModule"] then
					require(Effects[EquippedEffect]["KnifeModule"])(EquippedKnife);
				else
					require(Effects[EquippedEffect]["GunModule"] )(EquippedGun);
				end
			end

			local KnifeRotation = ItemsDB[KnifeName]["Angles"] 
			local RadioRotation = ItemsDB[KnifeName]["RadioAngles"]

			local KnifePosition = ItemsDB[KnifeName]["Offset"] 
			local RadioOffset = ItemsDB[KnifeName]["RadioOffset"];

			local Handle = EquippedKnife.Handle:Clone();

			EquippedKnife:Destroy();
			Handle.CanCollide = false;
			Handle.CFrame = Player.Character.UpperTorso.CFrame;
			local KnifeWeld = Instance.new("Weld",Player.Character.UpperTorso);
			KnifeWeld.Part0 = Player.Character.UpperTorso;
			KnifeWeld.Part1 = Handle;
            _G.WeldWeapons(Player)


			local DefaultRotation;
			local DefaultPosition;

			local function dAngles(Data)
				return CFrame.Angles(Data.X,Data.Y,Data.Z)
			end

			local function dOffset(Data)
				return CFrame.new(Data.X,Data.Y,Data.Z)
			end

			if not UseRadio  then 
				DefaultRotation = (KnifeRotation and dAngles(KnifeRotation)) or CFrame.Angles(-math.pi/2,math.pi/4,math.pi/2);

				DefaultPosition =(KnifeRotation and CFrame.new(0,0,0.5))or CFrame.new(-0.1,0,0.5);

				DefaultPosition = (KnifePosition and dOffset(KnifePosition)) or DefaultPosition;
			else
				DefaultPosition = (RadioOffset and dOffset(RadioOffset)) or CFrame.new(-1.2,-1.3,0.25);
				DefaultRotation = CFrame.Angles(math.rad(-60),0,math.rad(180));
				DefaultRotation = 
					(RadioRotation and dAngles(RadioRotation)	) 
					or 	(KnifeRotation and DefaultRotation * dAngles(KnifeRotation)	) 	
					or 	DefaultRotation;
			end;



			KnifeWeld.C0 =  DefaultPosition * DefaultRotation;

			KnifeWeld.C1 = CFrame.new();
			Handle.Name = "KnifeDisplay";
			Handle.Parent = Player.Character;

			local GunRotation = ItemsDB[GunName]["Angles"] 

			local Handle2 = EquippedGun.Handle:Clone();
			EquippedGun:Destroy();
			Handle2.CanCollide = false;
			Handle2.CFrame = Player.Character.UpperTorso.CFrame;
			local GunWeld = Instance.new("Weld",Player.Character.UpperTorso);
			GunWeld.Part0 = Player.Character.UpperTorso;
			GunWeld.Part1 = Handle2;
			if GunRotation ~= nil then
				GunWeld.C0 = CFrame.new(1.26,-1.5,0.2) * CFrame.Angles(GunRotation["X"],GunRotation["Y"],GunRotation["Z"])
			else
				GunWeld.C0 = CFrame.new(1.26,-1.5,0.2) * CFrame.Angles(math.rad(150),0,0)
			end;
			GunWeld.C1 = CFrame.new();
			Handle2.Name = "GunDisplay";
			Handle2.Parent = Player.Character;

		end)()
	end)
end


return Module;
