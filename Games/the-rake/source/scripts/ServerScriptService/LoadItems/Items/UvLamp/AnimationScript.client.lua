-- Waits for the child of the specified parent
local function WaitForChild(parent, childName)
	while not parent:FindFirstChild(childName) do parent.ChildAdded:wait() end
	return parent[childName]
end

local Tool = script.Parent

local Animations = {}
local MyHumanoid
local MyCharacter


local function PlayAnimation(animationName)
	if Animations[animationName] then
		Animations[animationName]:Play()
	end
end

local function StopAnimation(animationName)
	if Animations[animationName] then
		Animations[animationName]:Stop()
	end
end


function OnEquipped(mouse)
	MyCharacter = Tool.Parent
	MyHumanoid = WaitForChild(MyCharacter, 'Humanoid')
	if MyHumanoid then
		Animations['IdleAnim'] = MyHumanoid:LoadAnimation(WaitForChild(Tool, 'IdleAnim'))
	end
	PlayAnimation('IdleAnim')
end

function OnUnequipped()
	for animName, _ in pairs(Animations) do
		StopAnimation(animName)
	end
end

Tool.Equipped:connect(OnEquipped)
Tool.Unequipped:connect(OnUnequipped)
