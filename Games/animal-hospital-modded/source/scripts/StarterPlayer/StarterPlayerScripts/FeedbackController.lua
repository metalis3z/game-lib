--[[
	FeedbackController (cliente)
	Abre el dialogo de feedback NATIVO de Roblox (SocialService:PromptFeedbackSubmissionAsync)
	cuando el jugador activa cualquier ProximityPrompt llamado "FeedbackPrompt" dentro
	de Workspace.Feedbacks (p.ej. Feedbacks.FeedBack.PromptPart.PromptAttachment.FeedbackPrompt).

	El prompt ya muestra su UI nativo solo (Enabled = true). Aqui solo conectamos su
	.Triggered a la llamada nativa, que debe correr en el cliente.
]]

local SocialService = game:GetService("SocialService")
local Workspace = game:GetService("Workspace")

local FeedbackController = {}

local bound = setmetatable({}, { __mode = "k" }) -- prompts ya conectados

local function openNativeFeedback()
	pcall(function()
		SocialService:PromptFeedbackSubmissionAsync()
	end)
end

local function bindPrompt(prompt)
	if not (prompt:IsA("ProximityPrompt") and prompt.Name == "FeedbackPrompt") then
		return
	end
	if bound[prompt] then
		return
	end
	bound[prompt] = true
	prompt.Triggered:Connect(openNativeFeedback)
end

local function bindModel(inst)
	for _, d in ipairs(inst:GetDescendants()) do
		bindPrompt(d)
	end
	inst.DescendantAdded:Connect(bindPrompt)
end

function FeedbackController.Init()
	task.spawn(function()
		local feedbacks = Workspace:WaitForChild("Feedbacks", 10)
		if not feedbacks then
			return
		end
		bindModel(feedbacks)
	end)
end

return FeedbackController
