function Poison(lastTime)

	local character = script.Parent
	local humanoid = character:FindFirstChild("Humanoid")

	


	local childs = character:GetChildren()

	local colors = {}

	for i=1,#childs do
		if (childs[i].className == "Part") then
			colors[i] = childs[i].BrickColor
			childs[i].BrickColor = BrickColor.new(119)
		end
	end

	wait(1)
	
	for i=1,#childs do
		if (childs[i].className == "Part") then
			childs[i].BrickColor = colors[i]
		end
	end

	
	tagHumanoid(humanoid)
	humanoid.Health = humanoid.Health - (humanoid.MaxHealth / 8) -- forcefield won't stop poison damage
	wait(1)
	--untagHumanoid(humanoid)

end

function tagHumanoid(humanoid)
	local poisoner = script:FindFirstChild("poisoner")
	
	if (poisoner ~= nil) then

		local creator_tag = Instance.new("ObjectValue")
		creator_tag.Value = poisoner.Value
		creator_tag.Name = "creator"
		creator_tag.Parent = humanoid
		game.Debris:AddItem(creator_tag, 1)
	end
end

for i=1,5 do
	Poison(i == 5)
	wait(.1)
end


script.Parent = nil