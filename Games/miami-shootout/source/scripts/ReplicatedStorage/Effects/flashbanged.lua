local module = {}

local running = false -- don't edit this, for the script
local camera = game.Workspace.CurrentCamera -- don't edit this, for the script
local tweenService = game:GetService("TweenService") -- don't edit this, for the script

-- blur stuff --
--local maxBlur = 25 -- the blur it goes up to when playing the blur effect
--local backBlur = 0 -- should always be 0 but you can change for whatever reason (how much blur it goes back to, which is 0)
--local bblur = game.Lighting.EffectBLUR -- don't edit this, for the script

local sound = game.ReplicatedStorage.EarRinging
local secondsEnabled = sound.TimeLength --2 -- how long the effect is in total

--[[
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
--]]

local cnt = 0

function module.play()
		
	--script.sound:Play()
	
	if running then return end
	running = true
	cnt = cnt + 1
	local currentCount = cnt

	delay(21,function()
		if running and currentCount == cnt then running = false print("fixed running") end
	end)
	
	local pgui = game.Players.LocalPlayer.PlayerGui
	
	local enter = pgui:FindFirstChild("Flash")
	enter.Enabled = true
	enter.Frame.BackgroundTransparency = 1
	local Frame = enter.Frame
	
	game.ReplicatedStorage.EarRinging:Play()
	
	local ok = game:GetService("TweenService"):Create(
		Frame,
		TweenInfo.new(0.15),
		{BackgroundTransparency = 0}
	)
	
	ok:Play()
	ok.Completed:Wait()
	
	wait(secondsEnabled)
	
	local ok2 = game:GetService("TweenService"):Create(
		Frame,
		TweenInfo.new(3),
		{BackgroundTransparency = 1}
	)
	
	ok2:Play()
	ok2.Completed:Wait()
	
	running = false
	game.ReplicatedStorage.EarRinging:Stop()
	
end

return module
