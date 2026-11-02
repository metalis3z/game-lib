script:WaitForChild("Enabled")
script.Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,script.Enabled.Value)
wait(1)
script:Destroy()