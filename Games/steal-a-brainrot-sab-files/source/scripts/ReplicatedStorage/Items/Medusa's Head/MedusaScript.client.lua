
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ToolsExtras = ReplicatedStorage:WaitForChild("Models").ToolsExtras
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Debounce = require(Packages.Debounce)

local Tool = script.Parent
local PlayerData = Tool.Parent.Parent

local idleAnim, attackAnim
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
local ringInstance
local heartbeatConnection

local function animateRing(isEquipped)
	if ringInstance then
		local numberValue = Instance.new("NumberValue", script)
		numberValue.Value = isEquipped and 0.0001 or 0.6

		numberValue.Changed:Connect(function(value)
			if ringInstance then
				ringInstance:ScaleTo(value)
			end
		end)

		local tween = TweenService:Create(numberValue, tweenInfo, {Value = isEquipped and 0.6 or 0.0001})
		tween:Play()
		tween.Completed:Connect(function()
			numberValue:Destroy()
		end)
		tween.Completed:Wait()
	end
end

local function loadAnimations()
	if idleAnim and attackAnim then return end

	local humanoid = PlayerData.Character:WaitForChild("Humanoid")
	local animator = humanoid:WaitForChild("Animator")

	idleAnim = animator:LoadAnimation(script.Idle)
	idleAnim.Priority = Enum.AnimationPriority.Action
	idleAnim.Looped = true

	attackAnim = animator:LoadAnimation(script.Attack)
	attackAnim.Priority = Enum.AnimationPriority.Action4
	attackAnim.Looped = false
end

Tool.Activated:Connect(function()
	local success, duration = pcall(function()
		return Net:Invoke("UseItem")
	end)

	if success and type(duration) == "number" then
		if attackAnim then
			attackAnim:Play()
		end
		Debounce(("ItemUse/MedusaAttackAnimation/%*"):format(PlayerData.Name), duration - workspace:GetServerTimeNow())
	end
end)

Tool.Equipped:Connect(function()
	if ringInstance then
		ringInstance:Destroy()
	end
	if heartbeatConnection then
		heartbeatConnection:Disconnect()
	end

	loadAnimations()
	idleAnim:Play()

	ringInstance = ToolsExtras.Ring:Clone()
	ringInstance.Name = ("%*.Ring"):format(PlayerData.Name)
	ringInstance:PivotTo(PlayerData.Character:GetPivot())
	ringInstance.Parent = workspace
	animateRing(true)

	local humanoid = PlayerData.Character and PlayerData.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Once(function()
			local ring = workspace:FindFirstChild(("%*.Ring"):format(PlayerData.Name))
			if ring then ring:Destroy() end
			if heartbeatConnection then
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
			end
		end)
	end

	heartbeatConnection = RunService.Heartbeat:Connect(function()
		local hrp = PlayerData.Character and PlayerData.Character:FindFirstChild("HumanoidRootPart")
		if hrp and ringInstance then
			ringInstance:PivotTo(hrp:GetPivot() * CFrame.new(0, -3, 0))
		end
	end)
end)

Tool.Unequipped:Connect(function()
	if heartbeatConnection then
		heartbeatConnection:Disconnect()
		heartbeatConnection = nil
	end

	animateRing(false)

	if ringInstance then
		ringInstance:Destroy()
		ringInstance = nil
	end

	if idleAnim and idleAnim.IsPlaying then
		idleAnim:Stop()
	end
	if attackAnim and attackAnim.IsPlaying then
		attackAnim:Stop()
	end
end)
