--> Variables
local _L = _G._L

local Services
local TableUtility
local Trove
local PetUtility
local PetRarities
local ArrayUtility
local Rainbow

--> Constants
local SPACE_BEHIND_CHARACTER = 5
local PETS_PER_ROW = 3
local PADDING_Z = 2
local PADDING_X = 2
local PRECISE_SPACING = false

------------->
local PetGroup = {r = {}}
PetGroup.__index = PetGroup

function PetGroup._init()
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Services = _L.Get {"Common", "Library", "Services"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
	PetRarities = _L.Get {"Common", "Modules", "Databases", "Pets", "Rarities"}
	ArrayUtility = _L.Get {"Common", "Library", "Utilities", "ArrayUtility"}
	Create = _L.Get {"Common", "Library", "Functions", "Create"}
	Rainbow = _L.Get {"Client", "Modules", "Classes", "Rainbow"}
	
end

function PetGroup._start()
	Rainbow.new({
		speed = 3,
		callback = function(value)
			for _, d in pairs(PetGroup.r) do
				d.Color3 = value
			end
		end,
	})
end

function PetGroup.new(props)
	local self = setmetatable({}, PetGroup)

	self._player = props.player
	self._data = props.data 

	self._pets = {}

	self._trove = Trove.new()

	self:_construct()

	return self
end

function PetGroup:_construct()
	self._trove:Add(self._data:Bind("pets", function(value)
		local petUids = {}
		
		for _, pet in pairs(self._pets) do
			local petUid = pet.uid
			local petInstance = pet.instance

			local petData = PetUtility.getData(self._data, petUid)
			
			if not petData or not petData.equipped then
				table.insert(petUids, petUid)
			end
		end
		
		for _, petUid in pairs(petUids) do
			local petIndex, pet = TableUtility.match(self._pets, function(i, v)
				return v.uid == petUid
			end)

			if petIndex and pet then
				table.remove(self._pets, petIndex)
				pet.trove:Destroy()
			end
		end
		
		local pets = TableUtility.deep.clone(self._pets)

		for _, petData in pairs(value) do
			local petUid = petData.uid
			local petName = petData.name
			local petInfo = PetUtility.getInfo(petName)
			
			local pet = self:get(petUid)
			
			if not pet and petData.equipped then
				local petInstance = _L.Assets.Models.Pets:FindFirstChild(petName)

				if petInstance then
					local newPetInstance = petInstance:Clone()
					local newTrove = Trove.new()
					
					self._trove:Add(newTrove)
					
					newTrove:Add(function()
						for _, d in pairs(newPetInstance:GetDescendants()) do
							local x = PetGroup.r[d]

							if x then
								PetGroup.r[d] = nil
								x:Destroy()
							end
						end
					end)
					
					newTrove:Add(newPetInstance)
					
					newPetInstance.Name = petUid
					newPetInstance.Parent = _L.Debris.Pets

					local petSize = if newPetInstance:IsA("BasePart") then newPetInstance.Size elseif newPetInstance.PrimaryPart then newPetInstance.PrimaryPart.Size else newPetInstance:GetExtentsSize()
					
					local i, rarityInfo = TableUtility.match(PetRarities, function(i, v)
						return v.name == petInfo.rarity
					end)
					
					local newPet = {
						uid = petUid,
						instance = newPetInstance,
						size = petSize,
						info = petInfo,
						rarity_info = {i = i, v = rarityInfo},
						last_lerp = nil,
						trove = newTrove
					}
					
					pet = newPet
					
					table.insert(pets, newPet)
				end
			end
			
			if pet then
				if petData.tier == "Rainbow" then
					for _, d in pairs(pet.instance:GetDescendants()) do
						local fi

						if d:IsA("SpecialMesh") then
							fi = d.Parent
						elseif d:IsA("MeshPart") then
							fi = d
						end

						if fi and not PetGroup.r[fi] then
							PetGroup.r[fi] = Create("Decal", {
								Parent = fi,
								Texture = "rbxassetid://14464071316",
								Transparency = 0.3
							})
						end
					end
				else
					for _, d in pairs(pet.instance:GetDescendants()) do
						local x = PetGroup.r[d]

						if x then
							PetGroup.r[d] = nil
							x:Destroy()
						end
					end
				end
			end
		end
		
		local mega = {}

		for i, rarityInfo in pairs(PetRarities) do
			local mini = ArrayUtility.filter(pets, function(i, v)
				return v.rarity_info.v.name == rarityInfo.name
			end)

			table.sort(mini, function(a, b)
				return (a.size.X + a.size.Z) < (b.size.X + b.size.Z)
			end)

			for _, v in pairs(mini) do
				table.insert(mega, v)
			end
		end

		self._pets = mega
	end))

	self._trove:Add(function()
		table.clear(self._pets)
	end)
end

local raycastParams = RaycastParams.new()

raycastParams.FilterDescendantsInstances = {_L.Debris.Pets, _L.Map.Safezones, _L.Map.TrainingAreas}
raycastParams.FilterType = Enum.RaycastFilterType.Exclude 

function PetGroup:render(dt)
	local character = self._player.Character
	
	--local _, _, maxX = TableUtility.max(self._pets, function(i, v)
	--	return v.size.X
	--end)
	
	--local _, _, maxZ = TableUtility.max(self._pets, function(i, v)
	--	return v.size.Z
	--end)
	
	if character then
		local root = character.PrimaryPart

		if root then
			local humanoid = character:FindFirstChild("Humanoid")
			
			if humanoid then
				local isMoving = humanoid.MoveDirection ~= Vector3.zero
				
				for petIndex, pet in pairs(self._pets) do
					pet.last_lerp = pet.last_lerp or root.CFrame
					
					local row = self:_get_row(petIndex)
					local column = self:_get_column(petIndex)
					
					local _, _, maxX = TableUtility.max(self:_get_row_pets(row), function(i, v)
						return v.size.X
					end)
					
					local _, _, maxZ = TableUtility.max(self:_get_column_pets(column), function(i, v)
						return v.size.Z
					end)
					
					local petInstance = pet.instance
					local petUid = pet.uid

					local petCf = self:_get_cf(petUid, root, maxX, maxZ, isMoving)

					local lastCf = pet.last_lerp:Lerp(petCf, math.clamp(dt * 3, 0, 1))

					if petInstance:IsA("Model") then
						petInstance:PivotTo(lastCf)
					elseif petInstance:IsA("BasePart") then
						petInstance.CFrame = lastCf
					end

					petInstance.Name = row.." "..column

					pet.last_lerp = lastCf
				end
			end
		end
	end

	return
end

function PetGroup:get(petUid)
	local petIndex, pet = TableUtility.match(self._pets, function(i, v)
		return v.uid == petUid
	end)

	return pet, petIndex
end

function PetGroup:_get_cf(petUid, root, maxX, maxZ, isMoving)
	local pet, petIndex = self:get(petUid)

	if pet then
		local row = self:_get_row(petIndex)
		local column = self:_get_column(petIndex)
		
		local rowPets = self:_get_row_pets(row)
		local columnPets = self:_get_column_pets(column)
		
		local limitX = 0
		local fullX = 0
		
		for columnP, rowPet in pairs(rowPets) do
			local sx = if PRECISE_SPACING then rowPet.size.X else maxX
			
			if columnP < #rowPets then
				fullX += PADDING_X
			end
			
			if columnP < column then
				limitX += PADDING_X
			end
			
			if columnP == column then
				limitX += sx / 2
			elseif columnP < column then
				limitX += sx
			end
			
			fullX += sx
		end
		
		local limitZ = 0
		local fullZ = 0
		
		for rowP, columnPet in pairs(columnPets) do
			local sz = if PRECISE_SPACING then columnPet.size.Z else maxZ
				
			if rowP < #columnPets then
				fullZ += PADDING_Z
			end

			if rowP < row then
				limitZ += PADDING_Z
			end

			if rowP == row then
				limitZ += sz / 2
			elseif rowP < row then
				limitZ += sz
			end

			fullZ += sz
		end
		
		local cf = (root.CFrame - Vector3.new(0, root.Position.Y)) * CFrame.new(-fullX / 2 + limitX, if isMoving then (math.sin(tick() * 25) + 1) * 2 - 1.5 else 0, SPACE_BEHIND_CHARACTER + limitZ) * CFrame.Angles(if isMoving then math.rad(math.sin(tick() * 15) * 45) else 0, 0, 0)
		local result = workspace:Raycast(cf.Position + Vector3.new(0, root.Position.Y + 15, 0), Vector3.new(0, -65, 0), raycastParams)
		local y = if result and result.Position then result.Position.Y + pet.size.Y / 2 else root.Position.Y
		
		cf += Vector3.new(0, y, 0)
		
		return cf
	end
end

function PetGroup:_get_row(petIndex)
	return math.ceil(petIndex / PETS_PER_ROW)
end

function PetGroup:_get_column(petIndex)
	return if (petIndex % PETS_PER_ROW) == 0 then PETS_PER_ROW else (petIndex % PETS_PER_ROW)
end

function PetGroup:_get_row_pets(row)
	local filtered = ArrayUtility.filter(self._pets, function(i, v)
		return self:_get_row(i) == row
	end)
	
	table.sort(filtered, function(a, b)
		local _, caa = self:get(a.uid)
		local _, cbb = self:get(b.uid)
		local ca = self:_get_column(caa)
		local cb = self:_get_column(cbb)
		return ca < cb
	end)
	
	return filtered
end

function PetGroup:_get_column_pets(column)
	local filtered = ArrayUtility.filter(self._pets, function(i, v)
		return self:_get_column(i) == column
	end)

	table.sort(filtered, function(a, b)
		local _, caa = self:get(a.uid)
		local _, cbb = self:get(b.uid)
		local ca = self:_get_row(caa)
		local cb = self:_get_row(cbb)
		return ca < cb
	end)

	return filtered
end

function PetGroup:Destroy()
	self._trove:Destroy()
end

return PetGroup