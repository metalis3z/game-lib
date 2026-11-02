local v8 = {}
function v8.ToggleObservantVFX(p330, p331)
	if p330.Rig.PrimaryPart and p330.Rig:FindFirstChild("Head") and p330.Rig.Head:FindFirstChild("HalluEye") then
		p330.Rig.Head.HalluEye:FindFirstChildOfClass("ParticleEmitter").Enabled = p331
	end
end
return v8