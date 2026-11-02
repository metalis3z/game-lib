local anim = script.Parent.AnimationController
local animplay = script.Parent.Animations.Rest
local animplay2 = script.Parent.Animations.RestAnim2

local animgoodplayrect = anim:LoadAnimation(animplay)
local animgoodplayrect2 = anim:LoadAnimation(animplay2)

animgoodplayrect:Play()

script.Parent.InteractPrompt.Triggered:Connect(function(plr)
	local random = math.random(1, 3)
	if random == 1 then
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'Whats happening?')
		animgoodplayrect2:Play()
		wait(animgoodplayrect2.Length)
		animgoodplayrect:Play()
	elseif random == 2 then
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'Nothing happening')
	elseif random == 3 then
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'Bob?')
	end
end)