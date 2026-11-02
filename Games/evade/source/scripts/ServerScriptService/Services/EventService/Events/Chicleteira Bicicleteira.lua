local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local ChicleteraBicicleteira = {}
local IsActive = false
local SprayTimer = nil
local Clones = nil

local SpawnChicleteira = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/SpawnChicleteira")
local Burst = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/Burst")

function ChicleteraBicicleteira.OnStart()
	if IsActive then return end

	SpawnChicleteira:FireAllClients(
		CFrame.new(-419.394, -9.074, -132.1) * CFrame.Angles(0, math.rad(180), 0),
		CFrame.new(-419.394, -9.074, 251.706) * CFrame.Angles(0, math.rad(180), 0),
		35,
		nil
	)
	SpawnChicleteira:FireAllClients(
		CFrame.new(-402.863, -9.074, -132.1) * CFrame.Angles(0, math.rad(180), 0),
		CFrame.new(-402.863, -9.074, 251.706) * CFrame.Angles(0, math.rad(180), 0),
		35,
		nil
	)

	task.wait(5)

	Clones = script:WaitForChild("Chicleteras"):Clone()
	Clones.Parent = workspace

	if SprayTimer then
		pcall(task.cancel, SprayTimer)
	end

	SprayTimer = task.spawn(function()
		while IsActive do
			local waitTime = math.random(8, 16)
			task.wait(waitTime)

			if not IsActive then break end

			local chicleteras = {}
			if Clones and Clones.Parent then
				for _, obj in ipairs(Clones:GetChildren()) do
					table.insert(chicleteras, obj)
				end
			end

			if #chicleteras == 0 then continue end

			local chicletera = chicleteras[math.random(1, #chicleteras)]
			local chicleteraPos = chicletera:GetPivot().Position

			local closest = nil
			local closestDist = 50
			local animals = CollectionService:GetTagged("Animal")

			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local dist = (animal.PrimaryPart.Position - chicleteraPos).Magnitude
					if dist < closestDist then
						closest = animal
						closestDist = dist
					end
				end
			end

			if not closest then continue end

			local traitsRaw = closest:GetAttribute("Traits") or "[]"
			local success, decoded = pcall(function()
				return HttpService:JSONDecode(traitsRaw)
			end)

			if success and type(decoded) == "table" then
				local hasPaint = false
				for _, t in ipairs(decoded) do
					if t == "Paint" then
						hasPaint = true
						break
					end
				end

				if not hasPaint then
					chicletera:SetAttribute("ForceSpray", closest.Name)
					task.wait(1.4)
					decoded[#decoded+1] = "Paint"
					closest:SetAttribute("Traits", HttpService:JSONEncode(decoded))
					Burst:FireAllClients(closest.Name)
					chicletera:SetAttribute("ForceSpray", nil)
				end
			end
		end
	end)
end

function ChicleteraBicicleteira.OnStop()
	if not IsActive then return end
	IsActive = false

	if Clones and Clones.Parent then
		for _, chicletera in ipairs(Clones:GetChildren()) do
			chicletera:SetAttribute("ForceSpray", nil)
		end
		Clones:Destroy()
		Clones = nil
	end
end

return ChicleteraBicicleteira
