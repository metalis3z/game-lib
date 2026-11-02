--credit to prince games studio
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local Gravity = game.SoundService.SFX.Gravity
local t = {
	NewGravity = 20,
	Duration = 15,
	JumpHeightMult = 4,
	Applied = false,
	DefaultGravity = workspace.Gravity
}
local RadialFXController = require(script.Parent.RadialFXController)
local FieldOfViewController = require(script.Parent.FieldOfViewController)
local v1 = TweenInfo.new(7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t2 = {
	Connections = {}
}
local v3 = nil
local v4 = 0

local function GetJumpHeight(p1) --[[ GetJumpHeight | Line: 34 | Upvalues: LocalPlayer (copy) ]]
	if LocalPlayer:GetAttribute("BaseJumpHeight") then
		return LocalPlayer:GetAttribute("BaseJumpHeight")
	end

	LocalPlayer:SetAttribute("BaseJumpHeight", p1.Humanoid.JumpHeight)

	return LocalPlayer:GetAttribute("BaseJumpHeight")
end

local function DisconnectAll() --[[ DisconnectAll | Line: 42 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2.Connections do
		v2:Disconnect()
		t2.Connections[v1] = nil
	end
end

local function ReconnectAll() --[[ ReconnectAll | Line: 50 | Upvalues: CollectionService (copy), t2 (copy) ]]
	for v1, v2 in CollectionService:GetTagged("MoonBloom") do
		t2:RegisterPart(v2)
	end
end

function t2.RegisterPart(p1, p2) --[[ RegisterPart | Line: 56 | Upvalues: t2 (copy), t (copy), LocalPlayer (copy), Networking (copy), RadialFXController (copy), TweenService (copy), v1 (copy), Gravity (copy), v4 (ref), FieldOfViewController (copy), v3 (ref), v2 (copy), CollectionService (copy) ]]
	if not t2.Connections[p2] then
		t2.Connections[p2] = p2.Touched:Connect(function(p1) --[[ Line: 60 | Upvalues: t (ref), LocalPlayer (ref), Networking (ref), t2 (ref), RadialFXController (ref), TweenService (ref), v1 (ref), Gravity (ref), v4 (ref), FieldOfViewController (ref), v3 (ref), v2 (ref), CollectionService (ref) ]]
			if t.Applied then
				return
			end

			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			if not p1:IsDescendantOf(Character) then
				return
			end

			t.Applied = true
			Networking.MoonBloom.GravityTouched:Fire()

			for v12, v22 in t2.Connections do
				v22:Disconnect()
				t2.Connections[v12] = nil
			end

			if not LocalPlayer:GetAttribute("BaseJumpHeight") then
				LocalPlayer:SetAttribute("BaseJumpHeight", Character.Humanoid.JumpHeight)
			end

			local v32 = LocalPlayer:GetAttribute("BaseJumpHeight")

			Character.Humanoid.JumpHeight = v32 * t.JumpHeightMult
			workspace.Gravity = t.NewGravity
			RadialFXController:PlayFX("MoonBloom")

			local Highlight = Instance.new("Highlight")

			Highlight.Adornee = Character
			Highlight.Parent = LocalPlayer.PlayerGui
			Highlight.FillColor = Color3.new(0, 0.666667, 1)
			Highlight.OutlineTransparency = 1
			Highlight.FillTransparency = 0.5
			TweenService:Create(Highlight, v1, {
				FillTransparency = 1
			}):Play()
			game.Debris:AddItem(Highlight, v1.Time)
			Gravity.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Gravity.TimePosition = 0
			Gravity.Playing = true
			v4 = FieldOfViewController:GetAdjuster()
			FieldOfViewController:SetAdjuster(v4 + 30, false)

			if not v3 then
				v3 = task.delay(1, function() --[[ Line: 105 | Upvalues: v3 (ref), FieldOfViewController (ref), v4 (ref) ]]
					v3 = nil
					FieldOfViewController:SetAdjuster(v4, false)
				end)
				task.delay(t.Duration, function() --[[ Line: 111 | Upvalues: v3 (ref), FieldOfViewController (ref), v4 (ref), TweenService (ref), v2 (ref), t (ref), Character (copy), v32 (copy), CollectionService (ref), t2 (ref) ]]
					local v1, v22

					if v3 then
						task.cancel(v3)
						v3 = nil
					end

					FieldOfViewController:SetAdjuster(v4, false)
					v1 = TweenService:Create(workspace, v2, {
						Gravity = t.DefaultGravity
					})
					v1:Play()
					game.Debris:AddItem(v1, v2.Time)
					v22 = TweenService:Create(Character.Humanoid, v2, {
						JumpHeight = v32
					})
					v22:Play()
					game.Debris:AddItem(v22, v2.Time)
					task.delay(v2.Time, function() --[[ Line: 126 | Upvalues: t (ref), CollectionService (ref), t2 (ref) ]]
						t.Applied = false

						for v1, v2 in CollectionService:GetTagged("MoonBloom") do
							t2:RegisterPart(v2)
						end
					end)
				end)

				return
			end

			task.cancel(v3)
			v3 = task.delay(1, function() --[[ Line: 105 | Upvalues: v3 (ref), FieldOfViewController (ref), v4 (ref) ]]
				v3 = nil
				FieldOfViewController:SetAdjuster(v4, false)
			end)
			task.delay(t.Duration, function() --[[ Line: 111 | Upvalues: v3 (ref), FieldOfViewController (ref), v4 (ref), TweenService (ref), v2 (ref), t (ref), Character (copy), v32 (copy), CollectionService (ref), t2 (ref) ]]
				local v1, v22

				if v3 then
					task.cancel(v3)
					v3 = nil
				end

				FieldOfViewController:SetAdjuster(v4, false)
				v1 = TweenService:Create(workspace, v2, {
					Gravity = t.DefaultGravity
				})
				v1:Play()
				game.Debris:AddItem(v1, v2.Time)
				v22 = TweenService:Create(Character.Humanoid, v2, {
					JumpHeight = v32
				})
				v22:Play()
				game.Debris:AddItem(v22, v2.Time)
				task.delay(v2.Time, function() --[[ Line: 126 | Upvalues: t (ref), CollectionService (ref), t2 (ref) ]]
					t.Applied = false

					for v1, v2 in CollectionService:GetTagged("MoonBloom") do
						t2:RegisterPart(v2)
					end
				end)
			end)
		end)
	end
end
function t2.UnregisterPart(p1, p2) --[[ UnregisterPart | Line: 135 | Upvalues: t2 (copy) ]]
	if not t2.Connections[p2] then
		return
	end

	t2.Connections[p2]:Disconnect()
	t2.Connections[p2] = nil
end
function t2.Start(p1) --[[ Start | Line: 142 | Upvalues: CollectionService (copy), t (copy) ]]
	for v1, v2 in CollectionService:GetTagged("MoonBloom") do
		p1:RegisterPart(v2)
	end

	CollectionService:GetInstanceAddedSignal("MoonBloom"):Connect(function(p12) --[[ Line: 148 | Upvalues: t (ref), p1 (copy) ]]
		if t.Applied then
			return
		end

		p1:RegisterPart(p12)
	end)
	CollectionService:GetInstanceRemovedSignal("MoonBloom"):Connect(function(p12) --[[ Line: 155 | Upvalues: p1 (copy) ]]
		p1:UnregisterPart(p12)
	end)
end

return t2