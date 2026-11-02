math.randomseed(tick()); math.random()

local myHumanoid
local myPlayer

local waitCo


local lickNum = 0
local lastLickTime = 0
local thisLickTime = 0
local Tool = script.Parent


local BrainfreezeGui

local SpeedScript
local NewSpeed

local LickSound

local LickAnim

local haltWaitCo = false

local debris = game:GetService("Debris")

local cooldownTime = 2 -- 2-second cooldown
local lastUseTime = 0 -- time since the last use of the ice cream

function onActivated()
	if not Tool.Enabled then return 
		
	end
end
-- Check if the cooldown has elapsed
if tick() - lastUseTime < cooldownTime then
	return -- Cooldown still active, do not proceed with the function
end

myCharacter = Tool.Parent
if myCharacter then
	myHumanoid = myCharacter:FindFirstChild("Humanoid")
	if myHumanoid then
		LickSound = Tool:FindFirstChild("LickSound")
		LickAnim = Tool:FindFirstChild("LickAnim")
		if LickAnim then 
			LickAnim = myHumanoid:LoadAnimation(LickAnim)
			LickAnim:Play() 
		end
	end	
		breakWaitCo = true
		wait(0.5)
		breakWaitCo = false
		if LickSound then LickSound:Play() end
		thisLickTime = tick()
		if (thisLickTime - lastLickTime < 2) then	-- Brainfreeze
			myHumanoid:TakeDamage(0)
			myPlayer = game.Players:GetPlayerFromCharacter(myCharacter)
			if myPlayer then
				BrainfreezeGui = waitForChild(Tool, "IceCreamConeBrainfreezeGui"):Clone()
				debris:AddItem(BrainfreezeGui, 2)
				BrainfreezeGui.Parent = myPlayer.PlayerGui
			end
		end
		SpeedScript = script:FindFirstChild("IceCreamConeSpeedScript")
		if SpeedScript then
			SpeedScript = SpeedScript:Clone()
			NewSpeed = waitForChild(SpeedScript, "NewSpeed")
			if waitCo then waitCo = coroutine.yield() end
			lickNum = lickNum + 1
			if (math.random() > 1.5 / lickNum) then
				--do sugar crash
				NewSpeed.Value = 12
				waitCo = coroutine.create(function() 
					Tool.Enabled = false 
					lickNum = 0
					wait(10) 
					Tool.Enabled = true 
				end)
				coroutine.resume(waitCo)
			else
				NewSpeed.Value = 20 * lickNum
				waitCo = coroutine.create(function()
					for i = 1, 300 do
						if i == 300 then lickNum = 0 end
						if breakWaitCo then break end
						wait()
					end
				end)
				coroutine.resume(waitCo)
			end
			if myCharacter:FindFirstChild("IceCreamConeSpeedScript") then
			myCharacter.IceCreamConeSpeedScript:Remove()
			end
	elseif myCharacter:FindFirstChild("IceCreamConeSpeedScript") then
			end
		
			end
			lastLickTime = thisLickTime
			SpeedScript.Parent = myCharacter
			SpeedScript.Disabled = false

		lastUseTime = tick() -- Update the time of the last use
