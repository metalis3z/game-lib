return function(rag)
	local torso = rag:FindFirstChild("UpperTorso") or rag:FindFirstChild("Torso")
	for _, v in ipairs(script:GetChildren()) do
		local clone = v:Clone()

		if clone:IsA("ParticleEmitter") then
			local att = torso:FindFirstChild("EffectAttachment")
			if not att then
				att = Instance.new("Attachment")
				att.Name = "EffectAttachment"
				att.Parent = torso
			end
			clone.Parent = att
		else
			clone.Parent = torso
		end
	end
end
