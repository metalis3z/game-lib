if game.PrivateServerOwnerId ~= 0 then return end

local take = false
local vaultRobCd = false

-------[[STATS]]--------
local goldPrice = 400 -- amount of cash you get when you sell gold
local cashPrice = 450 -- amount of cash you get when you click on money
local drillTime = 24 -- amount of time it takes for a drill to open the vault
local vaultOpenedTime = 60 -- how long the vault is open for
local proxReEnable = 420 -- time for the proximity prompt to re-enable after the door closes
------------------------

local gamePassOwners = {}
local MPS = game:GetService("MarketplaceService")
local doubleId = 104391994

local alreadyRobbed = {}

game.Players.PlayerAdded:Connect(function(p)
	if MPS:UserOwnsGamePassAsync(p.UserId,doubleId) then
		gamePassOwners[p] = true
	else
		if gamePassOwners[p] then
			gamePassOwners[p] = nil
		end
	end
end)

local alarm = game.Workspace.Alarm.sound

local vault = game.Workspace.vault
local Zone = require(game.Workspace.Zone)
local vzone = Zone.new(game.Workspace.InsideVault)

spawn(function()
	
	while wait(0.5) do
		
		if alarm.IsPlaying == true then
			
			for i,v in pairs(game.Workspace.AlarmLight:GetDescendants()) do
				
				if v:IsA("PointLight") or v:IsA("Beam") then
					
					v.Enabled = not v.Enabled
					
				end
				
			end
		else
			
			for i,v in pairs(game.Workspace.AlarmLight:GetDescendants()) do

				if v:IsA("PointLight") or v:IsA("Beam") then

					v.Enabled = false

				end

			end
		end
		
	end
	
end)

function openVaultDoor()
	alarm:Play()
	
	local hide1 = vault.door.doorHandle
	local hide2 = vault.door.doorHandleBack
	local hide3 = vault.keypad
	
	for i,v in pairs(hide1:GetChildren()) do
		v.Transparency = 1
		v.CanCollide = false
	end
	
	for i,v in pairs(hide2:GetChildren()) do
		v.Transparency = 1
		v.CanCollide = false
	end
	
	for i,v in pairs(hide3:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") or v:IsA("UnionOperation") then
			v.Transparency = 1
			v.CanCollide = false
		end
	end
	
	vault.door.metaldoor.vaultdoor:Play()
	game:GetService("TweenService"):Create(vault.door.metaldoor, TweenInfo.new(5), {CFrame = vault.door.metaldoorOpen.CFrame}):Play()
	
	take = true
	
	wait(vaultOpenedTime)
	
	closeVaultDoor()
end

function closeVaultDoor()
	alarm:Stop()
	
	take = false
	
	local hide1 = vault.door.doorHandle
	local hide2 = vault.door.doorHandleBack
	local hide3 = vault.keypad

	for i,v in pairs(hide1:GetChildren()) do
		v.Transparency = 0
		v.CanCollide = false
	end

	for i,v in pairs(hide2:GetChildren()) do
		v.Transparency = 0
		v.CanCollide = false
	end

	for i,v in pairs(hide3:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") or v:IsA("UnionOperation")  then
			v.Transparency = 0
			v.CanCollide = false
		end
	end

	vault.door.metaldoor.vaultdoor:Play()
	game:GetService("TweenService"):Create(vault.door.metaldoor, TweenInfo.new(5), {CFrame = vault.door.metalDoorClosed.CFrame}):Play()
	
	
	local inZone = vzone:getPlayers()
	print("kick out")
	for i,v in pairs(inZone) do
		print("entry")
		if v.Character then
			print("valid")
			v.Character:SetPrimaryPartCFrame(game.Workspace.KickOut.CFrame)
		end
		
	end
	
	wait(proxReEnable)
	
	vault.door.robPrompt.ProximityPrompt.Enabled = true
	
	for i,v in pairs(game.ServerStorage.TempStorage:GetChildren()) do
		v.Parent = game.Workspace
	end
	
	alreadyRobbed = {}
end

function drillShowing(show)
	
	if show == true then
		print("show drill")
		vault.DRILL.sound.drilling:Play()
		for i,v in pairs(vault.DRILL:GetChildren()) do
			v.Transparency = 0
		end
		
	else
		print("hide drill")
		vault.DRILL.sound.drilling:Stop()
		for i,v in pairs(vault.DRILL:GetChildren()) do
			v.Transparency = 1
		end
	end
	
end

vault.door.robPrompt.ProximityPrompt.Triggered:Connect(function(p)
	
	if p.Character:FindFirstChild("C4") then
		
		p.Character:FindFirstChild("C4"):Destroy()
		vault.door.robPrompt.ProximityPrompt.Enabled = false
		
		vault.door.metaldoor.explosion:Play()
		local explo = Instance.new("Explosion",vault.door.metaldoor)
		explo.BlastPressure = 0
		explo.DestroyJointRadiusPercent = 0
		explo.BlastRadius = 10
		explo.Position = vault.door.metaldoor.Position
		
		wait(0.5)
		
		openVaultDoor()
	elseif p.Character:FindFirstChild("Drill") then
		p.Character:FindFirstChild("Drill"):Destroy()

		vault.door.robPrompt.ProximityPrompt.Enabled = false
		
		drillShowing(true)
		
		wait(drillTime)
		
		drillShowing(false)

		openVaultDoor()
		
	end
	
end)

function giveDuffleBag(player)
	if not player.Character:FindFirstChild("DuffelBag") and not alreadyRobbed[player] then
		local bag = game.ReplicatedStorage.DuffelBag:Clone()
		
		if gamePassOwners[player] then
			bag.display.SurfaceGui.Frame.TextLabel.Text = "0/10"
		else
			bag.display.SurfaceGui.Frame.TextLabel.Text = "0/5"
		end
		
		player.Character.Humanoid:AddAccessory(bag)
	end
end

function sellGold(player)
	if player.Character:FindFirstChild("DuffelBag") and not alreadyRobbed[player] then
		alreadyRobbed[player] = true
		local duffleBag = player.Character:FindFirstChild("DuffelBag")
		local pricer = duffleBag:FindFirstChild("gold").Value * goldPrice
		
		player:FindFirstChild("stored"):FindFirstChild("Money").Value += pricer 		
		
		player.Character:FindFirstChild("DuffelBag"):Destroy()
	end
end

game.Workspace.dufflebagequip.ClickDetector.MouseClick:Connect(function(player)
	giveDuffleBag(player)
end)

game.Workspace.sellgold.ClickDetector.MouseClick:Connect(function(player)
	sellGold(player)
end)

function goldTake(p,model)
	if not p.Character:FindFirstChild("DuffelBag") then
		game.ReplicatedStorage.server:FireClient(p,"alert","You need a duffle bag to steal gold!")
		return
	else
		local duffleBag = p.Character:FindFirstChild("DuffelBag")
		local goldValue = duffleBag:FindFirstChild("gold").Value
		local maxGold = 5
		
		if gamePassOwners[p] then
			maxGold = 10
		end
		
		if goldValue >= maxGold then
			print("max gold!")
			game.ReplicatedStorage.server:FireClient(p,"alert","You have the max amount of gold in your duffle bag!")
			return
		else
			model:FindFirstChild("takeItem"):Play()
			model.Parent = game.ServerStorage.TempStorage	
			duffleBag:FindFirstChild("gold").Value = duffleBag:FindFirstChild("gold").Value + 1
			duffleBag.display.SurfaceGui.Frame.TextLabel.Text = duffleBag:FindFirstChild("gold").Value.."/"..tostring(maxGold)
		end
	end	
end

for i,v in pairs(game.Workspace.BankItems.Gold:GetChildren()) do
	
	v:FindFirstChild("ClickDetector").MouseClick:Connect(function(p)
		
		if take then
			goldTake(p,v)
		end
		
	end)
	
end

for i,v in pairs(game.Workspace.BankItems.Cash:GetChildren()) do

	v:FindFirstChild("ClickDetector").MouseClick:Connect(function(p)

		if take then
			v.Parent = game.ServerStorage.TempStorage	
			p:FindFirstChild("stored"):FindFirstChild("Money").Value += cashPrice 
		end	

	end)

end
