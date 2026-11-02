local Wheel = game.Workspace.Wheel
local InterPart = Wheel.Pivot
local Billboard = InterPart.BillboardGui
local WheelRemotes = game.ReplicatedStorage.WheelRemotes
local Player = game.Players.LocalPlayer

local PrizeTable = {

	{"CandleF","Item"}, -- 1
	{"ElderGun","Item"}, -- 2
	{"VampireE","Item"}, -- 3
	{"ICE2","Item"},-- 4
	{"Eternalh","Item"},-- 5
	{"Flames","Item"}, -- 6
	{"Pum","Item"}, -- 7
	{"Pixel","Item"}, -- 8
}

local Spins = 0

function GiveReward(pricerng)
	local RewardData = PrizeTable[pricerng]

	if RewardData[2] == "Item" then
		if RewardData[1] == "RandomGodly" or RewardData[1] == "RandomChroma" then
			WheelRemotes.GiveRandom:FireServer(RewardData[1])
		else
			WheelRemotes.GiveItem:FireServer(RewardData[1])
		end

	elseif RewardData[2] == "Currency" then
		if RewardData[3] == "Coins" then
			WheelRemotes.GiveCurrency:FireServer(RewardData[1],"Coins")
		else
			WheelRemotes.GiveCurrency:FireServer(RewardData[1],"Gems")
		end
	end
end

local Cooldown = false

InterPart.ProximityPrompt.Triggered:Connect(function()
	
	if Cooldown == false then
		
		if Spins > 0 then
			
			InterPart.ProximityPrompt.Enabled = false
			
			Cooldown = true
			
			Spins -= 1
			
			Billboard.YourSpins.Text = "Your Spins: "..tostring(Spins)
			
			local rng = 0
			local WaitTime = 0.1
			
			for i = 1,25 do
				
				local partrng
				
				repeat
					partrng = math.random(1,8)
				until partrng ~= rng
				
				rng = partrng
				
				if i > 10 then
					WaitTime = 0.25
				elseif i > 20 then
					WaitTime = 0.3
				end
				
				InterPart.Sound:Play()
				
				Wheel:FindFirstChild("Prize"..partrng).Material = Enum.Material.Neon
				wait(WaitTime)
				Wheel:FindFirstChild("Prize"..partrng).Material = Enum.Material.SmoothPlastic
				
			end
			
			local prizerng = math.random(1,8)
			
			InterPart.Sound:Play()
			GiveReward(prizerng)
			
			for i = 1,3 do
				InterPart.Reward:Play()
				Wheel:FindFirstChild("Prize"..prizerng).Material = Enum.Material.Neon
				wait(1)
				Wheel:FindFirstChild("Prize"..prizerng).Material = Enum.Material.SmoothPlastic
				wait(1)
			end
			
			InterPart.ProximityPrompt.Enabled = true

			Cooldown = false
		
		end
	end
end)

game.ReplicatedStorage.WheelRemotes.BuySpin.OnClientEvent:Connect(function()
		Spins += 1
		Billboard.YourSpins.Text = "Your Spins: "..tostring(Spins)
end)

while true do
	local Time = 100

	repeat
		Time -= 1
		Billboard.NextSpin.Text = "You get a spin in "..tostring(Time).." seconds"
		wait(1)
	until Time == 0

	Spins += 1
	print(Spins)

	Billboard.YourSpins.Text = "Your Spins: "..tostring(Spins)

end