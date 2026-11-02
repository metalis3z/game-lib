--[[

  MADE BY NOLAN
  DONT LEAK THIS 🙂

]]

-- SERVICES --

local ServerStorage = game:GetService('ServerStorage')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService('CollectionService')

-- MODULES --



-- INSTANCES --

local Templates = ReplicatedStorage.Templates
local Booths = ServerStorage:WaitForChild('BoothModels')

-- MAIN SCRIPT --

local BoothsPositions = {
	Booth1 = {Position = Vector3.new(-33.249, 0.511, 114.809), Orientation = -75},
	Booth2 = {Position = Vector3.new(-29.108, 0.511, 130.264), Orientation = -75},
	Booth3 = {Position = Vector3.new(-21.253, 0.511, 145.489), Orientation = -45},
	Booth4 = {Position = Vector3.new(-12.061, 0.511, 154.681), Orientation = -45},
	Booth5 = {Position = Vector3.new(-2.868, 0.511, 163.874), Orientation = -45},
	Booth6 = {Position = Vector3.new(9.426, 0.536, 171.01), Orientation = -15},
	Booth7 = {Position = Vector3.new(21.983, 0.536, 174.375), Orientation = -15},
	Booth8 = {Position = Vector3.new(34.54, 0.536, 177.739), Orientation = -15},
	Booth9 = {Position = Vector3.new(48.755, 0.536, 177.773), Orientation = 15},
	Booth10 = {Position = Vector3.new(61.312, 0.536, 174.408), Orientation = 15},
	Booth11 = {Position = Vector3.new(73.869, 0.536, 171.043), Orientation = 15},
	Booth12 = {Position = Vector3.new(86.196, 0.536, 163.965), Orientation = 45},
	Booth13 = {Position = Vector3.new(95.389, 0.536, 154.772), Orientation = 45},
	Booth14 = {Position = Vector3.new(104.581, 0.536, 145.58), Orientation = 45},
	Booth15 = {Position = Vector3.new(104.672, 0.536, 56.515), Orientation = 135},
	Booth16 = {Position = Vector3.new(95.48, 0.536, 47.323), Orientation = 135},
	Booth17 = {Position = Vector3.new(86.287, 0.536, 38.13), Orientation = 135},
	Booth18 = {Position = Vector3.new(73.993, 0.511, 30.994), Orientation = 165},
	Booth19 = {Position = Vector3.new(61.436, 0.511, 27.629), Orientation = 165},
	Booth20 = {Position = Vector3.new(48.879, 0.511, 24.265), Orientation = 165},
	Booth21 = {Position = Vector3.new(34.664, 0.511, 24.231), Orientation = -165},
	Booth22 = {Position = Vector3.new(22.107, 0.511, 27.596), Orientation = -165},
	Booth23 = {Position = Vector3.new(9.55, 0.511, 30.961), Orientation = -165},
	Booth24 = {Position = Vector3.new(-2.777, 0.511, 38.039), Orientation = -135},
	Booth25 = {Position = Vector3.new(-11.97, 0.511, 47.232), Orientation = -135},
	Booth26 = {Position = Vector3.new(-21.162, 0.511, 56.424), Orientation = -135},
	Booth27 = {Position = Vector3.new(-29.075, 0.511, 71.616), Orientation = -105},
	Booth28 = {Position = Vector3.new(-33.216, 0.511, 87.071), Orientation = -105}
}

local BoothInteraction = {
	Interaction1 = {Position = Vector3.new(-32.297, 4.504, 114.502), Orientation = 105},
	Interaction2 = {Position = Vector3.new(-28.156, 4.504, 129.957), Orientation = 105},
	Interaction3 = {Position = Vector3.new(-20.582, 4.504, 144.747), Orientation = 135},
	Interaction4 = {Position = Vector3.new(-11.39, 4.504, 153.94), Orientation = 135},
	Interaction5 = {Position = Vector3.new(-2.197, 4.504, 163.132), Orientation = 135},
	Interaction6 = {Position = Vector3.new(9.636, 4.529, 170.032), Orientation = 165},
	Interaction7 = {Position = Vector3.new(22.193, 4.529, 173.397), Orientation = 165},
	Interaction8 = {Position = Vector3.new(34.75, 4.529, 176.762), Orientation = 165},
	Interaction9 = {Position = Vector3.new(48.448, 4.529, 176.821), Orientation = -165},
	Interaction10 = {Position = Vector3.new(61.005, 4.529, 173.456), Orientation = -165},
	Interaction11 = {Position = Vector3.new(73.562, 4.529, 170.091), Orientation = -165},
	Interaction12 = {Position = Vector3.new(85.455, 4.529, 163.294), Orientation = -135},
	Interaction13 = {Position = Vector3.new(94.647, 4.529, 154.101), Orientation = -135},
	Interaction14 = {Position = Vector3.new(103.839, 4.529, 144.909), Orientation = -135},
	Interaction15 = {Position = Vector3.new(104.001, 4.529, 57.257), Orientation = -45},
	Interaction16 = {Position = Vector3.new(94.809, 4.529, 48.065), Orientation = -45},
	Interaction17 = {Position = Vector3.new(85.616, 4.529, 38.872), Orientation = -45},
	Interaction18 = {Position = Vector3.new(73.783, 4.504, 31.972), Orientation = -15},
	Interaction19 = {Position = Vector3.new(61.226, 4.504, 28.607), Orientation = -15},
	Interaction20 = {Position = Vector3.new(48.669, 4.504, 25.243), Orientation = -15},
	Interaction21 = {Position = Vector3.new(34.971, 4.504, 25.183), Orientation = 15},
	Interaction22 = {Position = Vector3.new(22.414, 4.504, 28.548), Orientation = 15},
	Interaction23 = {Position = Vector3.new(9.857, 4.504, 31.913), Orientation = 15},
	Interaction24 = {Position = Vector3.new(-2.036, 4.504, 38.71), Orientation = 45},
	Interaction25 = {Position = Vector3.new(-11.228, 4.504, 47.903), Orientation = 45},
	Interaction26 = {Position = Vector3.new(-20.42, 4.504, 57.095), Orientation = 45},
	Interaction27 = {Position = Vector3.new(-28.097, 4.504, 71.826), Orientation = 75},
	Interaction28 = {Position = Vector3.new(-32.238, 4.504, 87.281), Orientation = 75}
}

local BoothInteractions = {}

for Name, Interaction in pairs(BoothInteraction) do
	local InteractionClone = script.BoothInteraction:Clone()
	InteractionClone.Position = Interaction.Position
	InteractionClone.Orientation = Vector3.new(0, Interaction.Orientation, 0)
	InteractionClone.Name = 'BoothInteraction'
	CollectionService:AddTag(InteractionClone, 'BoothInteraction')
	InteractionClone:SetAttribute('BoothSlot', Name:sub(12, #Name))
	InteractionClone:SetAttribute('BoothOwner', nil)
	InteractionClone.Parent = workspace:WaitForChild('BoothInteractions')
	rawset(BoothInteractions, Name:sub(12, #Name), InteractionClone)
	--CreateBoothStore(Name)
end

local BoothModels = {}

for Name, Booth in pairs(BoothsPositions) do
	local BoothClone = Booths.BasicBooth:Clone()
	BoothClone:SetPrimaryPartCFrame(CFrame.new(Booth.Position))
	BoothClone:SetPrimaryPartCFrame(BoothClone.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(Booth.Orientation), 0))
	BoothClone.Name = 'BasicBooth'
	BoothClone:SetAttribute('BoothID', Name:sub(6, #Name))
	BoothClone.Parent = workspace:WaitForChild('BoothModels')
	local BoothUI = Templates.BoothUI:Clone()
	BoothUI.Parent = BoothClone
	BoothUI.Details.Adornee = BoothClone:WaitForChild('Base')
	BoothUI.Items.Adornee = BoothClone:WaitForChild('ItemsPart')
	BoothUI.Sign.Adornee = BoothClone:WaitForChild('SignPart')
	BoothUI.Name = 'BoothUI'
	rawset(BoothModels, Name:sub(6, #Name), BoothClone)
	--CreateBoothStore(Name)
end

wait(1)

script:Destroy()