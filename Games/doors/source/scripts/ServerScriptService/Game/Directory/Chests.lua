local module = {}

-- Created and Fixed by BUILDG Studios

function module:ChestBasic(v)

	local chest = game.ServerScriptService.Server.Assets.Chests.ChestBox:Clone()
	local Controller = chest:FindFirstChild("AnimationController")
	local Prompt = chest:FindFirstChild("ActivateEventPrompt")
	
	local OpenAnimation = Instance.new("Animation")
	OpenAnimation.AnimationId = "rbxassetid://16425461333"
	
	local CloseAnimation = Instance.new("Animation")
	CloseAnimation.AnimationId = "rbxassetid://16425458216"

	local IdleAnimation = Instance.new("Animation")
	IdleAnimation.AnimationId = "rbxassetid://16425465218"

	local status = {
		opened = false
	}

	Prompt.Triggered:Connect(function()
		
		local Open = Controller:LoadAnimation(OpenAnimation)
		local Idle = Controller:LoadAnimation(IdleAnimation)
		local Close = Controller:LoadAnimation(CloseAnimation)

		Open.Priority = Enum.AnimationPriority.Action2
		Close.Priority = Enum.AnimationPriority.Action2
		Idle.Priority = Enum.AnimationPriority.Action
		
		if status.opened == false then
			status.opened = true

			Prompt.ActionText = "Looted"

			Open:Play()
			Idle:Play()
		else
			status.opened = false

			Close:Play()
			Idle:Stop()
		end
	end)

	chest:PivotTo(v.CFrame)
	chest.Parent = v.Parent
end

return module