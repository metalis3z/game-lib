-----------------
--| Constants |--
-----------------

local BLAST_RADIUS = 7 -- Blast radius of the explosion
local BLAST_DAMAGE = 100 -- Amount of damage done to zombies
local BLAST_FORCE = 1000 -- Amount of force applied to zombie parts
local IGNORE_LIST = {rocket = 1, handle = 1, effect = 1, water = 1} -- Rocket will fly through things named these
--NOTE: Keys must be lowercase, values must evaluate to true

-----------------
--| Variables |--
-----------------

local DebrisService = game:GetService('Debris')
local PlayersService = game:GetService('Players')

local Rocket = script.Parent

local CreatorTag = Rocket:WaitForChild('creator')
local SwooshSound = Rocket:WaitForChild('Swoosh')

-----------------
--| Functions |--
-----------------

-- Removes any old creator tags and applies a new one to the target
local function ApplyTags(target)
	while target:FindFirstChild('creator') do
		target.creator:Destroy()
	end

	local creatorTagClone = CreatorTag:Clone()
	DebrisService:AddItem(creatorTagClone, 1.5)
	creatorTagClone.Parent = target
end

-- Returns the ancestor that contains a Humanoid, if it exists
local function FindCharacterAncestor(subject)
	if subject and subject ~= workspace then
		local humanoid = subject:FindFirstChildOfClass('Humanoid')
		if humanoid then
			return subject, humanoid
		else
			return FindCharacterAncestor(subject.Parent)
		end
	end
	return nil
end

local function IsInTable(Table,Value)
	for _,v in Table do
		if v == Value then
			return true
		end
	end
	return false
end

-- Customized explosive effect that ONLY affects Humanoids named "Zombie"
local TaggedHumanoids = {}
local function OnExplosionHit(hitPart, hitDistance, blastCenter)
	if hitPart and hitDistance then
		local character, humanoid = FindCharacterAncestor(hitPart.Parent)

		-- Only affect Humanoids named "Zombie"
		if humanoid and humanoid.Health > 0 and humanoid.Name == "Zombie" then
			if not IsInTable(TaggedHumanoids, humanoid) then
				table.insert(TaggedHumanoids, humanoid)
				ApplyTags(humanoid)
				humanoid:TakeDamage(BLAST_DAMAGE)
			end
		elseif humanoid and humanoid.Name == "Zombie" and humanoid.Health == 0 then
			-- Dead zombie parts can be blasted
			if hitPart.Name ~= 'Handle' then
				hitPart:BreakJoints()
				local blastForce = Instance.new('BodyForce', hitPart)
				blastForce.Force = (hitPart.Position - blastCenter).unit * BLAST_FORCE * hitPart:GetMass()
				DebrisService:AddItem(blastForce, 0.1)
			end
		end
		-- All other humanoids and parts are ignored by the explosion
	end
end

local function OnTouched(otherPart)
	if Rocket and otherPart then
		-- Fly through anything in the ignore list
		if IGNORE_LIST[string.lower(otherPart.Name)] then
			return
		end

		local myPlayer = CreatorTag.Value
		if myPlayer then
			-- Fly through the creator
			if myPlayer.Character and myPlayer.Character:IsAncestorOf(otherPart) then
				return
			end

			-- Fly through friendlies
			if not myPlayer.Neutral then
				local character = FindCharacterAncestor(otherPart.Parent)
				local player = PlayersService:GetPlayerFromCharacter(character)
				if player and player ~= myPlayer and player.TeamColor == Rocket.BrickColor then
					return
				end
			end
		end

		-- Fly through terrain water
		if otherPart == workspace.Terrain then
			local frontOfRocket = Rocket.Position + (Rocket.CFrame.lookVector * (Rocket.Size.Z / 2))
			local cellLocation = workspace.Terrain:WorldToCellPreferSolid(frontOfRocket)
			local cellMaterial = workspace.Terrain:GetCell(cellLocation.X, cellLocation.Y, cellLocation.Z)
			if cellMaterial == Enum.CellMaterial.Water or cellMaterial == Enum.CellMaterial.Empty then
				return
			end
		end

		-- Create the explosion
		local explosion = Instance.new('Explosion')
		explosion.BlastPressure = 0 -- Completely safe explosion
		explosion.BlastRadius = BLAST_RADIUS
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
		explosion.Position = Rocket.Position
		explosion.Parent = workspace

		-- Connect custom logic for the explosion
		explosion.Hit:Connect(function(hitPart, hitDistance) OnExplosionHit(hitPart, hitDistance, explosion.Position) end)

		-- Move this script and the creator tag (so our custom logic can execute), then destroy the rocket
		script.Parent = explosion
		CreatorTag.Parent = script
		Rocket:Destroy()
	end
end

--------------------
--| Script Logic |--
--------------------

SwooshSound:Play()

Rocket.Touched:Connect(OnTouched)

