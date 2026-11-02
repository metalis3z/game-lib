local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(17,Enum.EasingStyle.Cubic,Enum.EasingDirection.In)
local MTransform = tweenService:Create(script.Parent.Head.MouthBH,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local RLTransform = tweenService:Create(script.Parent["Right Leg"].RightLegParts,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local LLTransform = tweenService:Create(script.Parent["Left Leg"].LeftLegParts,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local RA1Transform = tweenService:Create(script.Parent["Right Arm"].RightArmParts1,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local RA2Transform = tweenService:Create(script.Parent["Right Arm"].RightArmParts2,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local RA3Transform = tweenService:Create(script.Parent["Right Arm"].RightArmParts3,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local LA1Transform = tweenService:Create(script.Parent["Left Arm"].LeftArmParts1,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local LA2Transform = tweenService:Create(script.Parent["Left Arm"].LeftArmParts2,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local LA3Transform = tweenService:Create(script.Parent["Left Arm"].LeftArmParts3,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local TTransform = tweenService:Create(script.Parent.Torso,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local BTransform = tweenService:Create(script.Parent.Torso.Bone,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local HPTransform = tweenService:Create(script.Parent.Head.HeadPart,TweenInfoo,{Color = Color3.fromRGB(48, 48, 49)})
local MSize = tweenService:Create(script.Parent.Head.MouthBH,TweenInfoo,{Size = Vector3.new(0.789, 0.638, 1.192)})
local M2Size = tweenService:Create(script.Parent.Head.Mouth1_2BH,TweenInfoo,{Size = Vector3.new(0.789, 0.638, 1.192)})
local E1Size = tweenService:Create(script.Parent.Head.Eye1,TweenInfoo,{Size = Vector3.new(0.159, 0.239, 0.179)})
local E2Size = tweenService:Create(script.Parent.Head.Eye2,TweenInfoo,{Size = Vector3.new(0.159, 0.239, 0.179)})
while true do
	wait()
	if workspace.ShadowHourFunction.Value == true then
		M2Size:Play()
		MSize:Play()
		MTransform:Play()
		RLTransform:Play()
		LLTransform:Play()
		RA1Transform:Play()
		RA2Transform:Play()
		RA3Transform:Play()
		LA1Transform:Play()
		LA2Transform:Play()
		LA3Transform:Play()
		TTransform:Play()
		BTransform:Play()
		HPTransform:Play()
		script.Parent.Head.Mouth.MovingMouth.Disabled = true
		script.Parent.Head.Mouth.Transparency = 1
		script.Parent.Head.Mouth1_2.Transparency = 1
		script.Parent.Head.MouthBH.Transparency = 0
		script.Parent.MainScript.Disabled = true
		script.Parent.BHMainScript.Disabled = true
		script.Parent.BHStun.Disabled = true
		script.Parent.BHStun2.Disabled = true
		script.Parent.Stun.Disabled = true
		script.Parent.Stun2.Disabled = true
		script.Parent.Head.Mouth.MovingMouth.Disabled = true
		script.Parent.Head.Mouth.Transparency = 1
		script.Parent.Head.Mouth1_2.Transparency = 1
		script.Parent.Head.MouthBH.Transparency = 0
		script.Parent.Head.Mouth.DecomposeScript.Disabled = true
		script.Parent.Head.Mouth1_2.DecomposeScript.Disabled = true
		script.Parent.Head.Mouth1_2BH.DecomposeScript.Disabled = false
		script.Parent.Head.MouthBH.DecomposeScript.Disabled = false
	end
end