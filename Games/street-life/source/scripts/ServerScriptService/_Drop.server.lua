local cant = {'Fist', 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool', 'Box'}

prefix = "/"
game.Players.PlayerAdded:connect(function(p)
	p.Chatted:connect(function(m)
		m = m:lower()
		if m == prefix.."drop" then
			if not p.Character:FindFirstChildWhichIsA("Tool") then return end
			if p.Character:FindFirstChild('Humanoid') and p.Character:FindFirstChild('Humanoid').Health == 0 then return end
			local Tool = p.Character:FindFirstChildWhichIsA("Tool")
			if not table.find(cant, Tool.Name) and not Tool:FindFirstChild('POLICE') then
				local a = Instance.new("Animation", p.Character)
				a.AnimationId = "rbxassetid://16210207065"
				local h = p.Character:FindFirstChild("Humanoid")
				local t = h:LoadAnimation(a)
				t.Priority = Enum.AnimationPriority.Action4
				t:Play()
				wait(1)
				local Handle = Tool:FindFirstChild('Handle')		
				Tool.Parent = workspace
				Handle.CFrame = Handle.CFrame + p.Character:FindFirstChild('HumanoidRootPart').CFrame.LookVector * 5
				wait(60)
				if Tool and Tool.Parent == workspace then Tool:Destroy() end				
			end	
		end
	end)
end)