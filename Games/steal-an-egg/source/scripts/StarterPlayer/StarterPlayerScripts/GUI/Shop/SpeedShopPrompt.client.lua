-- Opens the Speed section of the Shop GUI when the world prompt is triggered.
-- The prompt lives in Workspace.__OBJECTS.Persistent.Prompts.SpeedShop so it survives map resets.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local GUI = require(ReplicatedStorage.Library.Client.GUI)
local TabController = require(ReplicatedStorage.Library.Client.TabController)

local PROMPT_PART_NAME = "SpeedShop"

local function resolvePromptsFolder()
	local objects = Workspace:FindFirstChild("__OBJECTS")
	if not objects then
		return nil
	end

	local persistent = objects:FindFirstChild("Persistent")
	if not persistent then
		return nil
	end

	return persistent:FindFirstChild("Prompts")
end

local function openSpeedSection()
	task.spawn(function()
		TabController.OpenTab("Shop")
		task.wait()
		task.wait()

		local ScrollingFrame = GUI.Shop().Frame.Main.ScrollingFrame
		local SpeedTop = ScrollingFrame:FindFirstChild("SpeedTop")
		if not SpeedTop then
			return
		end

		-- Center the shop scrolling frame on the Speed section
		ScrollingFrame.CanvasPosition = Vector2.new(
			ScrollingFrame.CanvasPosition.X,
			math.clamp(
				SpeedTop.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y
					+ ScrollingFrame.CanvasPosition.Y + SpeedTop.AbsoluteSize.Y
					- ScrollingFrame.AbsoluteWindowSize.Y / 2,
				0,
				math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y)
			)
		)
	end)
end

local boundPrompt = nil

local function bindPromptPart(promptPart)
	if not promptPart then
		return
	end

	local prompt = promptPart:FindFirstChildOfClass("ProximityPrompt")
	if not prompt or prompt == boundPrompt then
		return
	end

	boundPrompt = prompt
	prompt.Triggered:Connect(openSpeedSection)
end

-- Bind to the prompt whenever it appears (the map may load or reset after this script runs).
task.spawn(function()
	local connectedFolder = nil

	while true do
		local folder = resolvePromptsFolder()

		if folder and folder ~= connectedFolder then
			connectedFolder = folder
			bindPromptPart(folder:FindFirstChild(PROMPT_PART_NAME))

			-- Also bind if the part is (re)created later, e.g. after a map reset
			folder.ChildAdded:Connect(function(child)
				if child.Name == PROMPT_PART_NAME then
					bindPromptPart(child)
				end
			end)
		end

		task.wait(1)
	end
end)