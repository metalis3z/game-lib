local module = {}

local running = false -- don't edit this, for the script
_G.HsRunning = false -- don't edit this, for other scripts to know
local camera = game.Workspace.CurrentCamera -- don't edit this, for the script
local tweenService = game:GetService("TweenService") -- don't edit this, for the script

-- camera stuff --
local defaultFOV = 69 -- this is roblox's default fov
local hsFOV = 65 -- this is how much the camera will zoom to (higher = farther, lower = zooming in more)
local secondsEnabled = 0.1 -- how long the effect is in total

-- blur stuff --
local maxBlur = 15 -- the blur it goes up to when playing the blur effect
local backBlur = 0 -- should always be 0 but you can change for whatever reason (how much blur it goes back to, which is 0)
local bblur = game.Lighting.GunHSBLUR -- don't edit this, for the script

-- post processing stuff --
local maxBrightness = 0.2 -- how much the colorcorrection should go to (negative for darker, positive for brighter)
local backBrightness = 0 -- should always be 0 but you can change for whatever reason (how much cc it goes back to, which is 0) 
local colorCorrector = game.Lighting.GunHSCC
local unblurDifference = 0.05 -- the time window in which it waits before showing cc after it blurs

function POSTPROCESS(val)
	if val == "enable" then
		colorCorrector.Brightness = 0
		--colorCorrector.Contrast = 0
		--colorCorrector.TintColor = Color3.new(255,255,255)
		--colorCorrector.Saturation = 0
	
		colorCorrector.Enabled = true
	
		local newTween = tweenService:Create(colorCorrector,TweenInfo.new(secondsEnabled),{ Brightness=maxBrightness })
		newTween:Play()
	end	
	if val == "disable" then
		local newTween = tweenService:Create(colorCorrector,TweenInfo.new(secondsEnabled),{ Brightness=backBrightness })
		local yield = false
		delay(4,function()
			if yield == false then
				print("didn't end")
				newTween:Stop()
				colorCorrector.Enabled = false
			end
		end)
		newTween:Play()
		newTween.Completed:Wait()
		yield = true
		colorCorrector.Enabled = false
		print("ended")
	end	
end

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
		
	script.sound:Play()
	
	if running then return end
	_G.HsRunning = true
	running = true
	
	spawn(blur)
	delay(unblurDifference,function()
		spawn(function() POSTPROCESS("enable") end)
	end)
	local newTween = tweenService:Create(camera,TweenInfo.new(secondsEnabled),{ FieldOfView=hsFOV })
	newTween:Play()
	newTween.Completed:Wait()
	
	spawn(unblur)
	--delay(0.05,function()
	spawn(function() POSTPROCESS("disable") end)

	local returnTween = tweenService:Create(camera,TweenInfo.new(secondsEnabled),{ FieldOfView=defaultFOV })
	returnTween:Play()
	returnTween.Completed:Wait()
	running = false
	_G.HsRunning = false
	print("completed effect")
	
end
spawn(function()
	while wait(1) do
		if running == false and colorCorrector.Enabled == true then
			colorCorrector.Enabled = false
			print("gun fix")
		end
	end
end)



return module
