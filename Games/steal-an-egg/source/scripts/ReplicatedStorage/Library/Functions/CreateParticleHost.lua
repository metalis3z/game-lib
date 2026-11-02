-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local v1 = t.optional(t.union(t.CFrame, t.Vector3))

return function(p1, p2) --[[ CreateParticleHost | Line: 8 | Upvalues: v1 (copy), Asserts (copy) ]]
	assert(v1(p1))
	Asserts.optional.BasePart(p2)

	local Attachment = Instance.new("Attachment")

	if p2 then
		Attachment.Parent = p2

		return p2, Attachment
	end

	if typeof(p1) ~= "CFrame" then
		p1 = CFrame.new(p1)
	end

	local host = Instance.new("Part")

	host.Anchored = true
	host.CanCollide = false
	host.CanQuery = false
	host.CanTouch = false
	host.Transparency = 1
	host.CastShadow = false
	host.Size = Vector3.new(0, 0, 0)
	host.CFrame = p1
	host.Name = "host"
	Attachment.Parent = host
	host.Parent = workspace:WaitForChild("__DEBRIS")

	return host, Attachment
end