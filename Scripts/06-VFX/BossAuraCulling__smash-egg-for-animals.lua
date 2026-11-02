-- Reference copy for study. Game: smash-egg-for-animals
-- Original: StarterPlayer/StarterPlayerScripts/VoidVFXClient.client.lua  (LocalScript, 126 lines)
-- What it does: Attaches an aura template to every boss model (WeldConstraints, FollowPart attributes), switches emitter rates between idle/run, toggles trails while moving, pulses glowing parts, flickers beams, and disables everything beyond a cull distance.

-- New script created by Ropilot
-- Replace this with your code
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local template = ReplicatedStorage:WaitForChild("VFX"):WaitForChild("VoidColossusAura")
local states = {}
local pending = {}

local function bind(model)
	if pending[model] or states[model] or not model:IsA("Model") or model.Name ~= "Void" then
		return
	end
	pending[model] = true
	task.spawn(function()
		local root = model:WaitForChild("HumanoidRootPart", 10)
		local humanoid = model:WaitForChild("Humanoid", 10)
		if not root or not humanoid or not model:IsDescendantOf(workspace) then
			pending[model] = nil
			return
		end

		local preview = model:FindFirstChild("VoidAuraPreview")
		if preview then
			preview:Destroy()
		end
		local effect = template:Clone()
		effect.Name = "VoidAura"
		for _, part in effect:GetChildren() do
			if part:IsA("BasePart") then
				local target = model:FindFirstChild(part:GetAttribute("FollowPart") or "HumanoidRootPart")
				if not target then
					effect:Destroy()
					pending[model] = nil
					return
				end
				part.CFrame = target.CFrame * CFrame.new(0, part:GetAttribute("FollowOffsetY") or 0, 0)
				part.Anchored = false
				part.Massless = true
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = target
				weld.Part1 = part
				weld.Parent = part
			end
		end

		local state = { Root = root, Humanoid = humanoid, Effect = effect, Emitters = {}, Beams = {}, Trails = {}, Lights = {}, Pulse = {} }
		-- détails lumineux (fissures, cœur, yeux, cristaux) : ils « respirent », une onde de lumière parcourt le corps
		for _, part in model:GetDescendants() do
			if part:IsA("BasePart") and part:GetAttribute("VoidPulse") then
				local local_ = root.CFrame:PointToObjectSpace(part.Position)
				table.insert(state.Pulse, {Part = part, Base = part.Color, Phase = -local_.Z * 0.9 + local_.Y * 0.4})
			end
		end
		for _, instance in effect:GetDescendants() do
			if instance:IsA("ParticleEmitter") then
				table.insert(state.Emitters, instance)
			elseif instance:IsA("Beam") then
				table.insert(state.Beams, instance)
			elseif instance:IsA("Trail") then
				table.insert(state.Trails, instance)
			elseif instance:IsA("PointLight") then
				table.insert(state.Lights, instance)
			end
		end
		effect.Parent = model
		states[model] = state
		pending[model] = nil
	end)
end

workspace.ChildAdded:Connect(bind)
for _, model in workspace:GetChildren() do
	bind(model)
end

local elapsed = 0
RunService.Heartbeat:Connect(function(dt)
	elapsed += dt
	if elapsed < 0.12 then
		return
	end
	elapsed = 0
	local character = player.Character
	local playerRoot = character and character:FindFirstChild("HumanoidRootPart")
	local now = os.clock()
	for model, state in states do
		if not model:IsDescendantOf(workspace) or not state.Root.Parent or not state.Humanoid.Parent then
			state.Effect:Destroy()
			states[model] = nil
			continue
		end
		local active = state.Humanoid.Health > 0 and playerRoot ~= nil
		if active then
			active = (playerRoot.Position - state.Root.Position).Magnitude < (template:GetAttribute("CullDistance") or 180)
		end
		local velocity = state.Root.AssemblyLinearVelocity
		local moving = Vector3.new(velocity.X, 0, velocity.Z).Magnitude > 1.5
		if state.Active ~= active or state.Moving ~= moving then
			for _, emitter in state.Emitters do
				emitter.Enabled = active
				emitter.Rate = emitter:GetAttribute(moving and "RunRate" or "IdleRate") or emitter.Rate
			end
			for _, trail in state.Trails do
				trail.Enabled = active and moving
			end
			for _, light in state.Lights do
				light.Enabled = active
			end
			state.Active, state.Moving = active, moving
		end
		if active then
			local white = Color3.fromRGB(235, 205, 255)
			for _, entry in state.Pulse do
				local k = (math.sin(now * 2.4 + entry.Phase) + 1) / 2
				entry.Part.Color = entry.Base:Lerp(white, k * k * 0.42)
			end
		end
		for _, beam in state.Beams do
			local index = (beam.Name:find("Right") and 2 or 0) + (tonumber(beam.Name:match("Arc(%d)")) or 0)
			beam.Enabled = active and math.floor(now * 8 + index) % 7 < 3
		end
	end
end)
