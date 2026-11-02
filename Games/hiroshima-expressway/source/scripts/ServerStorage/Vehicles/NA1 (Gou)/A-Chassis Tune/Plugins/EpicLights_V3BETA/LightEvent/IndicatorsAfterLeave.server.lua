local TweenService = game:GetService("TweenService")
local event = script.Parent.OnLeave
local lights = script.Parent.Parent.Body.Lights

local L = false
local R = false
local HZ = false
local SEQ = false
local MAX_SEGS
local flash_R
local l_type
local ind_tweeninfo

script.Parent.Parent.DriveSeat.ChildAdded:Connect(function()
	L = false
	R = false
	HZ = false
	script.Disabled = true
end)
event.Event:Connect(function(left, right, hazard, sequential, segs, fr, type)
	flash_R = fr
	l_type = type
	ind_tweeninfo = TweenInfo.new(fr / 2.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
	if left then
		L = true
	elseif right then
		R = true
	elseif hazard then
		HZ = true
	end	
	if sequential then
		SEQ = true
		MAX_SEGS = segs
	end
end)

while wait() do
	if SEQ then
		if L then

		end
		if R then
			
		end
		if HZ then

		end
	else
		if L then
			if l_type == "Halogen" then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 1}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 0.02}):Play()
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 0}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
					end
				end
				wait(flash_R)
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 1
					elseif v.Name == "LN" then
						v.Transparency = 0.02
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 0
					elseif v.Name == "LN" then
						v.Transparency = 1
					end
				end
				wait(flash_R)
			end
		end
		if R then
			if l_type == "Halogen" then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 1}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 0.02}):Play()
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 0}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
					end
				end
				wait(flash_R)
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 1
					elseif v.Name == "LN" then
						v.Transparency = 0.02
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 0
					elseif v.Name == "LN" then
						v.Transparency = 1
					end
				end
				wait(flash_R)
			end
		end
		if HZ then
			if l_type == "Halogen" then
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 1}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 0.02}):Play()
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 1}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 0.02}):Play()
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 0}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						TweenService:Create(v, ind_tweeninfo, {Brightness = 0}):Play()
					elseif v.Name == "LN" then
						TweenService:Create(v, ind_tweeninfo, {Transparency = 1}):Play()
					end
				end
				wait(flash_R)
			else
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 1
					elseif v.Name == "LN" then
						v.Transparency = 0.02
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 1
					elseif v.Name == "LN" then
						v.Transparency = 0.02
					end
				end
				wait(flash_R)
				for i, v in pairs(lights.LeftInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 0
					elseif v.Name == "LN" then
						v.Transparency = 1
					end
				end
				for i, v in pairs(lights.RightInd:GetDescendants()) do
					if v:IsA("Light") and v.Name == "L" then
						v.Brightness = 0
					elseif v.Name == "LN" then
						v.Transparency = 1
					end
				end
				wait(flash_R)
			end
		end
	end		
end