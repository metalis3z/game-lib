
local t = game:GetService("TweenService")
local tInfo = TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local tInfo2 = TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local textLabel = script.Parent:WaitForChild("TextLabel")
local awardLabel = script.Parent:WaitForChild("AwardLabel")
local awardBeat = script.Parent:WaitForChild("AwardBeat")
local awardBeat2 = script.Parent:WaitForChild("AwardBeat2")
local awardBeat3 = script.Parent:WaitForChild("AwardBeat3")

local awardAppear = t:Create(awardLabel,tInfo,{TextTransparency = 0,TextStrokeTransparency = 0})
local textAppear = t:Create(textLabel,tInfo,{TextTransparency = 0,TextStrokeTransparency = 0})
local awardDisappear = t:Create(awardLabel,tInfo2,{TextTransparency = 1,TextStrokeTransparency = 1})
local textDisappear = t:Create(textLabel,tInfo2,{TextTransparency = 1,TextStrokeTransparency = 1})

workspace.Values.Died.Changed:Connect(function()
	if workspace.Values.Died.Value == true then
		wait(2)
		local aSound = math.random(3)
		if aSound == 1 then
			awardBeat:Play()
		elseif aSound == 2 then
			awardBeat2:Play()
		elseif aSound == 3 then
			awardBeat3:Play()
		end
		textAppear:Play()
		wait(1)
		awardAppear:Play()
		wait(7)
		textDisappear:Play()
		awardDisappear:Play()
	end
end)