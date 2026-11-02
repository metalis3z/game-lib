
function touch(hit)
	if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Torso:FindFirstChild("BodyVelocity") ~= nil then
		
		--[[for i,v in ipairs(hit.Parent:GetChildren()) do
			local bv = Instance.new("BodyVelocity")
			bv.velocity = Vector3.new(0,4,0)
			bv.maxForce = Vector3.new(0,40000,0)
			if v:IsA("Part") then
				bv.Parent = v
			elseif v:IsA("Accessory") then
				bv.Parent = v.Handle
			end
		end]]
		--[[for i,v in ipairs(hit.Parent:GetChildren()) do
			
			if v:IsA("Part") then
				v.CanCollide = false
			elseif v:IsA("Accessory") then
				v.CanCollide = false
			end
		end]]
		--hit.Parent.Humanoid.Health = 0
	end
end
script.Parent.Touched:connect(touch)