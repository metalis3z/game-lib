local remote = game:GetService("ReplicatedStorage"):WaitForChild("Inventory")

local mps = game:GetService("MarketplaceService")
local doubleSafes = {}
local cache = require(game.ServerScriptService.ProfileCache)
local Notify = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

game.Players.PlayerAdded:Connect(function(p)
	if mps:UserOwnsGamePassAsync(p.UserId, 800113546) or mps:UserOwnsGamePassAsync(p.UserId, 714929470) then
		doubleSafes[p] = true
	end
	
end)

local debounces = {}

local col = game:GetService("CollectionService")
_G.combatTimers = {}

local combatTimer = 10

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

local verif = {}
local lastDb = {}

local blacklist = {"Fist", 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool','CashL', 'CashM', 'CashS', 'CashXL', 'CashXS'}

remote.OnServerEvent:Connect(function(plr, val, itemName, location, safeModel, toolExact)
	
	if game.PrivateServerOwnerId ~= 0 then
		return  Notify:FireClient(plr, 'Cant access safe in private server', 3)
	end
	
	if table.find(blacklist,itemName) and plr.Team ~= game.Teams.PD then
		for i,v in pairs(plr:FindFirstChild("InvData"):GetChildren()) do
			if table.find(blacklist,v.Name) then
				v:Destroy()
			end
		end
		if plr.Character:FindFirstChild(itemName) then
			plr.Character:FindFirstChild(itemName):Destroy()
		end
		for i,v in pairs(plr.Backpack:GetChildren()) do
			if table.find(blacklist,v.Name) then
				v:Destroy()
			end
		end
		return
	end
	
	if lastDb[plr] == itemName then
		return 
	end
	
	local found = game:GetService("ServerStorage"):FindFirstChild(itemName)
	lastDb[plr] = itemName
	delay(.4,function()
		lastDb[plr] = nil
	end)
	
	if safeModel then
		local distanceBetweenTheTwo = GetDistance(plr.Character.PrimaryPart,safeModel)
	
		if distanceBetweenTheTwo > 7 then
			return Notify:FireClient(plr, 'Cant access safe from far distances', 3)
		end
	else
		return Notify:FireClient(plr, 'Cant access safe', 3)
	end	
	
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		local human = plr.Character:FindFirstChild("Humanoid")
		
		if col:HasTag(plr,"cuffed") then
			return Notify:FireClient(plr, 'Cant access safe while handcuffed', 3)
		end
		if _G.combatTimers[human] then
			local timeLeft = string.gsub(tostring(math.round(_G.combatTimers[human] - time())),"-","")
			if tonumber(timeLeft) <= tonumber(combatTimer) then return Notify:FireClient(plr, "Can't access safe while in combat ("..timeLeft.."/"..combatTimer.." seconds left)!", 3) end
		end
		if human.Health == 0 then
			return Notify:FireClient(plr, 'Cant access safe while dead', 3)
		end
	end	
		
	if val == "Change" then
		if location == "Backpack" and not debounces[plr.UserId] then
			if not found then return end
			local playerMax = 10
			
			if doubleSafes[plr] then
				playerMax = 20
			end

			local INVENTORY = plr:WaitForChild("InvData"):GetChildren()

			if #INVENTORY >= playerMax then return end
			
			debounces[plr.UserId] = true
			delay(.4,function()
				debounces[plr.UserId] = false
			end)
			local find = plr.Backpack:FindFirstChild(itemName)
			if find and not find:FindFirstChild("Rank") and not find:FindFirstChild('POLICE') and not find:FindFirstChild('RedeemScript') then
				if verif[find] then
					return
				end
				verif[find] = true
				find:Destroy()
				local x = Instance.new("IntValue", plr:WaitForChild("InvData"))
				x.Name = itemName
				if plr.PlayerGui:FindFirstChild('Safe') then
					plr.PlayerGui.Safe.Frame.Amount.Text = #INVENTORY .. '/' .. playerMax
				end
			end
		elseif location == "Inv" and not debounces[plr.UserId] then
			debounces[plr.UserId] = true
			delay(.4,function()
				debounces[plr.UserId] = false
			end)
			local find = game:GetService("ServerStorage"):FindFirstChild(itemName)
			if find and not table.find(blacklist,find.Name) then
				local get = plr:WaitForChild("InvData"):FindFirstChild(itemName)
				if not get then return end
				get:Destroy()
				find:Clone().Parent = plr.Backpack
				local playerMax = 10

				if doubleSafes[plr] then
					playerMax = 20
				end
				if plr.PlayerGui:FindFirstChild('Safe') then
					plr.PlayerGui.Safe.Frame.Amount.Text = #plr:WaitForChild("InvData"):GetChildren() .. '/' .. playerMax
				end
			end
		end
	end
end)