script.Parent.Interact.OnServerEvent:Connect(function()
	if script.Parent.InUse.Value == true then return end
	script.Parent.Parent.Vault.Spinner.Center.Spin:Play()
	script.Parent.InUse.Value = true
	script.Parent.Parent.ButtonOn.Transparency = 1
	script.Parent.Parent.ButtonOff.Transparency = 0
	for i=1,90 do
		script.Parent.Parent.Vault.Spinner:SetPrimaryPartCFrame(script.Parent.Parent.Vault.Spinner.Center.CFrame * CFrame.Angles(math.rad(2),0,0))
		game:GetService("RunService").Heartbeat:Wait()
	end
	wait(1)
	script.Parent.Parent.Vault.Spinner.Center.Air:Play()
	for i=1,930 do
		script.Parent.Parent.Vault:SetPrimaryPartCFrame(script.Parent.Parent.Vault.Hinge.CFrame * CFrame.Angles(math.rad(0.1),0,0))
		game:GetService("RunService").Heartbeat:Wait()
	end
end)