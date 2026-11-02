-- SERVICES --

local Players = game:GetService('Players')
local Lighting = game:GetService('Lighting')
local StarterGui = game:GetService('StarterGui')
local TweenService = game:GetService('TweenService')
local TeleportService = game:GetService('TeleportService')

-- INSTANCES --

local LabelsFrame = script.Parent:WaitForChild('LabelsFrame', 5)
local EffectFrame = script.Parent:WaitForChild('EffectFrame', 5)

-- EVENTS --

local MainEvent = game:GetService('ReplicatedStorage'):WaitForChild('ATLAS_CORE_EVENTS'):WaitForChild('GetName'):InvokeServer()

-- MAIN --

MainEvent.OnClientEvent:Connect(function()
	
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

	EffectFrame:FindFirstChild('TopFrame'):TweenPosition(UDim2.new(0, 0,0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.75)
	EffectFrame:FindFirstChild('BottomFrame'):TweenPosition(UDim2.new(0, 0,0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.75)

	wait(0.90)

	TweenService:Create(LabelsFrame:FindFirstChild('CoreInfo'), TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
		TextTransparency = 0.31
	}):Play()

	TweenService:Create(LabelsFrame:FindFirstChild('Icon'), TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
		ImageTransparency = 0
	}):Play()

	wait(0.75)

	TweenService:Create(LabelsFrame:FindFirstChild('Title'), TweenInfo.new(0.70, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0.384, 0,0.027, 0),
		TextTransparency = 0.31
	}):Play()

	wait(1)

	TweenService:Create(LabelsFrame:FindFirstChild('AnimatingLabel'), TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
		TextTransparency = 0.57
	}):Play()

	spawn(function()

		local Points = ''
		local AnimatingLabel = LabelsFrame:FindFirstChild('AnimatingLabel')

		while wait(0.4) do

			Points = Points .. '.'

			if Points == '...' then

				Points = ''
				AnimatingLabel.Text = 'you are being teleported'

			end

			AnimatingLabel.Text = AnimatingLabel.Text .. Points

		end

	end)
	
end)
