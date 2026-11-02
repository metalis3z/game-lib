-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
({}).Gore = { "rbxassetid://132151829764277", "rbxassetid://85475332013860", "rbxassetid://140443303137571" }
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(v2.Modules.Util)
require(v2.Modules.Sounds)
v1.HeadSquash = {
	["Callback"] = function(p3)
		local v4 = p3:FindFirstChild("Head")
		if v4 then
			for _, v5 in ipairs(p3:GetDescendants()) do
				if (v5:IsA("JointInstance") or v5:IsA("WeldConstraint")) and (v5.Part0 and (v5.Part1 and (v5.Part0 == v4 or v5.Part1 == v4))) then
					local v6 = v5.Part0 == v4 and v5.Part1 or v5.Part0
					v5:Destroy()
					if v6 then
						v6.CollisionGroup = "Items"
						v6.CanCollide = true
						local v7 = math.random(-30, 30)
						local v8 = math.random
						v6.AssemblyLinearVelocity = Vector3.new(v7, 20, v8(-30, 30))
						local v9 = math.random(-10, 10) / 100
						local v10 = math.random(-10, 10) / 100
						local v11 = math.random(-10, 10) / 100
						v6.AssemblyAngularVelocity = Vector3.new(v9, v10, v11)
					end
				elseif v5:IsA("Decal") then
					v5.Transparency = 1
				end
			end
			for _, v12 in ipairs(v4:GetDescendants()) do
				if v12:IsA("Decal") or v12:IsA("Texture") then
					v12.Transparency = 1
				end
			end
			v4.Transparency = 1
		end
	end
}
return v1
