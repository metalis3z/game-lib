

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.UserGenerated.VFX.Emit)
return function(p4, p5, p6)
	local v7 = Instance.new("Attachment")
	v7.CFrame = p4.CFrame:ToObjectSpace(p5)
	for _, v8 in ipairs(p6:GetDescendants()) do
		if v8:IsA("ParticleEmitter") then
			v8.Parent = v7
		end
	end
	if p6:IsA("ParticleEmitter") then
		p6.Parent = v7
	else
		p6:Destroy()
	end
	v7.Parent = p4
	v_u_1:AddItem(v7, v_u_3(v7))
end
