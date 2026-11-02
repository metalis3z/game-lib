Tool = script.Parent

local field = nil

function Heal()

	

	local vCharacter = Tool.Parent

	local childs = vCharacter:GetChildren()

	local colors = {}

	for i=1,#childs do
		if (childs[i].className == "Part") then
			colors[i] = childs[i].BrickColor
			childs[i].BrickColor = BrickColor.new(1)
		end
	end

	wait(1)

	local human = vCharacter:FindFirstChild("Humanoid")
	if (human ~= nil) then
		human.Health = human.MaxHealth
	end

	for i=1,#childs do
		if (childs[i].className == "Part") then
			childs[i].BrickColor = colors[i]
		end
	end


end



Tool.Enabled = true
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	Heal()

	Tool.Parent = nil
end


script.Parent.Activated:connect(onActivated)



