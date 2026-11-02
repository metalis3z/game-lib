--credit to leon games studio
--[[
	FreezeRayVFX — fogonazo del cañón de la Freeze Ray (como la marca "Fire" de la
	GearScenes.Freeze Ray.Scene): al activar la Tool emite las partículas del
	Nozzle.Attachment y prende el brillo (EmissiveStrength) del EmissivePart/Ice.
	Script de Tool (Legacy): arranca al entrar la Tool al Backpack. El SONIDO y la
	animación los hace FreezeRayController; el CONGELAMIENTO + bloque de hielo el server.
]]

local TweenService = game:GetService("TweenService")

local Tool = script.Parent
if not (Tool and Tool:IsA("Tool")) then
	return -- en el template (Model en Assets) no hace nada
end

local last = 0

local function glow(part, strength, time)
	if not part then
		return
	end
	local sa = part:FindFirstChildWhichIsA("SurfaceAppearance")
	if sa then
		TweenService:Create(sa, TweenInfo.new(time), { EmissiveStrength = strength }):Play()
	end
end

Tool.Activated:Connect(function()
	if os.clock() - last < 0.4 then
		return
	end
	last = os.clock()

	local nozzle = Tool:FindFirstChild("Nozzle")
	local att = nozzle and nozzle:FindFirstChild("Attachment")
	if att then
		for _, e in att:GetChildren() do
			if e:IsA("ParticleEmitter") then
				e:Emit(e:GetAttribute("EmitCount") or 6)
			end
		end
	end

	glow(Tool:FindFirstChild("EmissivePart"), 4, 0.2)
	glow(Tool:FindFirstChild("Ice"), 4, 0.2)
	task.delay(0.4, function()
		glow(Tool:FindFirstChild("EmissivePart"), 0, 0.6)
		glow(Tool:FindFirstChild("Ice"), 0, 0.6)
	end)
end)
