--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNIDkVkaXRhYmxlU3ByaXRlB0FkdmFuY2UFX19yYXcJaXNQbGF5aW5nCFNldEZyYW1lCWZyYW1lUmF0ZRFHZXRPblJlbmRlclNpZ25hbAdDb25uZWN0CV9fcGxheWNvbgpQbGF5Q2FsbGVkDV9fc2lnbmFsY2FjaGUERmlyZQFfBFBsYXkKRGlzY29ubmVjdAtQYXVzZUNhbGxlZAVQYXVzZQpTdG9wQ2FsbGVkBFN0b3AMY3VycmVudEZyYW1lC3Nwcml0ZUNvdW50CGlzTG9vcGVkBkxvb3BlZAVlcnJvchVJbnZhbGlkIGZyYW1lIG51bWJlciAKaW5wdXRJbWFnZQtjb2x1bW5Db3VudARtYXRoBWZsb29yCnNwcml0ZVNpemUKZWRnZU9mZnNldAxzcHJpdGVPZmZzZXQBWAFZC291dHB1dEltYWdlDm91dHB1dFBvc2l0aW9uB1ZlY3RvcjIDbmV3EFJlYWRQaXhlbHNCdWZmZXIRV3JpdGVQaXhlbHNCdWZmZXIMRnJhbWVDaGFuZ2VkCUZyYW1lTGFzdAR0eXBlBnN0cmluZxhDcmVhdGVFZGl0YWJsZUltYWdlQXN5bmMOTG9hZElucHV0SW1hZ2UUSW52YWxpZCBzaWduYWwgdHlwZSAISW5zdGFuY2UNQmluZGFibGVFdmVudAVFdmVudAlHZXRTaWduYWwYUHJvcGVydHkgJSogaXMgcmVhZC1vbmx5BmZvcm1hdARTaXplDVN0YXRpY0NoYW5nZWQEemVybxxTcHJpdGUgc2l6ZSBtdXN0IGJlIHByb3ZpZGVkDHNldG1ldGF0YWJsZRNDcmVhdGVFZGl0YWJsZUltYWdlCG5ld3Byb3h5DGdldG1ldGF0YWJsZQpfX3Rvc3RyaW5nB19faW5kZXgKX19uZXdpbmRleARnYW1lDEFzc2V0U2VydmljZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAlTY2hlZHVsZXIFcGFpcnMBJQANAQAAAAAAAm8AAACCAAIAAQMBAEQAARgAAEQAAAAAAgABAAAABfsAAAC8AADyAAAAAJ8AAgGCAAEAAQMCAEoAARgAAAAAAUsAAAAABgIBAAAHBAAABQIPgilNAgCsAAAAAE0DArwBAAAADgMCAKkDAACCAwIADgEEAFIFAQC8AwAO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

-- https://lua.expert/
local AssetService = game:GetService("AssetService")
local Scheduler = require(script.Parent.Scheduler)
local AssetService2 = game:GetService("AssetService")
local t = {}

t.__index = t
function t.__tostring() --[[ Line: 68 ]]
	return "EditableSprite"
end
function t.Play(p1, p2) --[[ Play | Line: 69 | Upvalues: Scheduler (copy) ]]
	local __raw = p1.__raw

	if __raw.isPlaying then
		return false
	end

	if p2 then
		p1:SetFrame(p2)
	end

	__raw.isPlaying = true
	__raw.__playcon = Scheduler:GetOnRenderSignal(__raw.frameRate):Connect(function() --[[ Line: 74 | Upvalues: p1 (copy) ]]
		p1:Advance()
	end)

	local PlayCalled = p1.__signalcache.PlayCalled

	_ = if PlayCalled then PlayCalled:Fire() else PlayCalled

	return true
end
function t.Pause(p1, p2) --[[ Pause | Line: 80 ]]
	local __raw = p1.__raw

	if not __raw.isPlaying then
		return false
	end

	__raw.isPlaying = false
	__raw.__playcon:Disconnect()

	local v1 = not p2 and p1.__signalcache.PauseCalled

	_ = if v1 then v1:Fire() else v1

	return true
end
function t.Stop(p1) --[[ Stop | Line: 88 ]]
	p1:SetFrame(1)

	local v1 = p1.Pause(p1, true)
	local v2 = if v1 then p1.__signalcache.StopCalled else v1

	_ = if v2 then v2:Fire() else v2

	return v1
end
function t.Advance(p1) --[[ Advance | Line: 94 ]]
	local __raw = p1.__raw
	local v1 = __raw.currentFrame + 1

	if __raw.spriteCount < v1 then
		if __raw.isPlaying and not __raw.isLooped then
			p1:Pause()

			return
		end

		v1 = 1
	end

	p1:SetFrame(v1)

	local v2 = if v1 == 1 then __raw.__signalcache.Looped else false

	_ = if v2 then v2:Fire() else v2
end
function t.SetFrame(p1, p2) --[[ SetFrame | Line: 108 ]]
	local __raw = p1.__raw

	if p2 < 1 or __raw.spriteCount < p2 then
		error("Invalid frame number " .. p2)
	end

	local currentFrame = __raw.currentFrame

	__raw.currentFrame = p2

	local inputImage = __raw.inputImage

	if not inputImage then
		return
	end

	local columnCount = __raw.columnCount
	local v1 = math.floor((p2 - 1) / columnCount)
	local spriteSize = __raw.spriteSize
	local edgeOffset = __raw.edgeOffset
	local spriteOffset = __raw.spriteOffset

	p1.outputImage:WritePixelsBuffer(__raw.outputPosition, spriteSize, inputImage:ReadPixelsBuffer(Vector2.new(edgeOffset.X + (p2 - 1) % columnCount * (spriteSize.X + spriteOffset.X), edgeOffset.Y + v1 * (spriteSize.Y + spriteOffset.Y)), spriteSize))

	local v4 = (if currentFrame == p2 then false else __raw.__signalcache.FrameChanged) and v4:Fire()

	_ = v4

	local v5 = (if p2 == __raw.spriteCount then __raw.__signalcache.FrameLast else false) and v5:Fire()

	_ = v5
end
function t.LoadInputImage(p1, p2) --[[ LoadInputImage | Line: 131 | Upvalues: AssetService2 (copy) ]]
	local __raw = p1.__raw

	__raw.inputImage = if type(p2) == "string" then AssetService2:CreateEditableImageAsync(p2) else p2
	p1:SetFrame(__raw.currentFrame)
end

local tbl = { "FrameLast", "Looped", "FrameChanged", "PlayCalled", "PauseCalled", "StopCalled", "StaticChanged" }
local t2 = {}

for k, v in pairs(tbl) do
	tbl[v] = true
end

function t.GetSignal(p1, p2) --[[ GetSignal | Line: 143 | Upvalues: tbl (copy) ]]
	local __signalcache = p1.__signalcache
	local v1 = __signalcache[p2]

	if not v1 then
		if not tbl[p2] then
			error("Invalid signal type " .. p2)
		end

		local v2 = Instance.new("BindableEvent")

		__signalcache[p2] = v2
		v1 = v2
	end

	return v1.Event
end

local function f1(p1, p2, p3) --[[ Line: 157 ]]
	local __raw = p1.__raw

	if __raw[p2] == p3 then
		return
	end

	if p2 == "isLooped" or (p2 == "currentFrame" or p2 == "inputImage") then
		error((("Property %* is read-only"):format(p2)))
	end

	__raw[p2] = p3

	if p2 == "frameRate" then
		if __raw.isPlaying then
			p1:Pause()
			p1:Play()
		end
	elseif p2 == "outputImage" or p2 == "outputPosition" then
		p1:SetFrame(__raw.currentFrame)
	elseif p2 == "spriteSize" then
		__raw.outputImage.Size = p3

		if __raw.inputImage then
			p1:SetFrame(__raw.currentFrame)
		end
	elseif (p2 == "columnCount" or (p2 == "spriteCount" or (p2 == "edgeOffset" or p2 == "spriteOffset"))) and __raw.inputImage then
		p1:SetFrame(__raw.currentFrame)
	end

	local StaticChanged = __raw.__signalcache.StaticChanged

	_ = if StaticChanged then StaticChanged:Fire(p2) else StaticChanged
end

function t2.new(p1) --[[ Line: 186 | Upvalues: t (copy), AssetService (copy), f1 (copy) ]]
	local t2 = {
		inputImage = nil,
		outputImage = p1.outputImage
	}

	t2.outputPosition = p1.outputPosition or Vector2.zero
	t2.currentFrame = p1.currentFrame or 1
	t2.spriteSize = p1.spriteSize or error("Sprite size must be provided")
	t2.spriteOffset = p1.spriteOffset or Vector2.zero
	t2.edgeOffset = p1.edgeOffset or Vector2.zero
	t2.spriteCount = p1.spriteCount or 0
	t2.columnCount = p1.columnCount or 0
	t2.frameRate = p1.frameRate or 30
	t2.isLooped = if p1.isLooped == nil then true else p1.isLooped
	t2.isPlaying = false
	t2.__signalcache = {}
	t2.__raw = t2
	setmetatable(t2, t)

	if not t2.outputImage then
		t2.outputImage = AssetService:CreateEditableImage({
			Size = t2.spriteSize
		})
	end

	local v7 = newproxy(true)
	local v8 = getmetatable(v7)

	function v8.__tostring() --[[ Line: 213 ]]
		return "EditableSprite"
	end
	v8.__index = t2
	v8.__newindex = f1

	if p1.inputImage then
		v7:LoadInputImage(p1.inputImage)
	end

	return v7
end

return t2