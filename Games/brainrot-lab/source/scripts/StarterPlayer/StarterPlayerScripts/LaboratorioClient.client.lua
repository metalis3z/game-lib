--!strict
-- LOCATION: StarterPlayer/StarterPlayerScripts/LaboratorioClient
-- Animacao do brainrot no BrainrotSlot: rotaciona suavemente e flutua acima do slot

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local labFolder = Workspace:WaitForChild("Laboratorio")

-- Configuracoes de animacao
local ROTATION_SPEED = 0.5 -- rotacoes por segundo (suave)
local FLOAT_AMPLITUDE = 0.5 -- altura da flutuacao em studs
local FLOAT_SPEED = 2 -- velocidade da flutuacao
local MUTATION_ROTATION_SPEED = 15 -- rotacoes por segundo durante mutacao (muito rapido)

-- Armazenar dados de animacao por maquina
local animatedBrainrots: {[Instance]: {baseCFrame: CFrame, model: Instance}} = {}

-- Encontrar o Model interno dentro do VisualBrainrot (pode ser Folder ou Model)
local function getVisualModel(visual: Instance): Instance?
	if visual:IsA("Model") then return visual end
	if visual:IsA("Folder") then
		return visual:FindFirstChildOfClass("Model")
	end
	return nil
end

-- Encontrar todos os VisualBrainrot nas maquinas e animar
local function scanForVisualBrainrots()
	for _, labModel in ipairs(labFolder:GetChildren()) do
		if labModel:IsA("Model") and labModel.Name:match("^Laboratorio%d+$") then
			local visual = labModel:FindFirstChild("VisualBrainrot")
			if visual and not animatedBrainrots[visual] then
				local innerModel = getVisualModel(visual)
				if innerModel then
					local cf = innerModel:GetPivot()
					animatedBrainrots[visual] = {
						baseCFrame = cf,
						model = innerModel,
					}
				end
			end
		end
	end
end

-- Limpar brainrots que foram removidos
local function cleanRemovedBrainrots()
	for visual, _ in pairs(animatedBrainrots) do
		if not visual.Parent then
			animatedBrainrots[visual] = nil
		end
	end
end

-- Animar todos os brainrots ativos
RunService.Heartbeat:Connect(function(dt)
	scanForVisualBrainrots()
	cleanRemovedBrainrots()

	local timeNow = os.clock()
	for visual, data in pairs(animatedBrainrots) do
		if visual.Parent then
			local isMutating = visual:GetAttribute("IsMutating") == true
			local speed = isMutating and MUTATION_ROTATION_SPEED or ROTATION_SPEED

			-- Rotacao no eixo Y (rapida durante mutacao, suave normalmente)
			local rotation = CFrame.Angles(0, timeNow * speed * math.pi * 2, 0)

			-- Flutuacao suave (sobe e desce) - so quando nao esta mutando
			local floatOffset = 0
			if not isMutating then
				floatOffset = math.sin(timeNow * FLOAT_SPEED) * FLOAT_AMPLITUDE
			end

			local finalCFrame = CFrame.new(data.baseCFrame.Position + Vector3.new(0, floatOffset, 0)) * rotation
			local modelToPivot = data.model :: any
			modelToPivot:PivotTo(finalCFrame)
		end
	end
end)

-- Observar novos VisualBrainrots sendo adicionados
labFolder.DescendantAdded:Connect(function(descendant)
	if descendant.Name == "VisualBrainrot" then
		local innerModel = getVisualModel(descendant)
		if innerModel then
			local cf = innerModel:GetPivot()
			animatedBrainrots[descendant] = {
				baseCFrame = cf,
				model = innerModel,
			}
		end
	end
end)

print("[LaboratorioClient] Sistema de animacao do Laboratorio iniciado")