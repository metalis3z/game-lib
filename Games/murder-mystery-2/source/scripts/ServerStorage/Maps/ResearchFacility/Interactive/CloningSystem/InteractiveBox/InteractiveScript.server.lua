local TweenService = require(game.ReplicatedStorage.ReplicatedTweening)
local TouchingPlayers = {}
local Main = script.Parent.Parent
local debounce = false
script.Parent.Parent.CloningChamber1.TorsoScanner.Touched:Connect(function(TouchPart)
	if game.Players:GetPlayerFromCharacter(TouchPart.Parent) and TouchPart.Name == "UpperTorso" then
		if not table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent)) then
			table.insert(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent))
		end
	end
end)
script.Parent.Parent.CloningChamber1.TorsoScanner.TouchEnded:Connect(function(TouchPart)
	if game.Players:GetPlayerFromCharacter(TouchPart.Parent) and TouchPart.Name == "UpperTorso" then
		if table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(TouchPart.Parent)) then
			for Index,Table in pairs(TouchingPlayers) do
				if Table == game.Players:GetPlayerFromCharacter(TouchPart.Parent) then
					table.remove(TouchingPlayers,Index)
				end
			end
		end 
	end
end)
script.Parent.Interact.OnServerEvent:Connect(function(player)
	if not debounce then
		debounce = true
		TweenService:GetTweenObject(Main.CloningChamber1.Visual,TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = Main.CloningChamber1.VisualClosed.CFrame}):Play()
		TweenService:GetTweenObject(Main.CloningChamber1.Collision,TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = Main.CloningChamber1.CollisionFull.CFrame}):Play()
		wait(2)
		TweenService:GetTweenObject(Main.CloningChamber1.Liquid,TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{CFrame = Main.CloningChamber1.LiquidFull.CFrame}):Play()
		wait(8)
		if TouchingPlayers[1] and not TouchingPlayers[2] then
			TouchingPlayers[1].Character.HumanoidRootPart.CFrame = script.Parent.Parent.RandomTeleport.CFrame
		elseif TouchingPlayers[1] and TouchingPlayers[2] then
			for Index,Player in pairs(TouchingPlayers) do
				Player.Character.Humanoid:TakeDamage(9999)
			end
		end
		TweenService:GetTweenObject(Main.CloningChamber1.Visual,TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = Main.CloningChamber1.VisualOpen.CFrame}):Play()
		TweenService:GetTweenObject(Main.CloningChamber1.Collision,TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{CFrame = Main.CloningChamber1.CollisionEmpty.CFrame}):Play()
		TweenService:GetTweenObject(Main.CloningChamber1.Liquid,TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{CFrame = Main.CloningChamber1.LiquidStart.CFrame}):Play()
		wait(15)
		debounce = false 
	end
end)