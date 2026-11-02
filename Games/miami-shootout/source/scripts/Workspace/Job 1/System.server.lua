local Settings = script.Parent.Settings

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

local claimTimes = {}
local strikes = {}

local function buildData(plr,action,info,topText,notify,index,custom,formatText)

	local data = {}
	data["player"] = plr
	data["action"] = action
	data["info"] = info 
	data["text"] = topText 
	data["topText"] = topText
	data["notify"] = notify

	if index and (index ~= nil and index ~= false) then
		data["index"] = index
	end

	if custom and custom ~= nil then
		data["custom"] = custom
	end

	if formatText and formatText ~= nil then
		data["formatText"] = formatText
	end

	return data		
end

script.Parent.DontDeleteTheseObjects.GetJobPart.ProximityPrompt.Triggered:Connect(function(plr)
	
	if _G.suspended[plr.UserId] then
		return print("SUSPENDED")
	end
	
	if GetDistance(plr.Character.PrimaryPart,script.Parent.DontDeleteTheseObjects.GetJobPart) > 10 then
		return print("Can't use this.")
	end
	
	if plr.Backpack:FindFirstChild("Package") then
		local youalreadyhaveajobgui = script.youalreadyhaveajobgui:Clone()
		youalreadyhaveajobgui.Parent = plr.PlayerGui
		wait(5)
		youalreadyhaveajobgui:Destroy()
	else
		if game.Workspace[plr.Name]:FindFirstChild("Package") then
			local youalreadyhaveajobgui = script.youalreadyhaveajobgui:Clone()
			youalreadyhaveajobgui.Parent = plr.PlayerGui
			wait(5)
			youalreadyhaveajobgui:Destroy()
		else
			local Package = script.Package:Clone()
			Package.Handle.Anchored = false
			Package.CardBoardBox.Transparency = 0
			if Settings.DirectionArrowEnabled.Value == false then
				Package.Handle.JobBeam.Transparency = NumberSequence.new(1, 1)
			end
			Package.Parent = game.Workspace[plr.Name]
			Package.LocalScript.Disabled = false
			claimTimes[plr] = time()
		end
	end
end)

script.Parent.DontDeleteTheseObjects.TargetPart.Touched:Connect(function(touchpart)
	if touchpart.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(touchpart.Parent.Name) then
		if GetDistance(touchpart.Parent.PrimaryPart,script.Parent.DontDeleteTheseObjects.TargetPart) > 10 then
			return print("Can't use this.")
		end
		
		if touchpart.Parent:FindFirstChild("Package") then
			if Settings.SoundEnabled.Value == true then
				script.Parent.DontDeleteTheseObjects.TargetPart.DeliveredSound.TimePosition = 0
				script.Parent.DontDeleteTheseObjects.TargetPart.DeliveredSound.Playing = true
			end
			touchpart.Parent.Package:Destroy()
			local Player = game.Players[touchpart.Parent.Name]
			if _G.suspended[Player.UserId] then
				return print("SUSPENDED")
			end
			
			local timeThatTook = time() - claimTimes[Player]
			if timeThatTook < 2.5 then
				print("exploiting, strike")
				if not strikes[Player.UserId] then
					strikes[Player.UserId] = 1
				else
					strikes[Player.UserId] = strikes[Player.UserId] + 1
				end

				if strikes[Player.UserId] > 3 then
					print("lol nice they exploitin")
					local OFFLOAD = buildData(Player,"Garbage Autofarm","Player has done 4+ garbage bags in a matter of 2.5 seconds, action taken: MONEY_SUSPENDED","%s was detected for possible autofarming, action: %s info: %s  (See exploitlogs for full info)",true,"autoFarmGarbage"..Player.UserId,true,true)
					game.ReplicatedStorage.AELog:Fire(OFFLOAD)
					_G.suspended[Player.UserId] = true
					return
				end
			end
			
			if Player:FindFirstChild("leaderboard") then
				if Player.leaderboard:FindFirstChild("Cash") then
					Player.leaderboard.Cash.Value += Settings.CashForPerDelivery.Value
				end
				if Player.leaderboard:FindFirstChild("Money") then
					Player.leaderboard.Money.Value += Settings.CashForPerDelivery.Value
				end
				if Player.leaderboard:FindFirstChild("Coins") then
					Player.leaderboard.Coins.Value += Settings.CashForPerDelivery.Value
				end
			end
			if Player:FindFirstChild("stored") then
				if Player.stored:FindFirstChild("Cash") then
					Player.stored.Cash.Value += Settings.CashForPerDelivery.Value
				end
				if Player.stored:FindFirstChild("Money") then
					Player.stored.Money.Value += Settings.CashForPerDelivery.Value
				end
				if Player.stored:FindFirstChild("Coins") then
					Player.stored.Coins.Value += Settings.CashForPerDelivery.Value
				end
			end
			if Settings.ParticlesEnabled.Value == true then
				script.Parent.DontDeleteTheseObjects.TargetPart.CoinSound.TimePosition = 0
				script.Parent.DontDeleteTheseObjects.TargetPart.CoinSound.Playing = true
				script.Parent.DontDeleteTheseObjects.TargetPart.MoneyParticles:Clone().Parent = game.Workspace[touchpart.Parent.Name].HumanoidRootPart
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles.Transparency = NumberSequence.new(0, 0)
				wait(0.2)
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles.Transparency = NumberSequence.new(0.2, 0.2)
				wait(0.2)
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles.Transparency = NumberSequence.new(0.4, 0.4)
				wait(0.2)
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles.Transparency = NumberSequence.new(0.6, 0.6)
				wait(0.2)
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles.Transparency = NumberSequence.new(0.8, 0.8)
				wait(0.2)
				game.Workspace[touchpart.Parent.Name].HumanoidRootPart.MoneyParticles:Destroy()
			end
		end
	end
end)