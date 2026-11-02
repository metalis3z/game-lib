local l__TweenService__1 = game:GetService("TweenService");
local anim = script.Parent.AnimationController
local animplay = anim:LoadAnimation(script.Parent.Animations.Idle)
local animplaylook = anim:LoadAnimation(script.Parent.Animations.IdleLook)
animplay:Play()

function findNearestHumanoidRootPart(pos)
	local list = workspace:children()
	local HumanoidRootPart = nil
	local dist = 20
	local temp = nil
	local human = nil
	local temp2 = nil
	for x = 1, #list do
		temp2 = list[x]
		if temp2:IsA("Model") and temp2 ~= script.Parent then
			temp = temp2:FindFirstChild("HumanoidRootPart")
			human = temp2:FindFirstChild("Humanoid")
			if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
				if (temp.Position - pos).Magnitude < dist then
					HumanoidRootPart = temp
					dist = (temp.Position - pos).Magnitude

				end
			end
		end
	end
	return HumanoidRootPart
end

local visited = Instance.new("BoolValue")
visited.Value = false

local click = Instance.new("BoolValue")
click.Value = true

script.Parent.Chat.Event:Connect(function(Text)
	local chatui = script.Parent.Head.ChatUI
	chatui.Enabled = true
	chatui.ChatFrame.ChatText.Text = Text
	l__TweenService__1:Create(chatui, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Size = UDim2.new(2, 200, 1, 100)
	}):Play();
	l__TweenService__1:Create(chatui.ChatFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Transparency = 0
	}):Play();
	l__TweenService__1:Create(chatui.Tail, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		ImageTransparency = 0
	}):Play();
	l__TweenService__1:Create(chatui.ChatFrame.ChatText, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		TextTransparency = 0
	}):Play();
	wait(7)
	l__TweenService__1:Create(chatui, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Size = UDim2.new(2, 50, 1, 50)
	}):Play();
	l__TweenService__1:Create(chatui.ChatFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Transparency = 1
	}):Play();
	l__TweenService__1:Create(chatui.Tail, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(chatui.ChatFrame.ChatText, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		TextTransparency = 1
	}):Play();
	wait(1)
	chatui.Enabled = false
end)

while wait(1) do
	if visited.Value == false then
		wait(1)
		local target = findNearestHumanoidRootPart(script.Parent:WaitForChild("HumanoidRootPart").Position)
		if target ~= nil then
			if click.Value == true then
				if (target.Position - script.Parent:WaitForChild("HumanoidRootPart").Position).Magnitude < 30 then
					animplaylook:Play()
					click.Value = false
					script.Parent.Chat:Fire("Look bob, a Visitor!")
					visited.Value = true
					wait(9)
					script.Parent.Chat:Fire("Jeff went on a trip to the next floor, ahh, I already miss him.")
					wait(9)
					script.Parent.Chat:Fire("Buy his last items he didn't take with him.")
					wait(9)
					script.Parent.Chat:Fire("Bob misses him too.") --
					wait(9)
					script.Parent.Chat:Fire("Good luck in the next rooms, I know the next ones the rooms are very dark")
					wait(9)
					script.Parent.Chat:Fire("And I will sit and wait for the appearance of my friend")
					wait(9)
					script.Parent.Chat:Fire("HEY! If you see Jeff, tell him to come back.")
				end
			end
		end
	end
end