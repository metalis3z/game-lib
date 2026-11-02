local sgui = game:GetService("StarterGui")

wait(1)

sgui:SetCore("ResetButtonCallback" ,false)
workspace.CurrentCamera.CFrame += Vector3.new(0, 3, 0)
