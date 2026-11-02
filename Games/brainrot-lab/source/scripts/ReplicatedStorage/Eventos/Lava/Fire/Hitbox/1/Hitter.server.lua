local waypoints = script.Parent.Parent.Parent.Waypoints
local part = script.Parent

local Mutations = require(game.ReplicatedStorage.Configuration.Modules:WaitForChild("Mutations"))
local Numbers  = require(game.ReplicatedStorage.Modules:WaitForChild("Format"))



local function ClossestThing()
	local things = workspace.Things:GetChildren()
	local closest = nil


	for i, thing in pairs(things) do
		if thing:IsA("Model") then
			local distance =(thing.HumanoidRootPart.Position - part.Position).Magnitude
			if distance < 20 then
				if (thing.HumanoidRootPart.Position - part.Position).Magnitude < (closest.HumanoidRootPart.Position - part.Position).Magnitude then
					closest = thing


				end
			end
		end
	end

	return closest
end


local function Touch(char)


	if not char then return end

	local traits = char.Configuration.Traits
	if traits.Value == "" then
		traits.Value = "Fire"
	elseif traits.Value ~= "Fire" then
		traits.Value = traits.Value .. ",Fire"
	end

	local gui = char.HumanoidRootPart.ThingAttachment.ThingGui
	gui.Traits.Visible = true

	local newTrait = gui.Traits.Trait:Clone()
	newTrait.Name = "Fire"
	newTrait.Image = `rbxassetid://98578728516715`
	newTrait.Visible = true
	newTrait.Parent = gui.Traits

	local Traits = char.Configuration.Traits

	if char.Configuration then


		if Traits.Value == "" then
			Traits.Value = `Fire`

		else
			local currentTrait = Traits.Value
			if currentTrait == `Fire` then return end

			Traits.Value = currentTrait..","..`Fire`
		end
	end

	local ThingModule = require(game.ReplicatedStorage.Configuration.Modules:WaitForChild("Things"))


	local baseMoney = ThingModule[char.Name].MoneyPerSecond or 0
	local TraitMultiplier = 0
	for tName, tConf in pairs(Traits) do
		if char:GetAttribute("Trait_"..tName) then
			TraitMultiplier = TraitMultiplier + (tConf.Multiplier or 0)
		end
	end


	local currentMutation =  char.Configuration.Mutation.Value
	local MutationMultiplier = (currentMutation and Mutations[currentMutation] and Mutations[currentMutation].Multiplier) or 1
	local DefaultMultiplier = (Mutations.Default and Mutations.Default.Multiplier) or 1

	local TraitMultiplier = 0

	local SubtractValue = 0
	if TraitMultiplier ~= 0 then SubtractValue = DefaultMultiplier end
	local TotalMultiplier = MutationMultiplier + (TraitMultiplier - SubtractValue)

	if gui and gui:FindFirstChild("MoneyPerSecond") then
		ThingGui.MoneyPerSecond.Text = string.format("$%s/s", Numbers.Format(math.round(baseMoney * TotalMultiplier)))
	end
end


local function randomwaypoint()
	local waypoints = waypoints:GetChildren()
	local random = math.random(1, #waypoints)
	return waypoints[random]

end

local function moverandom()
	local waypoints = randomwaypoint()

	local Things = workspace.Things

	local speed = 16

	

	local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(3), {CFrame = waypoints.CFrame})
	tween:Play()
	wait(4)
	moverandom()
end


moverandom()

