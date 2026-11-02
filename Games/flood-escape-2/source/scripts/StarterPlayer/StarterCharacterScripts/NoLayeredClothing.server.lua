local PhysicsService = game:GetService("PhysicsService")
local Player_Character = script.Parent

local function clearLayeredClothingSingle(a)
	if a:IsA("Accessory") then
		local des = a:GetDescendants()
		for _,c in next, des do
			if c:IsA("WrapLayer") then
				a:Destroy()
				return
			end
		end
	end
end

for _,c in next, script.Parent:GetChildren() do
	clearLayeredClothingSingle(c)
end
script.Parent.ChildAdded:Connect(clearLayeredClothingSingle)