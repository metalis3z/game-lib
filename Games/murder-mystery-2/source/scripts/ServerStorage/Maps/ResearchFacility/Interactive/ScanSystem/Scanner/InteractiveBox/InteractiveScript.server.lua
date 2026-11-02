local ScanningPlayers = {}
local IsBeingUsed = script.Parent.InUse.Value
local CanScan = false
local Debounce = false
local function Ding()
	script.Parent.Parent.Parent.Siren.Bulb.Ding:Play()
end
local function ScanPlay()
	script.Parent.Parent.Parent.ScanBox.Sound:Play()
end
local function SetColor(ColorPart)
	if ColorPart then
		for _,Part in pairs(script.Parent.Parent.Parent.WhiteLights:GetChildren()) do
			if Part.Name == "Cylinder" then
				game:GetService("TweenService"):Create(Part,TweenInfo.new(0.2,Enum.EasingStyle.Linear),{Color = ColorPart}):Play()
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
		if not table.find(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent)) then
			table.insert(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent))
		end
	end
end)
script.Parent.Parent.Parent.ScanBox.TouchEnded:Connect(function(TouchingPlayer)
	if game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent) and TouchingPlayer.Name == "HumanoidRootPart" then	
		if table.find(ScanningPlayers,game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent)) then
			for Index,Table in pairs(ScanningPlayers) do
				if Table == game.Players:GetPlayerFromCharacter(TouchingPlayer.Parent) then
				table.remove(ScanningPlayers,Index)
				end
			end
		end
	end
end)
script.Parent.Interact.OnServerEvent:Connect(function()
	if not Debounce then
		Debounce = true
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
		wait(1.5)
		Debounce = false
	end
end)