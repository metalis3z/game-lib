-- SERVICES --

local Players = game:GetService('Players')
local BadgeService = game:GetService('BadgeService')
local TweenService = game:GetService('TweenService')

-- INSTANCES --

local AlignOrientation = script.Parent.AlignOrientation

-- FUNCTION --

function RotateBlimp()

	local BlimpTween = TweenService:Create(AlignOrientation, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		CFrame = AlignOrientation.CFrame * CFrame.Angles(math.rad(-1), math.rad(180), 0)
	})

	BlimpTween:Play()

	return BlimpTween

end
-- MAIN SCRIPT --

AlignOrientation.CFrame = script.Parent.CFrame * CFrame.Angles(math.rad(-1), 0, 0)

wait(23)

RotateBlimp().Completed:Connect(function()

	wait(3)

	RotateBlimp().Completed:Connect(function()

		wait(20)

		script.Parent:Destroy()

	end)

end)