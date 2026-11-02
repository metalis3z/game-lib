-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v2.Events.Upgrade
local v_u_4 = v1.LocalPlayer
local v_u_5 = require(v2.Modules.DataController)
function LavaFunction(p6)
	-- upvalues: (copy) v_u_4
	p6.Touched:Connect(function(p7)
		-- upvalues: (ref) v_u_4
		local v8 = v_u_4.Character
		if p7.Parent and (v8 and p7.Parent == v8) then
			v8:PivotTo(CFrame.new(156.999, 4.762, 39.935) * CFrame.fromOrientation(0, -1.5707963267948966, 0))
		end
	end)
end
local v_u_9 = false
for _, v10 in workspace:WaitForChild("GameFolder"):WaitForChild("ObbyLavas"):GetChildren() do
	LavaFunction(v10)
end
workspace:WaitForChild("GameFolder"):WaitForChild("ObbyLavas").ChildAdded:Connect(LavaFunction)
script.Parent:WaitForChild("Humanoid").Changed:Connect(function()
	-- upvalues: (ref) v_u_9, (copy) v_u_5, (copy) v_u_4
	if v_u_9 then
		local v11 = v_u_5:GetValueFromPathAsync("Upgrades/Speed")
		local v12 = v_u_5:GetValueFromPathAsync("Upgrades/Jump")
		script.Parent.Humanoid.WalkSpeed = 16 + (v_u_9 and 0 or v11 * (v_u_4:GetAttribute("SlowMode") and 0 or 1))
		local v13 = script.Parent.Humanoid
		local v14 = 30
		local v15
		if v_u_9 then
			v15 = 20
		else
			v_u_4:GetAttribute("SlowMode")
			local v16 = 1
			v15 = v12 * v16
		end
		v13.JumpPower = v14 + v15
	end
end)
workspace:WaitForChild("GameFolder"):WaitForChild("SlowSpeed").Touched:Connect(function(p17)
	-- upvalues: (copy) v_u_4, (ref) v_u_9
	local v18 = v_u_4.Character
	local v19
	if v18 then
		v19 = v18:FindFirstChild("Humanoid")
	else
		v19 = v18
	end
	if p17.Parent and (v18 and p17.Parent == v18) then
		v_u_9 = true
		v19.WalkSpeed = 16
		v19.JumpPower = 50
	end
end)
workspace:WaitForChild("GameFolder"):WaitForChild("SlowSpeed").TouchEnded:Connect(function(p20)
	-- upvalues: (copy) v_u_4, (ref) v_u_9, (copy) v_u_5
	local v21 = v_u_4.Character
	local v22
	if v21 then
		v22 = v21:FindFirstChild("Humanoid")
	else
		v22 = v21
	end
	if p20.Parent and (v21 and p20.Parent == v21) then
		v_u_9 = false
		local v23 = v_u_5:GetValueFromPathAsync("Upgrades/Speed")
		local v24 = v_u_5:GetValueFromPathAsync("Upgrades/Jump")
		v22.WalkSpeed = 16 + v23 * (v_u_4:GetAttribute("SlowMode") and 0 or 1)
		local v25 = 30
		v_u_4:GetAttribute("SlowMode")
		local v26 = 1
		v22.JumpPower = v25 + v24 * v26
	end
end)
function PartAdded(p27)
	-- upvalues: (copy) v_u_3
	if p27:IsA("BodyForce") or (p27:IsA("BodyGyro") or (p27:IsA("BodyAngularVelocity") or p27:IsA("BodyPosition"))) then
		if not p27:IsA("BodyForce") or p27.Name ~= "Gravity" then
			local v28 = not (p27:IsA("BodyForce") and p27.Force) and (not ((p27:IsA("BodyGyro") or p27:IsA("BodyAngularVelocity")) and p27.MaxTorque) and p27:IsA("BodyPosition"))
			if v28 then
				v28 = p27.MaxForce
			end
			v_u_3:InvokeServer("bbb", p27.Name, p27.ClassName, p27:GetFullName(), v28)
		end
	else
		return
	end
end
for _, v29 in script.Parent:GetDescendants() do
	PartAdded(v29)
end
script.Parent.DescendantAdded:Connect(PartAdded)
