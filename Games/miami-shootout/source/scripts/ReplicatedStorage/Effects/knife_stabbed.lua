local module = {}

local running = false -- don't edit this, for the script
local camera = game.Workspace.CurrentCamera -- don't edit this, for the script
local tweenService = game:GetService("TweenService") -- don't edit this, for the script

-- blur stuff --
local maxBlur = 16 -- the blur it goes up to when playing the blur effect
local backBlur = 0 -- should always be 0 but you can change for whatever reason (how much blur it goes back to, which is 0)
local bblur = game.Lighting.EffectBLUR -- don't edit this, for the script
local secondsEnabled = 1 -- how long the effect is in total

function blur()
	bblur.Size = 0
	bblur.Enabled = true
	
	local newTween = tweenService:Create(bblur,TweenInfo.new(secondsEnabled),{ Size=maxBlur })
	newTween:Play()
	newTween.Completed:Wait()
end

function unblur()
	local returnTween = tweenService:Create(bblur,TweenInfo.new(secondsEnabled),{ Size=backBlur })
	returnTween:Play()
	returnTween.Completed:Wait()

	bblur.Enabled = false
end

function module.play()
		
	--script.sound:Play()
	
	if running then return end
	running = true
	
	spawn(blur)
	
	wait(secondsEnabled)
	
	spawn(unblur)
	running = false
	print("completed effect")
	
end

return module
