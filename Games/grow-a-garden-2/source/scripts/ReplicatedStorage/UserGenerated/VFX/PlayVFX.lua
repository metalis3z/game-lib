--credit to leon games studio
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)

return function(p1, p2, p3) --[[ PlayVFX | Line: 25 | Upvalues: Debris (copy), Emit (copy) ]]
	local Attachment = Instance.new("Attachment")

	Attachment.CFrame = p1.CFrame:ToObjectSpace(p2)

	for i, v in ipairs(p3:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Parent = Attachment
		end
	end

	if p3:IsA("ParticleEmitter") then
		p3.Parent = Attachment
	else
		p3:Destroy()
	end

	Attachment.Parent = p1
	Debris:AddItem(Attachment, Emit(Attachment))
end