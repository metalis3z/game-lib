--[[
	ScientistEmoteServer
	Loops catalog emotes on the four booth Scientist NPCs (R15 Motor6D rigs;
	R6 originals live in ServerStorage.__ScientistR6Backup).
	Emote asset 80516751720529 wraps animation 105421711303774.
	Emote asset 112528616743393 wraps animation 99638411514722.
	Booths are paired so neighbouring booths play different emotes.
]]

local BOOTH_ANIMS = {
	SellShop    = "rbxassetid://105421711303774",
	UpgradeShop = "rbxassetid://105421711303774",
	DrillShop   = "rbxassetid://99638411514722",
	TrailShop   = "rbxassetid://99638411514722",
}

local map = workspace:WaitForChild("Assets"):WaitForChild("Map")

for boothName, animId in pairs(BOOTH_ANIMS) do
	task.spawn(function()
		local booth = map:WaitForChild(boothName, 30)
		local rig = booth and booth:WaitForChild("Scientist", 30)
		local humanoid = rig and rig:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			warn("[ScientistEmoteServer] No Scientist humanoid at " .. boothName)
			return
		end
		local animation = Instance.new("Animation")
		animation.Name = "ScientistEmote_" .. boothName
		animation.AnimationId = animId
		animation.Parent = script
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end
		local track = animator:LoadAnimation(animation)
		track.Looped = true
		track:Play()
	end)
end
