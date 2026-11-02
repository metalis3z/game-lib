return function(Tool)
	local mag = Tool.GunModel.Magazine
	local r1 = Tool.GunModel.RoundInMag
	local r2 = Tool.GunModel.RoundInFeed
	
	local magDrop = mag:clone()
	magDrop.CanCollide = true
	magDrop.Parent = workspace
	
	local r1Drop = r1:clone()
	r1Drop.CanCollide = true
	r1Drop.Parent = magDrop
	
	local r2Drop = r2:clone()
	r2Drop.CanCollide = true
	r2Drop.Parent = magDrop
	
	local w = Instance.new("Weld")
	w.Part0 = magDrop
	w.Part1 = r1Drop
	w.C0 = mag.CFrame:toObjectSpace(r1.CFrame)
	w.Parent = magDrop
	
	local w = Instance.new("Weld")
	w.Part0 = magDrop
	w.Part1 = r2Drop
	w.C0 = mag.CFrame:toObjectSpace(r2.CFrame)
	w.Parent = magDrop
	
	local debris = game:GetService("Debris")
	debris:AddItem(magDrop,60)
	
	mag.Transparency = 1
	r1.Transparency = 1
	r2.Transparency = 1
end