game.StarterGui.ResetPlayerGuiOnSpawn = false
old_fog = game.Lighting.FogStart
local MarketplaceService = game:GetService("MarketplaceService")

function getPlayerFromId(id)
	for i,v in pairs(game.Players:GetChildren()) do
		if v.userId == id then
			return v
		end
	end
	return nil
end
 
local epxlode = script.Explode
local siren = script.Siren

function tag(p, thing)
	local q = Instance.new('ObjectValue', p.Humanoid)
	q.Value = thing
	q.Name = "creator"
end

function nuke(sender)
	if script.In_Nuke.Value == false then
		print('NUKE INCOMING')
		script.In_Nuke.Value = true
			for i,v in pairs(game.Players:GetChildren()) do
			local q = siren:Clone()
			q.Parent = v.PlayerGui
			local expl = epxlode:Clone()
			expl.Parent = v.PlayerGui
			local scrip = script.Sirens:Clone()
			scrip.Parent = v.PlayerGui
			scrip.Disabled = false
			end
			repeat wait() until script.NukeA.Value == true
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Name == sender.Name then
				print('ur safe')
			else
				local ch = v.Character
					if ch then
						tag(ch, sender)
						wait()
						ch:BreakJoints()
					end
end
			end
			wait(1)
				game.Lighting.FogColor = Color3.new(100/255, 25/255,25/255)
	game.Lighting.FogEnd = 100
	wait(4)
	game.Lighting.FogEnd = 667
	game.Lighting.FogColor = Color3.new(191/255, 191/255,191/255)
	wait()
	script.In_Nuke.Value = false
	script.NukeA.Value = false
		end
	end

MarketplaceService.ProcessReceipt = function(receiptInfo)
	local productId = receiptInfo.ProductId
	local playerId = receiptInfo.PlayerId
	local player = getPlayerFromId(playerId)
	local productName 
	print('something has been purchased')
	if productId == 22339512 then
		productName = "$5,000"
		local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		if cashmoney then
			cashmoney.Value = cashmoney.Value + 5000
		end
	elseif productId == 22339514 then
		productName = "$25,000!"
		local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		if cashmoney then
			cashmoney.Value = cashmoney.Value + 25000
		end
	elseif productId == 22339544 then
		productName = "+25 HP"
		local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		game.ReplicatedStorage.MasterKey:FireClient(player,"PurchaseConfirm")
		local char = player.Character
		char.Humanoid.MaxHealth = char.Humanoid.MaxHealth + 25
		wait()
		char.Humanoid.Health = char.Humanoid.MaxHealth
	elseif productId == 22339545 then
		productName = "+10 Walkspeed"
		local char = player.Character
		if char then
			local human = char:FindFirstChild("Humanoid")
			if human then
				human.WalkSpeed = human.WalkSpeed + 10
			end
		end
	elseif productId == 22339542 then
		productName = "a Jetpack"
		game.Lighting.JetPack:Clone().Parent=player.Backpack
	elseif productId == 22350023 then
		productName = "a Tactical Nuke!"
		print('nuke!')
		nuke(player)
		print('nuke!')
		elseif productId == 22339541 then
		productName = "a MINIGUN!! WATCH OUT"
		game.Lighting.Minigun:Clone().Parent=player.Backpack
		elseif productId == 22381579 then
		productName = "a HeatSeeker"
		game.Lighting.HeatRocket:Clone().Parent=player.Backpack
	end
	
	local message = Instance.new("Hint",workspace)
	message.Text = player.Name.." purchased "..productName.."!"
	coroutine.resume(coroutine.create(function()
		wait(2)
		message:destroy()
	end))

	return Enum.ProductPurchaseDecision.PurchaseGranted		
end