local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)

require(script.Parent.Types.Interface)

local logger = Log.new()

local VideoFramePool = {}
VideoFramePool.__index = VideoFramePool

-- Clear state and video media from a slot
local function clearSlot(slot)
	if not slot or not slot.Frame then return end

	slot.Frame:Pause()
	slot.Frame.TimePosition = 0
	slot.Frame.Volume = 0
	slot.Frame.Visible = false
	slot.Frame.Video = ""
	slot.MediaIndex = nil
	slot.VideoUri = nil
end

-- Assign a new video URI and index to a slot
local function assignSlot(slot, mediaIndex, mediaEntry)
	if slot.MediaIndex == mediaIndex and slot.VideoUri == mediaEntry.Video then
		return
	end

	clearSlot(slot)
	slot.MediaIndex = mediaIndex
	slot.VideoUri = mediaEntry.Video
	slot.Frame.Video = mediaEntry.Video
end

-- Pre-buffers a video silently so it plays smoothly when activated
local function primeHiddenSlot(slot, mediaIndex, mediaEntry)
	assignSlot(slot, mediaIndex, mediaEntry)

	slot.Frame.Visible = false
	slot.Frame.Volume = 0
	slot.Frame.TimePosition = 0

	local success, result = pcall(function()
		slot.Frame:Play()
		slot.Frame:Pause()
		slot.Frame.TimePosition = 0
	end)

	if not success then
		logger:AtWarning():Log(("Failed to prime treadmill VideoFrame %*: %*"):format(mediaEntry.Video, result))
		return false
	end

	return true
end

-- Helper to clone the primary VideoFrame for preloading capacity
local function createCloneSlot(primaryFrame, index)
	local cloneFrame = primaryFrame:Clone()
	cloneFrame.Name = ("MainVideoPreload%d"):format(index)
	cloneFrame.Visible = false
	cloneFrame.Video = ""
	cloneFrame.Volume = 0
	cloneFrame.TimePosition = 0
	cloneFrame.Parent = primaryFrame.Parent

	return {
		MediaIndex = nil,
		VideoUri = nil,
		Frame = cloneFrame
	}
end

function VideoFramePool.new(primaryVideoFrame)
	local slots = {
		{
			MediaIndex = nil,
			VideoUri = nil,
			Frame = primaryVideoFrame
		},
		createCloneSlot(primaryVideoFrame, 2),
		createCloneSlot(primaryVideoFrame, 3)
	}

	local activeSlot = nil
	local isDestroyed = false

	local function findSlotByMediaIndex(mediaIndex)
		for _, slot in ipairs(slots) do
			if slot.MediaIndex == mediaIndex then
				return slot
			end
		end
		return nil
	end

	local function acquireInactiveSlot(mediaIndex)
		-- 1. Check if mediaIndex already exists in a slot
		local existingSlot = findSlotByMediaIndex(mediaIndex)
		if existingSlot then
			return existingSlot
		end

		-- 2. Find an unassigned non-active slot
		for _, slot in ipairs(slots) do
			if slot ~= activeSlot and slot.MediaIndex == nil then
				return slot
			end
		end

		-- 3. Recycle the first non-active slot available
		for _, slot in ipairs(slots) do
			if slot ~= activeSlot then
				clearSlot(slot)
				return slot
			end
		end

		error("Treadmill VideoFrame pool has no inactive slot available")
	end

	local function getActiveFrame()
		if activeSlot then
			return activeSlot.Frame
		end
		return primaryVideoFrame
	end

	local function clearActive()
		if activeSlot then
			clearSlot(activeSlot)
			activeSlot = nil
		end
	end

	local function preload(mediaList)
		if isDestroyed then return end

		local requiredMedia = {}
		local maxPreloadCount = (activeSlot == nil) and 3 or 2
		local count = 0

		for _, item in ipairs(mediaList) do
			if count >= maxPreloadCount then
				break
			end
			requiredMedia[item.MediaIndex] = item.MediaEntry
			count = count + 1
		end

		-- Clear slots holding media no longer present in the preload queue
		for _, slot in ipairs(slots) do
			if slot ~= activeSlot and slot.MediaIndex ~= nil and requiredMedia[slot.MediaIndex] == nil then
				clearSlot(slot)
			end
		end

		-- Asynchronously buffer/prime upcoming video frames
		for _, item in ipairs(mediaList) do
			if requiredMedia[item.MediaIndex] == nil then
				break
			end

			task.spawn(function()
				if not isDestroyed then
					local slot = acquireInactiveSlot(item.MediaIndex)
					primeHiddenSlot(slot, item.MediaIndex, item.MediaEntry)
				end
			end)
		end
	end

	local function activate(mediaIndex, mediaEntry)
		if isDestroyed then
			return primaryVideoFrame
		end

		local targetSlot = findSlotByMediaIndex(mediaIndex) or acquireInactiveSlot(mediaIndex)

		assignSlot(targetSlot, mediaIndex, mediaEntry)

		for _, slot in ipairs(slots) do
			local isTarget = (slot == targetSlot)
			slot.Frame.Visible = isTarget

			if not isTarget then
				slot.Frame:Pause()
				slot.Frame.Volume = 0
				slot.Frame.TimePosition = 0
			end
		end

		activeSlot = targetSlot
		targetSlot.Frame.Volume = mediaEntry.Volume or 1
		targetSlot.Frame.TimePosition = 0

		return targetSlot.Frame
	end

	local function clearAll()
		activeSlot = nil
		for _, slot in ipairs(slots) do
			clearSlot(slot)
		end
	end

	local function destroy()
		isDestroyed = true
		clearAll()

		-- Destroy dynamically cloned instances (slots 2 and 3)
		for i = 2, #slots do
			if slots[i].Frame then
				slots[i].Frame:Destroy()
			end
		end
	end

	return {
		Activate = activate,
		ClearActive = clearActive,
		ClearAll = clearAll,
		Destroy = destroy,
		GetActiveFrame = getActiveFrame,
		Preload = preload
	}
end

return VideoFramePool