-- SERVICES --

local Players = game:GetService('Players')
local BadgeService = game:GetService('BadgeService')
local TweenService = game:GetService('TweenService')

-- INSTANCES --

local AlignOrientation = script.Parent.AlignOrientation

-- DATA --

local Color = {
	{Color3.fromRGB(255, 90, 90)},
	{Color3.fromRGB(255, 112, 65)},
	{Color3.fromRGB(69, 149, 202)},
	{Color3.fromRGB(255, 99, 187)}
}

local OwnedBlimpBadges = {

}

-- FUNCTION --

function RotateBlimp()

	local BlimpTween = TweenService:Create(AlignOrientation, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		CFrame = AlignOrientation.CFrame * CFrame.Angles(math.rad(-1), math.rad(180), 0)
	})

	BlimpTween:Play()

	return BlimpTween

end

function AwardBlimpBadge(Player)

	if BadgeService:UserHasBadgeAsync(Player.UserId, 2144910738) then

		return

	end

	BadgeService:AwardBadge(Player.UserId, 2144910738)

end

-- MAIN SCRIPT --

script.Parent.Touched:Connect(function(BasePart)

	if BasePart.Parent:FindFirstChild('Humanoid') then
		
		local Player = game.Players:WaitForChild(BasePart.Parent.Name, 5)
		
		if OwnedBlimpBadges[Player.UserId] then
			
			return
			
		end
		
		AwardBlimpBadge(Player)
		
		OwnedBlimpBadges[Player.UserId] = true

	end

end)

script.Parent.Color = table.unpack(Color[math.random(1, #Color)])

AlignOrientation.CFrame = script.Parent.CFrame * CFrame.Angles(math.rad(-1), 0, 0)

wait(23)

RotateBlimp().Completed:Connect(function()

	wait(3)

	RotateBlimp().Completed:Connect(function()

		wait(20)
		
		workspace:SetAttribute('TotalBlimps', workspace:GetAttribute('TotalBlimps') - 1) 

		script.Parent:Destroy()

	end)

end)