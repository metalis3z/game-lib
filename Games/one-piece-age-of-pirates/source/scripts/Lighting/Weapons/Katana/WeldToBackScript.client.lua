handle = nil

function onUnequipped()
	if script.Parent.Parent == workspace or script.Parent.Parent.className ~= "Backpack" then
		return
	end

	local char = script.Parent.Parent.Parent.Character
	if char ~= nil then
		local torso = char:findFirstChild("Torso")
		local tool = char:findFirstChild(script.Parent.Name)
		if torso ~= nil and tool == nil then
			local model = Instance.new("Model")
			model.Name = "Handle"
			model.Parent = char

			handle = script.Parent.Handle:clone()
			handle.CanCollide = false
			handle.Name = "Handle"
			handle.Parent = model

			local weld = Instance.new("Weld")
			weld.Name = "BackWeld"
			weld.Part0 = torso
			weld.Part1 = handle
			weld.C0 = CFrame.new(-1, -1, 0.5)
			weld.C0 = weld.C0 * CFrame.fromEulerAnglesXYZ(math.rad(10),math.rad(0),-30)
			weld.Parent = handle
		end
	end
end

script.Parent.Unequipped:connect(onUnequipped)

function onEquipped()
	if handle ~= nil then 
		handle.Parent:remove()
	end
end

script.Parent.Equipped:connect(onEquipped)
		