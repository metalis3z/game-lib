local texture = script.Parent
local columns = 9
local rows = 10
local totalFrames = columns * rows
local frameRate = 30

local frameWidth = 9 / columns
local frameHeight = 10 / rows

local currentFrame = 0

while true do
	currentFrame = (currentFrame + 1) % totalFrames
	local col = currentFrame % columns
	local row = math.floor(currentFrame / columns)

	texture.OffsetStudsU = col * frameWidth
	texture.OffsetStudsV = row * frameHeight

	task.wait(1 / frameRate)
end
