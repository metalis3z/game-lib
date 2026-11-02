--// Services \\--

local RunService = game:GetService('RunService')
local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local Debris = game:GetService('Debris')



--// Comunication \\--

local Remotes = RS.Remotes

local ComGet = Remotes.Comunicator.Get


local Bindables = SvSt.Bindables

local AD_Bindable = Bindables.AirDetector

--// Functions \\--

local function detectAir(Character: Model, SkipWaitTime: boolean)
	local HumRP: BasePart = Character.HumanoidRootPart
	local Player = HumRP:GetNetworkOwner()

	Character:AddTag('inAir')

	local inAir = Instance.new('BoolValue')
	inAir.Name = 'inAir'
	inAir.Parent = Character

	task.wait(.3)
	
	if not Player then
		local ClosestPlayer = { Player = nil; Distance = nil; }
		for _, Player2 in Players:GetPlayers() do
			local HumRP2: BasePart = Player2.Character:FindFirstChild('HumanoidRootPart')
			
			if HumRP2 then
				local Distance = (HumRP2.Position - HumRP.Position).Magnitude
				
				if ClosestPlayer.Player then
					if Distance < ClosestPlayer.Distance then
						ClosestPlayer.Player = Player2
						ClosestPlayer.Distance = Distance
					end
				else
					ClosestPlayer.Player = Player2
					ClosestPlayer.Distance = Distance
				end
			end
		end
		
		Player = ClosestPlayer.Player
	end
	
	if Player and HumRP.Anchored == false then
		pcall(function()
			HumRP:SetNetworkOwner(Player)
		end)
		
		local Detect = ComGet:InvokeClient(Player, { Func = 'DetectAir'; Char = Character; })
		if Detect then
			Character:RemoveTag('inAir')
			inAir:Destroy()
		end
	else
		Character:RemoveTag('Air')
		inAir:Destroy()
	end
end