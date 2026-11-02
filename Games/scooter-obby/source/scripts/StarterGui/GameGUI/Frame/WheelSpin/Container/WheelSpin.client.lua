local player = game.Players.LocalPlayer

local Frame = script.Parent
local Close = Frame.Close
local Spin1 = Frame.Spin1
local Spin10 = Frame.Spin10
local Spin100 = Frame.Spin100

local RepStorage = game:GetService("ReplicatedStorage")
local MPS = game:GetService("MarketplaceService")
local Remotes = RepStorage.RemoteEvents
local Remote = Remotes.SpinWheel

-- GAME PASS IDS
local Spin1ID = 1694696047
local Spin10ID = 1694696318 -- 5
local Spin100ID = 1694696770 -- 10

local db = false
Spin1.MouseButton1Click:Connect(function()
	if db == false then
		db = true
		if player:WaitForChild("Data"):WaitForChild("WheelSpins").Value >= 1 then
			Spin1.Contents.Title.Text = "Spinning"
			Remote:FireServer()			
		else
			MPS:PromptProductPurchase(player,Spin1ID)
		end
		task.wait(5)
		db = false
		Spin1.Contents.Title.Text = "Spin!"
	end
end)

Spin10.MouseButton1Click:Connect(function()
	MPS:PromptProductPurchase(player,Spin10ID)
end)

Spin100.MouseButton1Click:Connect(function()
	MPS:PromptProductPurchase(player,Spin100ID)
end)

Remote.OnClientEvent:Connect(function(Reward)
	if Reward then
		local spinFrame = script.Parent.Main.SpinFrame
		if Reward then
			game.ReplicatedStorage.Sounds.Wheel:Play()
			script.Parent.Main.SpinFrame.Rotation = 0;
			local randomRotation = math.random(0, 360) -- Generate a random rotation

			game:GetService("TweenService"):Create(script.Parent.Main.SpinFrame, TweenInfo.new(1), {Rotation = 360 * 10 + randomRotation}):
				Play();

			task.wait(1) 

			local Rotation
			
			print(Reward)
			if Reward == "1" then
				Rotation = -180 -- IQ
			elseif Reward == "2" then
				Rotation = 108 -- Typing
			elseif Reward == "3" then
				Rotation = -36 -- Wins
			elseif Reward == "4" then
				Rotation = 36 -- UGC 1
			elseif Reward == "5" then
				Rotation = -108 -- UGC 2
			else
				warn("Unknown Reward value")
				return
			end

			game:GetService("TweenService"):Create(script.Parent.Main.SpinFrame, TweenInfo.new(3.5), {Rotation = Rotation}):
				Play();

			task.wait(4.5)
			script.Parent.Main.SpinFrame.Rotation = 0;
			game.ReplicatedStorage.Sounds.Wheel:Stop()
		end
	end
end)

