local function createFakeBodyPart(character, bodyPart)
	local partName = bodyPart.Name
	local partParent = bodyPart.Parent
	local isAccessory = partParent and partParent:IsA("Accessory")
	if isAccessory then
		local handleName = partParent:GetAttribute("HDPartName")
		if not handleName then
			handleName = "Handle"..math.random(1,10000)..partParent.Name
			partParent:SetAttribute("HDPartName", handleName)
		end
		partName = handleName
	end
	local fakePartName = "Fake"..partName
	local fakePart = character:FindFirstChild(fakePartName)
	if fakePart then
		fakePart:SetAttribute("DisableMorphPart", true)
		fakePart:Destroy()
		fakePart = nil
	end
	local destroySpecialMesh = false
	local specialMesh = bodyPart:FindFirstChildOfClass("SpecialMesh")
	local keepSpecialMesh = false
	local partNameWithoutSpaces = partName:gsub(" ","")
	for _, item in character:GetChildren() do
		-- This helps find the mesh part for R6 characters
		if item:IsA("CharacterMesh") then
			local bodyPartName = item.BodyPart.Name
			if partNameWithoutSpaces:match(bodyPartName) then
				specialMesh = Instance.new("SpecialMesh")
				specialMesh.MeshId = "rbxassetid://"..item.MeshId
				destroySpecialMesh = true
			end
		end
	end
	if specialMesh then
		local meshId = specialMesh.MeshId
		if not meshId or meshId =="" or meshId == " " then
			-- This is for R6 characters with standard (not emotable) heads
			keepSpecialMesh = true
		else
			local InsertService = game:GetService("InsertService")
			local success, insertedFakePart = pcall(function()
				return InsertService:CreateMeshPartAsync(meshId, Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
			end)
			if success and insertedFakePart then
				local scale = specialMesh.Scale
				fakePart = insertedFakePart
				fakePart.Size *= scale
				fakePart.CFrame = bodyPart.CFrame
			end
		end
		if destroySpecialMesh then
			specialMesh:Destroy()
		end
	end
	if not fakePart then
		fakePart = bodyPart:Clone()
	end
	for _, child in fakePart:GetChildren() do
		if child:IsA("WrapLayer") then
			child.Order -= 20
			continue
		end
		-- Roblox sizes parts from OriginalSize whenever an outfit is applied. A body
		-- part copy wants to keep it so it scales in step with the real one, but an
		-- accessory copy sits loose in the character instead of inside its Accessory,
		-- so it gets sized as though it were never scaled down and blows up
		local isOriginalSize = child.Name == "OriginalSize" and child:IsA("Vector3Value")
		if isOriginalSize and not isAccessory then
			continue
		end
		child:Destroy()
	end
	if keepSpecialMesh then
		specialMesh:Clone().Parent = fakePart
	end
	fakePart.CanCollide = false
	fakePart.CanTouch = false
	if fakePart:IsA("MeshPart") then
		fakePart.TextureID = ""
	end
	fakePart.Name = "Fake"..partName
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = fakePart
	weld.Part1 = bodyPart
	weld.Parent = fakePart
	bodyPart.Transparency = 1
	local connections = {}
	local head = character:FindFirstChild("Head")
	local partToListen = if isAccessory and head then head else bodyPart
	fakePart.Color = partToListen.Color
	fakePart.Parent = character
	table.insert(connections, partToListen:GetPropertyChangedSignal("Color"):Once(function()
		fakePart.Color = partToListen.Color
	end))
	fakePart.Destroying:Once(function()
		for _, connection in connections do
			connection:Disconnect()
		end
	end)
	return fakePart
end

local function clearFakeBodyParts(character)
	for _, descendant in character:GetDescendants() do
		if descendant:IsA("BasePart") then
			if string.sub(descendant.Name, 1, 4) == "Fake" then
				descendant:SetAttribute("DisableMorphPart", true)
				descendant:Destroy()
			elseif descendant.Name ~= "HumanoidRootPart" then
				descendant.Transparency = 0
			end
		end
	end
end

local function setFakePart(char, info, part)
	task.defer(function()
		local partName = part.Name
		local partParent = part.Parent
		local accessoryName = if partParent and partParent:IsA("Accessory") then partParent.Name else nil
		local fakePart = createFakeBodyPart(char, part)
		local connections = {}
		local function disconnectAll()
			for _, connection in connections do
				connection:Disconnect()
			end
		end
		local function charIsAlive()
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			return char.Parent ~= nil and humanoid ~= nil and humanoid.Health > 0
		end
		local function refakeReplacement()
			if fakePart:GetAttribute("DisableMorphPart") or not charIsAlive() then
				return
			end
			if not accessoryName then
				local newPart = char:WaitForChild(partName, 4)
				if newPart then
					setFakePart(char, info, newPart)
				end
				return
			end
			-- Accessory handles sit inside the Accessory and are all named 'Handle',
			-- so WaitForChild on the character can never find them. ApplyDescription
			-- rebuilds accessories as fresh instances, meaning we match the
			-- replacement by accessory name instead, and claim it so two same-named
			-- accessories (like paired katanas) each re-fake their own
			for _ = 1, 40 do
				for _, child in char:GetChildren() do
					if child:IsA("Accessory") and child.Name == accessoryName and not child:GetAttribute("HDPartName") and not child:GetAttribute("HDFakeClaimed") then
						local newHandle = child:FindFirstChildWhichIsA("BasePart")
						if newHandle then
							child:SetAttribute("HDFakeClaimed", true)
							setFakePart(char, info, newHandle)
							return
						end
					end
				end
				task.wait(0.1)
				if not charIsAlive() then
					return
				end
			end
		end
		table.insert(connections, part.Destroying:Once(function()
			disconnectAll()
			fakePart:Destroy()
			refakeReplacement()
		end))
		table.insert(connections, part:GetPropertyChangedSignal("Size"):Once(function()
			-- A resize keeps the part alive (like a character scale change), so the
			-- same part re-fakes directly at its new size
			disconnectAll()
			fakePart:Destroy()
			if not fakePart:GetAttribute("DisableMorphPart") and charIsAlive() then
				setFakePart(char, info, part)
			end
		end))
		for pName, pValue in info do
			if pName == "Material" then
				fakePart.Material = pValue
				if pValue == Enum.Material.Glass then
					fakePart.Transparency = 0.5
				else
					fakePart.Transparency = 0
				end
			elseif pName == "Reflectance" then
				fakePart.Reflectance = pValue
			elseif pName == "Transparency" then
				fakePart.Transparency = pValue
			elseif pName == "Color" then
				fakePart.Color = pValue
			end
		end
	end)
end

local function checkBodyPart(part: BasePart)
	if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and string.sub(part.Name,1,4) ~= "Fake" then
		return true
	else
		return false
	end
end

local function setFakeBodyParts(char: Model, info: {[string]: any}): (() -> ())?
	if not char then return nil end
	for _, descendant in char:GetDescendants() do
		local itemParent = descendant.Parent
		if (itemParent == char or (itemParent and itemParent:IsA("Accessory"))) and checkBodyPart(descendant) then
			setFakePart(char, info, descendant)
		end
	end
	-- Morphs can introduce entirely new accessories while the effect runs (like
	-- Dinofy's tail), which no dead fake ever re-fakes, so they get faked as they
	-- arrive
	local connection = char.ChildAdded:Connect(function(child)
		if not child:IsA("Accessory") then
			return
		end
		task.defer(function()
			if child:GetAttribute("HDPartName") or child:GetAttribute("HDFakeClaimed") then
				return
			end
			local handle = child:FindFirstChildWhichIsA("BasePart") or child:WaitForChild("Handle", 4)
			if handle and handle:IsA("BasePart") and checkBodyPart(handle) and child.Parent == char then
				setFakePart(char, info, handle)
			end
		end)
	end)
	return function()
		connection:Disconnect()
	end
end

return setFakeBodyParts