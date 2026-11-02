debounce = false



function touch(hit)
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("HumanoidRootPart") and hit.Parent.HumanoidRootPart:FindFirstChild("BodyVelocity") == nil then
		debounce = true
		--hit.Parent.Humanoid.Sit = true
		
		pcall(function()
			
			hit.Parent.Humanoid.Sit = false
			wait()
			hit.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			local bv = Instance.new("BodyVelocity")
			bv.velocity = Vector3.new(0,4,0)
			bv.maxForce = Vector3.new(0,40000,0)
			bv.Parent = hit.Parent.HumanoidRootPart
			delay(6,function()
				if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
					hit.Parent.Humanoid.Health = 0
				end
			end)
		end)
		
		
		
		debounce = false
	end
end
script.Parent.Touched:connect(touch)