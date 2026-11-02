--[[
Author: Wheez
--]]
local PlayersService=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local RunService=game:GetService("RunService")
--[[]]--
local Factor=795.2
local UI=script.Parent
local Bar=UI.Bar
--[[]]--
local OriginalSizes={}
local function AdjustText(Label)
	if typeof(OriginalSizes[Label.Name])=='nil' then
		OriginalSizes[Label.Name]=Label.TextSize
	end
	Label.TextSize=OriginalSizes[Label.Name]*(UI.AbsoluteSize.X/Factor)
end
local function UpdateAllText()
	for i, v in pairs(UI:GetChildren()) do 
		if v:IsA("TextLabel") then
			AdjustText(v)
		end
	end
end
UpdateAllText()
UI.ChildAdded:Connect(function(v: TextLabel) 
	if v:IsA("TextLabel") then
		AdjustText(v)
	end
end)
UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	UpdateAllText()
end)
--[[]]--
for i, v in pairs(UI:GetChildren()) do 
	if (not v:IsA("LocalScript")) and v.Name~="CubeHolder" then
		v.Visible=true
	end
end
UI.CubeHolder.Visible=false
--[[]]--
local CurrentBounceTweens,LastBounceRequest={},nil
UI.Instruction.Text="Just a Few More Seconds"
UI.Title.Text="Finalizing Changes"
local function TextLabelsSetup()
	TweenService:Create(UI.Title,TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{TextTransparency=0}):Play()
	delay(0.4,function()
		TweenService:Create(UI.Title,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{Position=UDim2.new(0.5,0,0.91,0)}):Play()
		TweenService:Create(UI.Instruction,TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{TextTransparency=0}):Play()
	end)
	task.wait(0.4)
end
TextLabelsSetup()
local function CreateTag(i)
	local Tag=script["Empty"]:Clone()
	Tag.Name=tostring(i)
	Tag.LayoutOrder=i
	Tag.Frame.BackgroundTransparency=1
	Tag.Frame.Size=UDim2.new(0.35,0,0.25,0)
	Tag.Parent=Bar
	return Tag
end
local function FillTag(i)
	local Tag=Bar[i]
	TweenService:Create(Tag.Frame,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{BackgroundColor3=Color3.fromRGB(55, 135, 188)}):Play()
end
local function BounceTag(i)
	local CurrentBounceClock=os.clock()
	LastBounceRequest=CurrentBounceClock
	local function ClearBounceTweens()
		for i, v in pairs(CurrentBounceTweens) do 
			v:Cancel()
			v=nil
		end
		table.clear(CurrentBounceTweens) CurrentBounceTweens={}
	end
	ClearBounceTweens()
	local Tag=Bar[i]
	spawn(function()
		while true do 
			if LastBounceRequest~=CurrentBounceClock then
				break
			end
			local Delayed=true
			local Up=TweenService:Create(Tag.Frame,TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{Position=UDim2.new(0.5,0,0.2,0)})
			Up.Completed:Connect(function()
				local Down=TweenService:Create(Tag.Frame,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(0.5,0,0.5,0)})
				Down.Completed:Connect(function()
					Delayed=false
				end)
				table.insert(CurrentBounceTweens,Down)
				Down:Play()
			end)
			table.insert(CurrentBounceTweens,Up)
			Up:Play()	
			repeat task.wait() until Delayed==false or LastBounceRequest~=CurrentBounceClock
		end
	end)
end
for i=1, 3 do 
	local NewTag=CreateTag(i)
	NewTag.Frame.Size=UDim2.new(0.7,0,0.5,0)
	NewTag.Frame.BackgroundTransparency=0
end
FillTag(1)
FillTag(2)
BounceTag(3)
PlayersService.LocalPlayer:WaitForChild("Content"):GetPropertyChangedSignal("Value"):Once(function()
	if PlayersService.LocalPlayer.Content.Value==false then return end
	TweenService:Create(UI.Title,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{TextTransparency=1}):Play()
	TweenService:Create(UI.Instruction,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{TextTransparency=1}):Play()
	TweenService:Create(UI.Bar,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{Position=UDim2.new(0.5,0,0.95,0)}):Play()	
end)