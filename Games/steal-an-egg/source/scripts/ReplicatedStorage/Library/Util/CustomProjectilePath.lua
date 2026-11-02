-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastCastRedux = require(ReplicatedStorage.Library.Functions.FastCastRedux)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Bezier = require(ReplicatedStorage.Library.Functions.Bezier)
local t = {
	Types = {
		Default = "Default",
		Bezier = "Bezier"
	}
}

local function createDefaultTrajectory(p1, p2) --[[ createDefaultTrajectory | Line: 32 ]]
	return p2:Fire(p1.origin, p1.direction, p1.projectileSpeed, p1.castBehavior)
end

local function createBezierTrajectory(p1, p2, p3) --[[ createBezierTrajectory | Line: 42 | Upvalues: Bezier (copy), FastCastRedux (copy) ]]
	local origin = p1.origin
	local direction = p1.direction
	local projectileSpeed = p1.projectileSpeed
	local castBehavior = p1.castBehavior
	local v2 = p3 and p3.samples or 50
	local v3 = origin + direction * (projectileSpeed * 2)
	local v4, v5 = Bezier(table.unpack({ origin, origin:Lerp(v3, 0.5) + Vector3.new(0, p3 and p3.curveHeight or 10, 0), v3 }))
	local v6 = FastCastRedux.newBehavior()

	v6.RaycastParams = castBehavior.RaycastParams
	v6.MaxDistance = castBehavior.MaxDistance
	v6.CosmeticBulletTemplate = castBehavior.CosmeticBulletTemplate
	v6.CosmeticBulletContainer = castBehavior.CosmeticBulletContainer
	v6.AutoIgnoreContainer = castBehavior.AutoIgnoreContainer
	v6.Acceleration = Vector3.new(0, 0, 0)

	local v7 = p2:Fire(origin, direction, projectileSpeed, v6)

	task.spawn(function() --[[ Line: 73 | Upvalues: v5 (copy), projectileSpeed (copy), v2 (copy), v7 (copy), v4 (copy) ]]
		local v1 = os.clock()
		local v22 = v5 / projectileSpeed
		local count = 0

		while count < v2 and (v7 and not v7.Paused) do
			task.wait()

			local v42 = math.min((os.clock() - v1) / v22, 1)

			if v42 >= 1 then
				break
			end

			v4(v42)
			count = count + 1
		end
	end)

	return v7
end

function t.Fire(p1, p2, p3) --[[ Fire | Line: 97 | Upvalues: v1 (copy), t (copy), createBezierTrajectory (copy) ]]
	if not p2 then
		v1:AtError():Log("[CustomProjectilePath] Missing params")

		return nil
	end

	if not (p3 and p3.caster) then
		v1:AtError():Log("[CustomProjectilePath] Missing caster in overrides")

		return nil
	end

	local caster = p3.caster

	if (if p1 then p1 else t.Types.Default) == t.Types.Bezier then
		return createBezierTrajectory(p2, caster, p3)
	end

	return caster:Fire(p2.origin, p2.direction, p2.projectileSpeed, p2.castBehavior)
end

return t