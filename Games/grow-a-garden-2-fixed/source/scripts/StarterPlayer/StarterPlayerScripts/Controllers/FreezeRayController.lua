--credit to leon games studio
local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local FreezeRay = game.SoundService.SFX.FreezeRay
local LocalPlayer = Players.LocalPlayer

function t.Init(p1) --[[ Init | Line: 11 ]] end
function t.Start(p1) --[[ Start | Line: 14 | Upvalues: LocalPlayer (copy), Networking (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 20 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	Networking.FreezeRay.FreezeFx.OnClientEvent:Connect(function(p12, p2) --[[ Line: 24 | Upvalues: p1 (copy) ]]
		p1:PlayFreezeFx(p12, p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 29 ]]
	local function tryConnect(p12) --[[ tryConnect | Line: 30 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("FreezeRay")) then
			return
		end

		p12.Activated:Connect(function() --[[ Line: 32 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:OnToolActivated(p12)
		end)
	end

	p2.ChildAdded:Connect(tryConnect)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("FreezeRay") then
			v2.Activated:Connect(function() --[[ Line: 32 | Upvalues: p1 (copy), v2 (copy) ]]
				p1:OnToolActivated(v2)
			end)
		end
	end
end

local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://117986819831165"
function t.OnToolActivated(p1, p2) --[[ OnToolActivated | Line: 50 | Upvalues: LocalPlayer (copy), FreezeRay (copy), Networking (copy), Animation (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if p2.Parent ~= Character then
		return
	end

	local v1 = p2:GetAttribute("CooldownEnd")

	if v1 and os.clock() < v1 then
		return
	end

	local v2 = LocalPlayer:GetMouse()

	if not v2 then
		return
	end

	local v3 = p1:GetFilteredMouseTarget(v2, Character)

	if v3 then
		FreezeRay.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		FreezeRay.Playing = true
		FreezeRay.TimePosition = 0
		Networking.FreezeRay.Fire:Fire(v3, p2)

		local v4 = Character.Humanoid.Animator:LoadAnimation(Animation)

		v4:Play()
		game.Debris:AddItem(v4, 1)

		local v5 = p2:GetAttribute("Cooldown") or 10

		p2:SetAttribute("CooldownEnd", os.clock() + v5)
	end
end
function t.GetFilteredMouseTarget(p1, p2, p3) --[[ GetFilteredMouseTarget | Line: 83 ]]
	local v1 = workspace.CurrentCamera:ScreenPointToRay(p2.X, p2.Y)
	local v2 = RaycastParams.new()

	v2.FilterType = Enum.RaycastFilterType.Exclude
	v2.FilterDescendantsInstances = { p3 }

	local Origin = v1.Origin
	local v3 = v1.Direction * 1000

	for i = 1, 10 do
		local v4 = workspace:Raycast(Origin, v3, v2)

		if not v4 then
			break
		end

		if v4.Instance.Transparency < 1 then
			return v4.Position
		end

		local FilterDescendantsInstances = v2.FilterDescendantsInstances

		table.insert(FilterDescendantsInstances, v4.Instance)
		v2.FilterDescendantsInstances = FilterDescendantsInstances

		local v6 = v3.Magnitude - (v4.Position - Origin).Magnitude

		Origin = v4.Position + v1.Direction * 0.01
		v3 = v1.Direction * v6
	end

	return Origin + v3
end
function t.PlayFreezeFx(p1, p2, p3) --[[ PlayFreezeFx | Line: 117 ]] end

local function newIceBlock(p1) --[[ newIceBlock | Line: 122 ]]
	local v1 = script.Highlight:Clone()

	v1.Parent = p1
	v1.Enabled = true
	v1.Adornee = p1
	game.TweenService:Create(v1, TweenInfo.new(0.1), {
		FillTransparency = 1,
		OutlineTransparency = 1
	}):Play()
	game.Debris:AddItem(v1, 0.1)
	task.delay(0.1, function() --[[ Line: 133 | Upvalues: p1 (copy) ]]
		game.TweenService:Create(p1, TweenInfo.new(0.1), {
			Transparency = 0.4
		}):Play()
	end)

	for v2, v3 in p1:GetChildren() do
		if v3:IsA("ParticleEmitter") then
			v3:Emit(v3:GetAttribute("EmitCount") or 0)

			continue
		end

		if v3:IsA("PointLight") then
			game.TweenService:Create(v3, TweenInfo.new(0.1), {
				Brightness = 6
			}):Play()
			task.delay(0.3, function() --[[ Line: 143 | Upvalues: v3 (copy) ]]
				game.TweenService:Create(v3, TweenInfo.new(0.1), {
					Brightness = 1
				}):Play()
			end)
		end
	end
end

for v1, v2 in game.CollectionService:GetTagged("Ice_Block") do
	newIceBlock(v2)
end

game:GetService("CollectionService"):GetInstanceAddedSignal("Ice_Block"):Connect(newIceBlock)

return t