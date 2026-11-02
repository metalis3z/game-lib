--!strict
local ScrollLock = {}
local _lockedScrollingFrame: ScrollingFrame? = nil
local _lockedPrevScrollingEnabled: boolean? = nil

function ScrollLock.lock(fromInstance: Instance?)
	if _lockedScrollingFrame then return end
	if not fromInstance then return end
	local ancestor: Instance? = fromInstance.Parent
	while ancestor do
		if ancestor:IsA("ScrollingFrame") then
			_lockedScrollingFrame = ancestor
			_lockedPrevScrollingEnabled = ancestor.ScrollingEnabled
			ancestor.ScrollingEnabled = false
			return
		end
		ancestor = ancestor.Parent
	end
end

function ScrollLock.unlock()
	local frame = _lockedScrollingFrame
	local prev = _lockedPrevScrollingEnabled
	_lockedScrollingFrame = nil
	_lockedPrevScrollingEnabled = nil
	if frame and frame.Parent then
		frame.ScrollingEnabled = if prev == nil then true else prev
	end
end

return ScrollLock
