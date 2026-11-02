prefix = "/"
game.Players.PlayerAdded:connect(function(p)
p.Chatted:connect(function(m)
m = m:lower()
if m == prefix.."drop" then --the command
local a = Instance.new("Animation",p.Character)
a.AnimationId = "rbxassetid://9837140133"   --put another animation
local h = p.Character:FindFirstChild("Humanoid")
local t = h:LoadAnimation(a)
t:Play()
local Tool = p.Character:FindFirstChildWhichIsA("Tool")
			wait(1)
			if Tool.CanBeDropped == true and not Tool:FindFirstChild("Rank") then
				Tool.Parent = workspace
			end	
end
end)
end)