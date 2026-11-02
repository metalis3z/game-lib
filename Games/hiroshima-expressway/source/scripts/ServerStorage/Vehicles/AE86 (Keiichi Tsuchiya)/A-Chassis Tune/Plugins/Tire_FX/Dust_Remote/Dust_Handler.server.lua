local remote = script.Parent
local car = remote.Parent
local emitterFolder = remote.ParticleEmitters

--- SETUP

-- Clone particle emitters to each wheel
for _, wheel in pairs(car.Wheels:GetChildren()) do
	for _, emitter in pairs(emitterFolder:GetChildren()) do
		local emitterClone = emitter:Clone()
		emitterClone.Parent = wheel
	end
end

--- UPDATE

-- Update particle emitters
local function Update(_, Surfaces, wheelInfo)
	for _, wheel in pairs(car.Wheels:GetChildren()) do
		for surfaceName, _ in pairs(Surfaces) do

			-- Ignore invalid surfaces
			if not wheel:FindFirstChild(surfaceName .. "Emitter") then continue; end

			-- Update particle emitter
			local emitter = wheel[surfaceName .. "Emitter"]
			emitter.Rate = wheelInfo[wheel.Name]["Rate"]
			emitter.Enabled = wheelInfo[wheel.Name][surfaceName .. "Enabled"]
		end
	end
end

remote.OnServerEvent:Connect(Update)