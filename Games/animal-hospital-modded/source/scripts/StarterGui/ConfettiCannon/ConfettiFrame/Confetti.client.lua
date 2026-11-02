local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local RunService = game:GetService("RunService")
local ConfettiParticles = require(script.ConfettiParticles)

ConfettiParticles.setGravity(Vector2.new(0, 1))

local t = {}

for i = 1, 25 do
	table.insert(t, (ConfettiParticles.createParticle(Vector2.new(0.5, 1), Vector2.new(math.random(90) - 45, math.random(70, 100)), script.Parent, { Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0) })))
end

local t2 = { Color3.fromRGB(), Color3.fromRGB() }
local v2 = false

RunService.RenderStepped:Connect(function() --[[ Line: 26 | Upvalues: t (copy), t2 (ref), v2 (ref) ]]
	for k, v in pairs(t) do
		if t2 then
			v:SetColors(t2)
		end

		v.Enabled = v2
		v:Update()
	end
end)

local function Confetti() --[[ Confetti | Line: 43 | Upvalues: t2 (ref), v2 (ref) ]]
	t2 = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0) }
	task.spawn(function() --[[ Line: 36 | Upvalues: v2 (ref) ]]
		v2 = true
		wait(tick)
		v2 = false
	end)
end

Lib.Inject("Confetti", Confetti)