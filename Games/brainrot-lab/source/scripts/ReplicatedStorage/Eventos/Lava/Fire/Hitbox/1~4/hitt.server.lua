local part = script.Parent

local function ClossestThing()
	local things = workspace.Things:GetChildren()
	local closest = nil


	for i, thing in pairs(things) do
		if thing:IsA("Model") then
			local distance =(thing.HumanoidRootPart.Position - part.Position).Magnitude
			if distance < 20 then
				
					closest = thing


			end
		end
	end

	return closest
end

local function GiveTrait(Thing)
	if Thing:IsA("Model") then
		local TraitName = "Fire"

		local TraitsValue = Thing.Configuration.Traits
		local Traits = TraitsValue.Value
		local TraitList = string.split(Traits, ",")

		-- Проверяем, есть ли уже такой трейт в списке
		local hasTrait = false
		for _, trait in ipairs(TraitList) do
			if trait == TraitName then
				hasTrait = true
				break
			end
		end

		-- Если трейт уже есть — выходим без изменений
		if hasTrait then
			return
		end

		-- Если список пустой — просто добавляем трейт
		if Traits == "" then
			TraitsValue.Value = TraitName
		else
			-- Иначе добавляем через запятую
			TraitsValue.Value = Traits .. "," .. TraitName
		end

		local ThingGui = Thing.HumanoidRootPart.ThingAttachment.ThingGui
		ThingGui.Traits.Visible = true

		local newTrait = ThingGui.Traits.Trait:Clone()
		newTrait.Name = TraitName
		newTrait.Image = "rbxassetid://98578728516715"
		newTrait.Visible = true
		newTrait.Parent = ThingGui.Traits
	end
end



while wait(0.5) do

	local ClosestThing = ClossestThing()

	if ClosestThing then

		GiveTrait(ClosestThing)
	end
end