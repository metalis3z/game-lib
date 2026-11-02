if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait() 
local Humanoid = Character:WaitForChild('Humanoid', true)

local Emotes = {
	['Sturdy'] = 16266030625,
	['Sturdy2'] = 16707427878,
	['Hands'] = 16345840678,
	['Turnup'] = 16707313997,
	['Count'] = 17512913697,
	['Spit'] = 17512919934,
	['Hype'] = 17512927355,
	['Pockets'] = 17512942428,
	['Hoodie'] = 17512950948,
	['Dab'] = 18344104726,
	['Box'] = 18344127131,
	['Sturdy3'] = 18344200814,
	['Griddy'] = 18344159998,
	['TakeTheL'] = 18344170925,
	['Speed'] = 18344178061,
	['Lean'] = 18728534992,
	['Cross'] = 18728559868,
	['Situps'] = 18728573410,
	['Pushups'] = 18728582516
}

local anim = nil
local ID = nil

local AllowedWalk = {16345840678, 17512919934, 17512942428, 16707313997, 17512913697, 17512919934, 17512950948, 18344159998, 18728559868}

Player.CharacterAdded:Connect(function(character)
	Character = character
	Humanoid = Character:WaitForChild("Humanoid")
	anim = nil
	ID = nil
	Humanoid.Running:Connect(function(Speed)
		if Speed >= 5 then
			if anim ~= nil then
				if table.find(AllowedWalk, ID) then
					if Speed >= 10 then
						if Character:FindFirstChild("LocalAnimation") then Character:FindFirstChild("LocalAnimation"):Destroy() end
						anim:Stop()
						anim = nil
						ID = nil
					end
				else
					if Character:FindFirstChild("LocalAnimation") then Character:FindFirstChild("LocalAnimation"):Destroy() end
					anim:Stop()
					anim = nil
					ID = nil
				end
			end
		end
	end)
end)

function playanim(id)
	if Character ~= nil and Humanoid ~= nil and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and not Humanoid.Sit then
		local actualid = id
		local id = "rbxassetid://"..tostring(id)
		local oldanim = Character:FindFirstChild("LocalAnimation")

		if anim~=nil then
			anim:Stop()
			anim = nil
			ID = nil
		end

		if oldanim ~=nil then
			if oldanim.AnimationId==id then
				oldanim:Destroy()
				return
			end
			oldanim:Destroy()
		end

		while Character.Parent ~= game.Workspace do
			Character.AncestryChanged:wait()
		end

		local animation=Instance.new("Animation",Character)
		animation.Name="LocalAnimation"
		animation.AnimationId=id
		anim=Humanoid:LoadAnimation(animation)
		anim:Play()
		ID = tonumber(actualid)
	end
end

for _,v in next, script.Parent:WaitForChild('ScrollingFrame'):GetChildren() do
	if v:IsA('TextButton') then
		if Emotes[v.Text] ~= nil then
			v.MouseButton1Click:Connect(function()
				playanim(Emotes[v.Text])
			end)
		end
	end
end

Humanoid.Running:Connect(function(Speed)
	if Speed >= 5 then
		if anim ~= nil then
			if table.find(AllowedWalk, ID) then
				if Speed >= 10 then
					if Character:FindFirstChild("LocalAnimation") then Character:FindFirstChild("LocalAnimation"):Destroy() end
					anim:Stop()
					anim = nil
					ID = nil
				end
			else
				if Character:FindFirstChild("LocalAnimation") then Character:FindFirstChild("LocalAnimation"):Destroy() end
				anim:Stop()
				anim = nil
				ID = nil
			end
		end
	end
end)

script.Parent.Close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Enabled = false
end)