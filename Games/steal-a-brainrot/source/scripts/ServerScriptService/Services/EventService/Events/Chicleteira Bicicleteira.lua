local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local ChicleteiraBicicleteira = {}
local IsActive = false
local SprayTimer = nil
local Clones = nil

local SpawnChicleteira = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/SpawnChicleteira")
local Burst = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/Burst")

local function AvoidDuplications()
	if Clones then
		if Clones.Parent then Clones:Destroy() end
		Clones = nil
	end
end

function ChicleteiraBicicleteira.OnStart()
	if IsActive then return end
	IsActive = true

	SpawnChicleteira:FireAllClients(
		CFrame.new(-419.394, -9.074, -132.1) * CFrame.Angles(0, math.rad(180), 0),
		CFrame.new(-419.394, -9.074, 251.706) * CFrame.Angles(0, math.rad(180), 0),
		75,
		nil
	)
	SpawnChicleteira:FireAllClients(
		CFrame.new(-402.863, -9.074, -132.1) * CFrame.Angles(0, math.rad(180), 0),
		CFrame.new(-402.863, -9.074, 251.706) * CFrame.Angles(0, math.rad(180), 0),
		75,
		nil
	)

	task.wait(5)

	AvoidDuplications()

	Clones = script:WaitForChild("Chicleteras"):Clone()
	Clones.Parent = workspace

	if SprayTimer then task.cancel(SprayTimer) SprayTimer = nil end

	SprayTimer = task.spawn(function()
		while IsActive do
			task.wait(math.random(8, 16))
			if not IsActive then break end

			local chicleteras = {}
			if Clones and Clones.Parent then
				for _, obj in Clones:GetChildren() do
					table.insert(chicleteras, obj)
				end
			end
			if #chicleteras == 0 then continue end

			local chicletera = chicleteras[math.random(1, #chicleteras)]
			local pos = chicletera:GetPivot().Position
			local closest = nil
			local best = 50

			for _, animal in CollectionService:GetTagged("Animal") do
				if animal.PrimaryPart then
					local dist = (animal.PrimaryPart.Position - pos).Magnitude
					if dist < best then
						best = dist
						closest = animal
					end
				end
			end

			if not closest then continue end

			local raw = closest:GetAttribute("Traits") or "[]"
			local success, traits = pcall(HttpService.JSONDecode, HttpService, raw)
			if not success or type(traits) ~= "table" then continue end

			local hasPaint = false
			for _, t in traits do
				if t == "Paint" then hasPaint = true break end
			end

			if not hasPaint then
				chicletera:SetAttribute("ForceSpray", closest.Name)
				task.wait(1.4)
				local _raw = closest:GetAttribute("Traits") or "[]"
				local _ok, _traits = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), _raw)
				if _ok and type(_traits) == "table" then
					local _has = false
					for _, _t in ipairs(_traits) do if _t == "Paint" then _has = true break end end
					if not _has then
						table.insert(_traits, "Paint")
						closest:SetAttribute("Traits", game:GetService("HttpService"):JSONEncode(_traits))
					end
				end
				Burst:FireAllClients(closest.Name)
				chicletera:SetAttribute("ForceSpray", nil)
			end
		end
	end)
end

function ChicleteiraBicicleteira.OnStop()
	if not IsActive then return end
	IsActive = false

	if SprayTimer then task.cancel(SprayTimer) SprayTimer = nil end
	AvoidDuplications()
end

return ChicleteiraBicicleteira