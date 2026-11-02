repeat wait() until game.ReplicatedStorage:FindFirstChild("EMSEvent")
print("load client")
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Tool = script.Parent
local Enabled = false
local RemoteEvent = game.ReplicatedStorage.DetainEvent
local Equipped = false

local animation = Player.Character:WaitForChild("Humanoid"):LoadAnimation(script.Parent.Animation)

local handcuffedPlayer = nil
local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

Tool.Activated:Connect(function()
	
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		if Player.Character:FindFirstChild("Humanoid").Health == 0 then
			return print("can't hc while dead")
		end
	end
	
	if Enabled == true then 
		Enabled = false
		RemoteEvent:FireServer('undetain')
		for i,v in pairs(Player.PlayerGui:GetChildren()) do
			if v.Name == "arrestgui" then
				v:Destroy()
			end
		end
		handcuffedPlayer = nil
	end
end)

local prompts = {}
local handcuffPrompts = {}

function clearPrompts()
	for i,v in pairs(prompts) do
		v:Destroy()
	end
	for i,v in pairs(handcuffPrompts) do
		v:Destroy()
	end
end

function addEjectButtons()
	local civCars = game.Workspace.CivCars
	for index,car in pairs(civCars:GetChildren()) do
		if car:FindFirstChild("FIREPART").Value then
			local ce = game.ReplicatedStorage.CarEject:Clone()
			ce.Parent = car:FindFirstChild("FIREPART").Value
			ce.ObjectText = "Car: "..car.Name 
			ce.Triggered:Connect(function()
				RemoteEvent:FireServer("eject",car)
			end)
			table.insert(prompts,ce)
		end
	end
end

function healSuspect(Target)
	game.ReplicatedStorage.EMSEvent:FireServer(Target)
end

if game.Players.LocalPlayer.UserId ~= -1 and game.Players.LocalPlayer.UserId ~= 2 and game.Players.LocalPlayer.UserId ~= 98002074 then
	print = function()
		
	end
end

function timer(prompt,maxhp,hp)
	
	local healthDifference = maxhp - hp
	
	if healthDifference >= 10 then
		prompt.HoldDuration = 0.2
	elseif healthDifference >= 25 then
		prompt.HoldDuration = 0.6
	elseif healthDifference >= 35 then
		prompt.HoldDuration = 0.9
	elseif healthDifference >= 50 then
		prompt.HoldDuration = 1.5
	elseif healthDifference >= 65 then
		prompt.HoldDuration = 1.9
	elseif healthDifference >= 70 then
		prompt.HoldDuration = 2.3
	elseif healthDifference >= 80 then
		prompt.HoldDuration = 3
	elseif healthDifference >= 90 then
		prompt.HoldDuration = 5
	elseif healthDifference >= 95 then
		prompt.HoldDuration = 6
	end
	
end

function addCuffButtons()
	local players = game.Players:GetPlayers()
	for index,player in pairs(players) do
		if player~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health ~= 0 then
			if player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("EMSPrompt") then
				-- create cuffing prompt
				if not player.Character:FindFirstChild("HANDCUFFED") then
					print("ADDING HP BUTTONS")
					local cuffPrompt = game.ReplicatedStorage.CuffSuspect:Clone()
					cuffPrompt.Name = "EMSPrompt"
					cuffPrompt.ObjectText = player.Name.. " ("..player.Character.Humanoid.Health.."/"..player.Character.Humanoid.MaxHealth..")"
					cuffPrompt.ActionText = "Heal"
					cuffPrompt.Parent = player.Character:FindFirstChild("HumanoidRootPart")
					cuffPrompt.Triggered:Connect(function()
						healSuspect(player.Character:FindFirstChild("HumanoidRootPart"))
					end)
					timer(cuffPrompt,player.Character.Humanoid.MaxHealth,player.Character.Humanoid.Health)
					table.insert(handcuffPrompts,cuffPrompt)
				end	
			end
		end
	end
end

function updateCuffButtons()
	if not Equipped then return end
	if Enabled then 
		for i,v in pairs(handcuffPrompts) do
			v:Destroy()
		end
		return
	end
	local players = game.Players:GetPlayers()
	for index,player in pairs(players) do
		if player~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health ~= 0 then
			if player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("EMSPrompt") then
				-- create healing prompt
				print("ADDING HEAL BUTTON")
				local cuffPrompt = game.ReplicatedStorage.CuffSuspect:Clone()
				cuffPrompt.Name = "EMSPrompt"
				cuffPrompt.ObjectText = player.Name.. " ("..player.Character.Humanoid.Health.."/"..player.Character.Humanoid.MaxHealth..")"
				cuffPrompt.ActionText = "Heal"
				cuffPrompt.Parent = player.Character:FindFirstChild("HumanoidRootPart")
				cuffPrompt.Triggered:Connect(function()
					healSuspect(player.Character:FindFirstChild("HumanoidRootPart"))
				end)
				table.insert(handcuffPrompts,cuffPrompt)
				timer(cuffPrompt,player.Character.Humanoid.MaxHealth,player.Character.Humanoid.Health)	
			else
				-- has cuff prompt
				local promt = player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("EMSPrompt")
				
				if promt then
					promt.ObjectText = player.Name.. " ("..player.Character.Humanoid.Health.."/"..player.Character.Humanoid.MaxHealth..")"
					timer(promt,player.Character.Humanoid.MaxHealth,player.Character.Humanoid.Health)
				end
			end
		else
			if player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health == 0 and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("EMSPrompt") then
				print("REMOVING CUFF BUTTON, DED")
				player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("EMSPrompt"):Destroy()
			end
		end
	end
end

Tool.Equipped:Connect(function()
	--addEjectButtons()
	addCuffButtons()
	Equipped = true
	animation:Play()
end)

Tool.Unequipped:Connect(function()
	clearPrompts()
	Enabled = false
	Equipped = false
	animation:Stop()
end)

RemoteEvent.OnClientEvent:Connect(function(Purpose)
	if Purpose == "noOneToDetain" then
		Enabled = false
	end
end)

Player.Character:WaitForChild("Humanoid").Died:Connect(function()
	clearPrompts()
	Player.Character.Humanoid:UnequipTools()
end)

while true do
	wait(0.05)
	if Equipped then
		updateCuffButtons()
	end
end