local module = {}

local Drawers = require(game:FindFirstChild("ServerScriptService"):WaitForChild("Game"):WaitForChild("Directory"):FindFirstChild("Drawers"))
local Items = require(game:FindFirstChild("ServerScriptService"):WaitForChild("Game"):WaitForChild("Controls"):FindFirstChild("Items"))

function module:New(v)
	local RolltopContainer = v.RolltopContainer
	
	local animloader = RolltopContainer.AnimationController
	local Close = animloader:LoadAnimation(RolltopContainer.Animations.close)
	local Open = animloader:LoadAnimation(RolltopContainer.Animations.open)
	local Hold = animloader:LoadAnimation(RolltopContainer.Animations.openidle)
	
	local Rndm = math.random(1, 2)
	
	Close.Priority = Enum.AnimationPriority.Action2
	Open.Priority = Enum.AnimationPriority.Action2
	Hold.Priority = Enum.AnimationPriority.Action
	
	Hold.Looped = true
	
	local newprompt = Instance.new("ProximityPrompt")
	
	newprompt.Style = Enum.ProximityPromptStyle.Custom
	newprompt.Name = "ActivateEventPrompt"
	newprompt.ActionText = "Loot"
	newprompt.ObjectText = "Drawer"
	newprompt.Parent = RolltopContainer
	
	local viewed = false
	local opened = false
	
	newprompt.Triggered:Connect(function(player)
		
		newprompt.Enabled = false
		
		task.delay(0.89, function()
			newprompt.Enabled = true
		end)
		
		if viewed == false then
			viewed = true
			if Rndm == 1 then
				local item = game.ServerScriptService.Server.Assets.Items.Handles.LighterHandle:Clone()

				item.Parent = RolltopContainer
				item.PrimaryPart.CFrame = RolltopContainer.Item.CFrame
				item.PrimaryPart.Anchored = true
				
				Items:LighterSwap(item)
			elseif Rndm == 2 then
				local item = game.ServerScriptService.Server.Assets.Items.Handles.VitaminsHandle:Clone()

				item.Parent = RolltopContainer
				item.PrimaryPart.CFrame = RolltopContainer.Item.CFrame
				item.PrimaryPart.Anchored = true
				
				Items:VitaminsAdd(item)
			end
		end
		
		if opened == false then
			opened = true
			Open:Play()
			Hold:Play()
			RolltopContainer.Main.Open:Play()
			task.wait(Open.Length)
		else
			opened = false
			Close:Play()
			Hold:Stop()
			RolltopContainer.Main.Close:Play()
			task.wait(Close.Length)
		end
		
	end)
end

return module
