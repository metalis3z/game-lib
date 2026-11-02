return function(Tool)
	local mag = Tool.GunModel.Magazine
	
	local magDrop = mag:clone()
	magDrop.CanCollide = true
	magDrop.Parent = workspace
	
	for a = 0,14 do
		local b = Tool.GunModel:findFirstChild("Bullet" .. a)
		if (b) then
			local bD = b:clone()
			bD.Parent = magDrop
			bD.CanCollide = true
			
			local w = Instance.new("Weld")
			w.C0 = mag.CFrame:toObjectSpace(b.CFrame)
			w.Part0 = magDrop
			w.Part1 = bD
			w.Parent = magDrop
			
			b.Transparency = 1
		end
	end
	
	local debris = game:GetService("Debris")
	debris:AddItem(magDrop,60)
	
	mag.Transparency = 1
end