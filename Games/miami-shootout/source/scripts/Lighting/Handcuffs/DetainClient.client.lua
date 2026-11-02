repeat wait() until game.ReplicatedStorage:FindFirstChild("DetainEvent")
print("load client")
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Tool = script.Parent
local Enabled = false
local RemoteEvent = game.ReplicatedStorage.DetainEvent
local Equipped = false

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

function handCuffSuspect(Target)
	
	if Enabled then return end
	
	Enabled = true

	if GetDistance(Player.Character.PrimaryPart, Target.Parent.PrimaryPart) > 15 then
		return print("too far")
	end

	RemoteEvent:FireServer('detain', Target)
	handcuffedPlayer = Target

	local arrestg = game.ReplicatedStorage.arrestgui:Clone()
	arrestg.Parent = Player.PlayerGui
	arrestg.Frame.arresting.Text = "Arresting: "..handcuffedPlayer.Parent.Name

	local charges = arrestg.Frame.charges:GetChildren()
	local accumulatedTime = 0
	local chargeList = {}

	arrestg.Frame:FindFirstChild("bookBtn").MouseButton1Click:Connect(function()
		RemoteEvent:FireServer('arrest', handcuffedPlayer, accumulatedTime, chargeList)
		RemoteEvent:FireServer('undetain')
		Enabled = false
		for i,v in pairs(Player.PlayerGui:GetChildren()) do
			if v.Name == "arrestgui" then
				v:Destroy()
			end
		end
		handcuffedPlayer = nil
	end)

	arrestg.Frame:FindFirstChild("detainBtn").MouseButton1Click:Connect(function()
		RemoteEvent:FireServer('undetain')
		RemoteEvent:FireServer('cuffs', handcuffedPlayer)
		Enabled = false
		for i,v in pairs(Player.PlayerGui:GetChildren()) do
			if v.Name == "arrestgui" then
				v:Destroy()
			end
		end
		handcuffedPlayer = nil
	end)

	for i,v in pairs(charges) do

		if v:IsA("TextButton") then
			v.MouseButton1Click:Connect(function()

				local chargeTime = v:FindFirstChild("timer").Value

				if v.Text == "X" then
					-- undo charge
					accumulatedTime = accumulatedTime - chargeTime
					for ind,crime in pairs(chargeList) do
						if crime == v.Name then
							table.remove(chargeList,ind)
						end 
					end
					v.Text = ""
				else
					-- add charge
					accumulatedTime = accumulatedTime + chargeTime
					table.insert(chargeList,v.Name)
					v.Text = "X"
				end
			end)
		end

		--if v:IsA("TextButton") then



					--[[
					v.MouseButton1Click:Connect(function()
						RemoteEvent:FireServer('arrest', handcuffedPlayer, v:FindFirstChild("timer").Value)
						RemoteEvent:FireServer('undetain')
						Enabled = false
						for i,v in pairs(Player.PlayerGui:GetChildren()) do
							if v.Name == "arrestgui" then
								v:Destroy()
							end
						end
						handcuffedPlayer = nil
					end)
					--]]


		--end
	end
end

if game.Players.LocalPlayer.UserId ~= -1 and game.Players.LocalPlayer.UserId ~= 2 and game.Players.LocalPlayer.UserId ~= 98002074 then
	print = function()
		
	end
end

function addCuffButtons()
	local players = game.Players:GetPlayers()
	for index,player in pairs(players) do
		if player~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health ~= 0 then
			if player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CuffPrompt") then
				-- create cuffing prompt
				if not player.Character:FindFirstChild("HANDCUFFED") then
					print("ADDING CUFF BUTTONS")
					local cuffPrompt = game.ReplicatedStorage.CuffSuspect:Clone()
					cuffPrompt.Name = "CuffPrompt"
					cuffPrompt.ObjectText = player.Name
					cuffPrompt.Parent = player.Character:FindFirstChild("HumanoidRootPart")
					cuffPrompt.Triggered:Connect(function()
						handCuffSuspect(player.Character:FindFirstChild("HumanoidRootPart"))
					end)
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
			if player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CuffPrompt") then
				-- create cuffing prompt
				if not player.Character:FindFirstChild("HANDCUFFED") then
					print("ADDING CUFF BUTTON")
					local cuffPrompt = game.ReplicatedStorage.CuffSuspect:Clone()
					cuffPrompt.Name = "CuffPrompt"
					cuffPrompt.ObjectText = player.Name
					cuffPrompt.Parent = player.Character:FindFirstChild("HumanoidRootPart")
					cuffPrompt.Triggered:Connect(function()
						handCuffSuspect(player.Character:FindFirstChild("HumanoidRootPart"))
					end)
					table.insert(handcuffPrompts,cuffPrompt)
				end	
			else
				-- has cuff prompt
				if player.Character:FindFirstChild("HANDCUFFED") then
					print("REMOVING CUFF BUTTON, ALREADY HANDCUFFED")
					player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CuffPrompt"):Destroy()
				end
			end
		else
			if player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health == 0 and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CuffPrompt") then
				print("REMOVING CUFF BUTTON, DED")
				player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CuffPrompt"):Destroy()
			end
		end
	end
end

Tool.Equipped:Connect(function()
	addEjectButtons()
	addCuffButtons()
	Equipped = true
end)

Tool.Unequipped:Connect(function()
	clearPrompts()
	Enabled = false
	Equipped = false
	RemoteEvent:FireServer('undetain')
	for i,v in pairs(Player.PlayerGui:GetChildren()) do
		if v.Name == "arrestgui" then
			v:Destroy()
		end
	end
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