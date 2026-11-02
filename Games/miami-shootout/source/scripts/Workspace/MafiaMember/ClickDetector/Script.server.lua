local jobMoney = {}

local MONEYGIVEN = 150

game.Workspace.RedCarArrow.Transparency = 1

-- marker transparency = 1 invisible (false) transparency = 0 visible (true)

local rep = game.ReplicatedStorage.server

local claimTimes = {}
local strikes = {}
_G.suspended = {}

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

script.Parent.MouseClick:Connect(function(p)	
	if not jobMoney[p] then
		p.Character.HumanoidRootPart.Anchored = true
		rep:FireClient(p,"marker",0)
		rep:FireClient(p,"lmsg","Click the boxes to get a box, Place it where it says Place Here.")
		wait(8)
		rep:FireClient(p,"lmsg","For each box, you're given $"..MONEYGIVEN..". After you're done, come back to me for ur pay check.")
		p.Character.HumanoidRootPart.Anchored = false
	else
		rep:FireClient(p,"marker",1)
		rep:FireClient(p,"msg","You made $"..jobMoney[p]..".")
		
		local wal = p:FindFirstChild("stored"):FindFirstChild("Money")
		wal.Value = wal.Value + jobMoney[p]
		
		jobMoney[p] = nil
	end	
end)

game.Workspace.CarHB.Touched:Connect(function(t)
	if t.Parent and t.Parent:FindFirstChild("Humanoid") then
		if game.Players:FindFirstChild(t.Parent.Name) and t.Parent:FindFirstChild("Box") then			
			local box = t.Parent:FindFirstChild("Box")
			
			if box and not box:FindFirstChild("SANCTIONED") then
				local plrs = game.Players:FindFirstChild(t.Parent.Name)
				local OFFLOAD = buildData(plrs,"Boxes Autofarm","Player has used an unauthorized box, action taken: MONEY_SUSPENDED","%s was detected for VERY LIKELY autofarming, action: %s info: %s  (See exploitlogs for full info)",true,"autoFarmBoxes2"..plrs.UserId,true,true)
				_G.suspended[plrs.UserId] = true
				return
			end
			
			if box then
				local plrs = game.Players:FindFirstChild(t.Parent.Name)
				if _G.suspended[plrs.UserId] then
					return print("suspended")
				end

				t.Parent.Humanoid:UnequipTools()
				box:Destroy()
				if jobMoney[plrs] then
					rep:FireClient(plrs,"money","+$"..MONEYGIVEN)
					jobMoney[plrs] = jobMoney[plrs] + MONEYGIVEN
				else
					rep:FireClient(plrs,"money","+$150")
					jobMoney[plrs] = 150
				end	
				
				local timeThatTook = time() - claimTimes[plrs]
				if timeThatTook < 4.5 then
					print("exploiting, strike")
					if not strikes[plrs.UserId] then
						strikes[plrs.UserId] = 1
					else
						strikes[plrs.UserId] = strikes[plrs.UserId] + 1
					end
					
					if strikes[plrs.UserId] > 3 then
						print("lol nice they exploitin")
						local OFFLOAD = buildData(plrs,"Boxes Autofarm","Player has done 4+ boxes in a matter of 2.5 seconds, action taken: MONEY_SUSPENDED","%s was detected for possible autofarming, action: %s info: %s  (See exploitlogs for full info)",true,"autoFarmBoxes"..plrs.UserId,true,true)
						game.ReplicatedStorage.AELog:Fire(OFFLOAD)
						_G.suspended[plrs.UserId] = true
						jobMoney[plrs] = nil
					end
				end
					
				claimTimes[plrs] = nil
			end	
		end
	end
end)

local boxes = game.Workspace["Lower Garage Boxes"]

boxes.ClickDetector.MouseClick:Connect(function(p)
	if p.Character and not p.Character:FindFirstChild("Box") and not p.Backpack:FindFirstChild("Box") then
		claimTimes[p] = time()
		local box = game.ReplicatedStorage.Box:Clone()
		box.Parent = p.Backpack
		Instance.new("NumberValue",box).Name = "SANCTIONED"
		if p.Backpack:FindFirstChild("Box") then
			p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Box"))
		end
	end
end)