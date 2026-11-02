local Gets = script.Parent.Parent.Get
_G.LeaderboardEndTime = 99999999999999;
local tweenservice = game:GetService("TweenService")
local CanSpawn = false
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

math.randomseed(tick());

local Data = require(script.Parent.Parent.DataModule);

local Set = script.Parent.Parent.Set.PlayerData;
game.ReplicatedStorage.CanSpawnCoins.Changed:Connect(function(val)
	if val == true then
		CanSpawn = true
	elseif val == false then
		CanSpawn = false
	end
end)
local module = function()
	local Map = Get("Map");
	local CoinObject
	CoinObject = Instance.new("Model");
	CoinObject.Name = "CoinContainer";
	CoinObject.Parent = Map;
	local CoinAreas = game.ServerStorage.Maps[Map.Name].CoinAreas:GetChildren();

	local GiftData = {};
	for _,Player in pairs(game.Players:GetPlayers()) do
		GiftData[Player.Name] = 0;
	end

	local CoinData = {};
	for _,Player in pairs(game.Players:GetPlayers()) do
		CoinData[Player.Name] = 0;
	end

	local coro = coroutine.create(function()


		while Get("GameTimer") > 1 and CanSpawn do

			if #CoinObject:GetChildren() < 250 then



				local Area = CoinAreas[math.random(1, #CoinAreas)];
				local X = math.random(-Area.Size.x / 2, Area.Size.x / 2);
				local Y = 0.5;
				local Z = math.random(-Area.Size.z / 2, Area.Size.z / 2);
				local Point = Area.CFrame:toWorldSpace(CFrame.new(X, Y, Z));
				local isXmas = false
				local IsGift = false--(math.random(1,3)==1);
				local Gifts = game.ServerStorage.Gifts:GetChildren();

				local NewCoin;
				if IsGift then
					NewCoin = Gifts[math.random(1,#Gifts)]:Clone();
					NewCoin.DestroyCoins.Disabled = false
					NewCoin.CFrame = CFrame.new(Point.p);
				elseif isXmas then
					NewCoin = game.ServerStorage.SnowToken:Clone();
					NewCoin.DestroyCoins.Disabled = false
					NewCoin.CFrame = CFrame.new(Point.p) * CFrame.Angles(math.pi/2, -math.pi/2, 0)
				else

					NewCoin = game.ServerStorage.Coin_Server:Clone();
					NewCoin.CFrame = CFrame.new(Point.p) * CFrame.Angles(math.pi/2, -math.pi/2, 0)
				end;
				NewCoin.Parent = CoinObject;

				local TouchCon;
				TouchCon = NewCoin.Touched:connect(function(Toucher)
					if CanSpawn then
						local Coiner = game.Players:GetPlayerFromCharacter(Toucher.Parent);
						local PlayerData = Get("PlayerData");
						if Coiner ~= nil then
							if PlayerData[Coiner.Name] ~= nil then

								if not IsGift and not isXmas then
									--if PlayerData[Coiner.Name]["Coins"] < PlayerData[Coiner.Name]["MaxCoins"] then
									if (CoinData[Coiner.Name] < 40) or (CoinData[Coiner.Name] < 50 and _G.CheckElite(Coiner)) or (CoinData[Coiner.Name] < 60 and _G.CheckMythic(Coiner)) or (CoinData[Coiner.Name] < 55 and _G.IsPremium(Coiner)) then
										NewCoin.Name = "CollectedCoin"
										TouchCon:disconnect();
										local Sound = game.ServerStorage.GiftSound:Clone();
										game.ReplicatedStorage.GetCoin:FireClient(Coiner);
										Data.Give(Coiner,"SummerTokens",3);
										Data.Give(Coiner,"Credits",15);
										--[[Data.Give(Coiner,"Credits",15);
										if _G.CheckMythic(Coiner) then
											Data.Give(Coiner,"Credits",15);
										end--]]
										CoinData[Coiner.Name] = CoinData[Coiner.Name] + 1;
										pcall(function()
											Sound.Parent = Coiner.Character.UpperTorso;
											Sound:Play();
										end)
										NewCoin.CanTouch = false


										game.Debris:AddItem(Sound,2)
										wait(0.4)
										NewCoin:Destroy();

									end
								elseif isXmas and not IsGift then
									if (CoinData[Coiner.Name] < 40) or (CoinData[Coiner.Name] < 50 and _G.CheckElite(Coiner)) then
										TouchCon:disconnect();
										local Sound = game.ServerStorage.CoinSound:Clone();
										NewCoin.BodyVelocity.Velocity = Vector3.new(0,10,0)
										NewCoin.BodyAngularVelocity.AngularVelocity = Vector3.new(0,23,0)
										local tweenservice = game:GetService("TweenService")
										local goal = {
											Transparency = 1
										}
										local Open = tweenservice:Create(NewCoin.Coin, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal)
										local Open2 = tweenservice:Create(NewCoin.MeshPart2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal)
										local Open3 = tweenservice:Create(NewCoin.MeshPart, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal)
										Open:Play()
										Open2:Play()
										Open3:Play()
										Data.Give(Coiner,"SnowCredits",1);
										CoinData[Coiner.Name] = CoinData[Coiner.Name] + 1;
										game.ReplicatedStorage.GetCoin:FireClient(Coiner);
										pcall(function()
											Sound.Parent = Coiner.Character.UpperTorso;
											Sound:Play();
										end)
										game.Debris:AddItem(Sound,3)
										wait(0.3)
										NewCoin:Destroy();

									end
								elseif not isXmas and IsGift then 
									if (GiftData[Coiner.Name] < 50) or (GiftData[Coiner.Name] < 60 and Coiner.MembershipType == Enum.MembershipType.Premium) then
										game.ReplicatedStorage.FadeCoin:FireAllClients(NewCoin)
										TouchCon:disconnect();
										local Sound = game.ServerStorage.GiftSound:Clone();
										Data.Give(Coiner,"Gift",1);
										Coiner.Candies.Value = 	Coiner.Candies.Value + 1
										GiftData[Coiner.Name] = GiftData[Coiner.Name] + 1;
										game.ReplicatedStorage.GetCoin:FireClient(Coiner);
										game.ReplicatedStorage.CollectGift:FireClient(Coiner);
										pcall(function()
											Sound.Parent = Coiner.Character.UpperTorso;
											Sound:Play();
										end)
										game.Debris:AddItem(Sound,3)
										wait(0.5)
										NewCoin:Destroy();

									end;

								end;
							end

						end
					end

				end)



			end

			wait(0.5);
		end



	end);
	coroutine.resume(coro);

end

return module
