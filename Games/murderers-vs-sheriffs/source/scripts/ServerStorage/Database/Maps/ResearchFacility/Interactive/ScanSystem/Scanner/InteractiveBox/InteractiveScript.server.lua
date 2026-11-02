local ScanningPlayers = {}
local IsBeingUsed = script.Parent.InUse.Value
local CanScan = true
local InUse = script.Parent.InUse
local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")
local function Ding()
	script.Parent.Parent.Parent.Siren.Bulb.Ding:Play()
end
local function ScanPlay()
	script.Parent.Parent.Parent.ScanBox.Sound:Play()
end
local function SetColor(ColorPart)
	if ColorPart then
		for _,Part in pairs(script.Parent.Parent.Parent.WhiteLights:GetChildren()) do
			game:GetService("TweenService"):Create(Part,TweenInfo.new(0.2,Enum.EasingStyle.Linear),{Color = ColorPart}):Play()
			if Part:FindFirstChildWhichIsA("ParticleEmitter") then
				Part:FindFirstChildWhichIsA("ParticleEmitter").Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorPart),ColorSequenceKeypoint.new(1, ColorPart)}
			end
		end
	else
		SetColor(Color3.fromRGB(255, 255, 255))
	end
end

local function SetScreen(Screen)
	for _,Frame in pairs(script.Parent.Parent.Parent.Detector.Screen.ScanScreen:GetChildren()) do
		Frame.Visible = false
	end
	if Screen ~= nil then
		script.Parent.Parent.Parent.Detector.Screen.ScanScreen[Screen].Visible = true
	else
		return
	end
end
script.Parent.Parent.Parent.ScanBox.Touched:Connect(function(TouchingPlayer)
	if game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent) and TouchingPlayer.Name == "HumanoidRootPart" then	
		if not table.find(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent)) and CanScan then
			table.insert(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent))
			CanScan = false
		end
	end
end)
script.Parent.Parent.Parent.ScanBox.TouchEnded:Connect(function(TouchingPlayer)
	if game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent) and TouchingPlayer.Name == "HumanoidRootPart" then	
		if table.find(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent)) and not CanScan then
			local index = table.find(ScanningPlayers, game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent))
			print(index)
			if index then
				table.remove(ScanningPlayers, index)
				
				CanScan = true
			end
		end
	end
end)
script.Parent.Interact.OnServerEvent:Connect(function()
	if not InUse.Value then
		InUse.Value = true
		CanScan = false	
		
		
		script.Parent.Parent.ScanningBeam.Beam.Neon.Position = script.Parent.Parent.ScanningBeam.StartPosition.Neon.Position
		SetScreen("Scanning")
		ScanPlay()
		game:GetService("TweenService"):Create(script.Parent.Parent.ScanningBeam.Beam.Neon,TweenInfo.new(2,Enum.EasingStyle.Linear),{Position = script.Parent.Parent.ScanningBeam.EndPosition.Neon.Position}):Play()
		wait(3)
		Ding()
		if ScanningPlayers[1] and not ScanningPlayers[2] then
			if ScanningPlayers[1] then
				if ScanningPlayers[1].Backpack:FindFirstChild("Knife") or ScanningPlayers[1].Character:FindFirstChild("Knife") then
					SetColor(Color3.fromRGB(255, 0, 0))
					SetScreen("Murderer")
					script.Parent.Parent.Parent.Siren.Toggle.Value = true
				elseif ScanningPlayers[1].Backpack:FindFirstChild("Gun") or ScanningPlayers[1].Character:FindFirstChild("Gun") then
					SetColor(Color3.fromRGB(0, 0, 255))
					SetScreen("Sheriff")
				else
					SetColor(Color3.fromRGB(0, 255, 0))
					SetScreen("Innocent")
				end
			end
		else
			SetColor(Color3.fromRGB(255, 255, 0))
			SetScreen("PlayerLeft")
		end
		wait(2)
		SetColor()
		SetScreen()
		script.Parent.Parent.Parent.Siren.Toggle.Value = false
		wait(1.5)
		InUse.Value = false
		CanScan = true
	end
end)