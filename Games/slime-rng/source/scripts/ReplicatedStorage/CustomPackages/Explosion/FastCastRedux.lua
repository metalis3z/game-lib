-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FastCastRedux, time of decompilation: Sun May  3 10:09:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t1 = {
	DebugLogging = false,
	VisualizeCasts = false
}

t1.__index = t1
t1.__type = "FastCast"
t1.PartCache = require(script.PartCache)
t1.HighFidelityBehavior = {
	Default = 1,
	Always = 3
}

local Signal = require(ReplicatedStorage.Packages.Signal)
local ActiveCast = require(script.ActiveCast)

require(script.TypeDefinitions)
ActiveCast.SetStaticFastCastReference(t1)

function t1.new() -- line: 111
	-- upvalues: Signal (copy), t1 (copy)
	return (setmetatable({
		LengthChanged = Signal.new(),
		RayHit = Signal.new(),
		RayPierced = Signal.new(),
		CastTerminating = Signal.new(),
		WorldRoot = workspace
	}, t1))
end
function t1.newBehavior() -- line: 123
	-- upvalues: t1 (copy)
	return {
		RaycastParams = nil,
		MaxDistance = 1000,
		CanPierceFunction = nil,
		HighFidelitySegmentSize = 0.5,
		CosmeticBulletTemplate = nil,
		CosmeticBulletProvider = nil,
		CosmeticBulletContainer = nil,
		AutoIgnoreContainer = true,
		Acceleration = Vector3.new(),
		HighFidelityBehavior = t1.HighFidelityBehavior.Default
	}
end

local v5 = t1.newBehavior()

function t1.Fire(t2: {[any]: any}, vector3: Vector3, vector3_2: Vector3, p1, p2) -- line: 140
	-- upvalues: v5 (copy), ActiveCast (copy)
	if p2 == nil then
		p2 = v5
	end

	local v11 = ActiveCast.new(t2, vector3, vector3_2, p1, p2)

	v11.RayInfo.WorldRoot = t2.WorldRoot

	return v11
end

return t1
