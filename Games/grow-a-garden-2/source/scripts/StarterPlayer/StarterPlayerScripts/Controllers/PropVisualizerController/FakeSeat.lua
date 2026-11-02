--credit to prince games studio
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer

return function(p1) --[[ Line: 18 | Upvalues: CollectionService (copy), LocalPlayer (copy), Networking (copy), Players (copy) ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and CollectionService:HasTag(v2, "FakeSeat") then
			table.insert(t, v2)
		end
	end

	if #t == 0 then
		return
	end

	local v3 = p1:GetAttribute("UserId")
	local v4 = p1:GetAttribute("PropId")
	local v5 = false
	local t2 = {}
	local t3 = {}
	local v6 = nil
	local t4 = {}

	local function ClearWeld(p1) --[[ ClearWeld | Line: 40 | Upvalues: t2 (copy) ]]
		local v1 = t2[p1]

		if not v1 then
			return
		end

		v1:Destroy()
		t2[p1] = nil
	end

	local function CreateWeld(p1, p2) --[[ CreateWeld | Line: 48 | Upvalues: t2 (copy), t (copy) ]]
		local v1 = t2[p1]

		if v1 then
			v1:Destroy()
			t2[p1] = nil
		end

		local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
			local v2 = t[p1]
			local v3 = v2:GetAttribute("SeatHeight") or 2
			local SeatWeld = Instance.new("Weld")

			SeatWeld.Name = "SeatWeld"
			SeatWeld.Part0 = v2
			SeatWeld.Part1 = HumanoidRootPart
			SeatWeld.C0 = CFrame.new(0, v3, 0)
			SeatWeld.Parent = v2
			t2[p1] = SeatWeld
		end
	end

	local function ConnectLocalUnsit() --[[ ConnectLocalUnsit | Line: 65 | Upvalues: v6 (ref), LocalPlayer (ref), t (copy), t3 (copy), t2 (copy), t4 (copy), Networking (ref), v3 (copy), v4 (copy) ]]
		if v6 then
			v6:Disconnect()
			v6 = nil
		end

		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local v1 = Character:FindFirstChildWhichIsA("Humanoid")

		if v1 then
			v6 = v1.StateChanged:Connect(function(p1, p2) --[[ Line: 76 | Upvalues: t (ref), t3 (ref), LocalPlayer (ref), t2 (ref), t4 (ref), Networking (ref), v3 (ref), v4 (ref) ]]
				if p2 ~= Enum.HumanoidStateType.Jumping and p2 ~= Enum.HumanoidStateType.GettingUp then
					return
				end

				for i = 1, #t do
					if t3[i] == LocalPlayer.UserId then
						local v1 = t2[i]

						if v1 then
							v1:Destroy()
							t2[i] = nil
						end

						t3[i] = nil
						t4[i] = os.clock()
						Networking.FakeSeat.Unsit:Fire(v3, v4, i)

						return
					end
				end
			end)
		end
	end

	local v7 = Networking.FakeSeat.SeatChanged.OnClientEvent:Connect(function(p1, p2, p3, p4) --[[ Line: 93 | Upvalues: v3 (copy), v4 (copy), t3 (copy), LocalPlayer (ref), t2 (copy), Networking (ref), Players (ref), CreateWeld (copy) ]]
		if p1 ~= v3 or p2 ~= v4 then
			return
		end

		if p4 == 0 then
			if t3[p3] == LocalPlayer.UserId then
				return
			end

			local v1 = t2[p3]

			if v1 then
				v1:Destroy()
				t2[p3] = nil
			end

			t3[p3] = nil
		elseif p4 == LocalPlayer.UserId then
			if t3[p3] == LocalPlayer.UserId then
				return
			end

			Networking.FakeSeat.Unsit:Fire(v3, v4, p3)
		else
			t3[p3] = p4

			local v2 = Players:GetPlayerByUserId(p4)

			if not (v2 and v2.Character) then
				return
			end

			local v32 = v2.Character:FindFirstChildWhichIsA("Humanoid")

			if v32 then
				v32.Sit = true
			end

			CreateWeld(p3, v2.Character)
		end
	end)

	for i = 1, #t do
		t[i].Touched:Connect(function(p12) --[[ Line: 124 | Upvalues: v5 (ref), p1 (copy), t3 (copy), i (copy), t4 (copy), LocalPlayer (ref), CreateWeld (copy), ConnectLocalUnsit (copy), Networking (ref), v3 (copy), v4 (copy) ]]
			if v5 then
				return
			end

			if p1:GetAttribute("IsBeingMoved") then
				return
			end

			if t3[i] then
				return
			end

			local v1 = t4[i]

			if v1 and os.clock() - v1 < 0.5 then
				return
			end

			local v2 = p12:FindFirstAncestorWhichIsA("Model")

			if v2 ~= LocalPlayer.Character then
				return
			end

			local v32 = v2:FindFirstChildWhichIsA("Humanoid")

			if not v32 then
				return
			end

			if not v32.Sit then
				v32.Sit = true
				CreateWeld(i, v2)
				t3[i] = LocalPlayer.UserId
				ConnectLocalUnsit()
				Networking.FakeSeat.Sit:Fire(v3, v4, i)
			end
		end)
	end

	ConnectLocalUnsit()
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 149 | Upvalues: ConnectLocalUnsit (copy) ]]
		task.wait()
		ConnectLocalUnsit()
	end)
	p1.Destroying:Connect(function() --[[ Line: 154 | Upvalues: v5 (ref), t (copy), t3 (copy), LocalPlayer (ref), t2 (copy), v7 (copy), v6 (ref) ]]
		v5 = true

		for i = 1, #t do
			if t3[i] == LocalPlayer.UserId then
				local v1 = t2[i]

				if v1 then
					v1:Destroy()
					t2[i] = nil
				end

				t3[i] = nil

				local Character = LocalPlayer.Character

				if Character then
					local v2 = Character:FindFirstChildWhichIsA("Humanoid")

					if v2 then
						v2.Sit = false
					end
				end

				continue
			end

			if t2[i] then
				local v3 = t2[i]

				if v3 then
					v3:Destroy()
					t2[i] = nil
				end

				t3[i] = nil
			end
		end

		v7:Disconnect()

		if not v6 then
			return
		end

		v6:Disconnect()
	end)
	Networking.FakeSeat.RequestState:Fire(v3, v4)
end