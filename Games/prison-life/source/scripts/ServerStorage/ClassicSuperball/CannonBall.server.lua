local Ball = script.Parent
local damage = 25

local r = game:GetService("RunService")
local debris = game:GetService("Debris")

local last_sound_time = r.Stepped:Wait()

function IsTeamMate(Player1, Player2)
	return (Player1 and Player2 and not Player1.Neutral and not Player2.Neutral and Player1.TeamColor == Player2.TeamColor)
end

function onTouched(hit)
	if not hit or not hit.Parent then return end 
	local now = r.Stepped:Wait()
	if (now - last_sound_time > .1) then
		Ball.Boing:Play()
		last_sound_time = now
	else
		return
	end

	local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
	local tag = Ball:FindFirstChild("creator")
	if tag and humanoid then
		if not IsTeamMate(tag.Value,game.Players:GetPlayerFromCharacter(humanoid.Parent)) then
			tagHumanoid(humanoid)		
			humanoid:TakeDamage(damage)	
		if connection then connection:Disconnect() end
		end
	else
		damage = damage / 2
		if damage < 2 then
			if connection then connection:Disconnect() end
		end
	end
end

function tagHumanoid(humanoid)
	-- todo: make tag expire
	local tag = Ball:FindFirstChild("creator")
	if tag then
		-- kill all other tags
		while(humanoid:FindFirstChild("creator")) do
			humanoid:FindFirstChild("creator").Parent:Destroy()
		end

		local new_tag = tag:Clone()
		new_tag.Parent = humanoid
		debris:AddItem(new_tag, 1)
	end
end


connection = Ball.Touched:Connect(onTouched)

t, s = r.Stepped:Wait()
d = t + 5.0 - s
while t < d do
	t = r.Stepped:Wait()
end

Ball:Destroy()