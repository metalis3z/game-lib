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
-- CQM4DlNlbGVjdGlvbkZyYW1lBk1hcmdpbg5GaW5kRmlyc3RDaGlsZAtCb3R0b21GcmFtZQtSZWFkeVN0YXR1cwxHYW1lU3RhcnRpbmcGc3RyaW5nBW1hdGNoH1JvdW5kIHdpbGwgYmVnaW4gaW4lLiUuJS4gKCVkKykaVm90aW5nIGVuZHMgaW4lLiUuJS4gKCVkKykQUm91bmQgc3RhcnRzIGluIAFzBFRleHQlQWxsIHBsYXllcnMgcmVhZHkhIFJvdW5kIGJlZ2lubmluZy4uLgZSRUFEWSESUm91bmQgYmVnaW5uaW5nLi4uBVNUQVJUFnVwZGF0ZVJlYWR5U3RhdHVzVGltZXIJd29ya3NwYWNlBEluZm8FUGFuaWMFVmFsdWUEVGljawpQYW5pY1RpbWVyDVBsYXliYWNrU3BlZWQEUGxheQpUaWNrRGFuZ2VyDXBsYXlQYW5pY1RpY2sHVmlzaWJsZQR0YXNrBHdhaXQEdGljawVkZWxheQVQYXVzZQdEZXN0cm95DFRyYW5zcGFyZW5jeRBUZXh0VHJhbnNwYXJlbmN5BkNyZWF0ZQAFc3Bhd24DR3VpBE1lbnUHTWVzc2FnZQdDaGFuZ2VkB0Nvbm5lY3QFc2V0dXAEZ2FtZQxUd2VlblNlcnZpY2UKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlB01vZHVsZXMEQ29yZQtHYW1lQ29udGV4dAlUd2VlbkluZm8DbmV3AAcLAgAAAAA5TQIAgAAAAABvBAEAvAICAwIAAACfAgMCKwIBAIIAAQBvBQMAvAMCAwIAAACfAwMCKwMBAIIAAQBvBgQAvAQDAwIAAACfBAMCKwQBAIIAAQBvBwUAvAUEAwIAAACfBQMCKwUBAIIAAQCkBggAABxggFIHAQBvCAkAnwYDAisGBQCkBggAABxggFIHAQBvCAoAnwYDAg4GBwBvCAsAUgkGAG8KDABzBwgKMAcF9Q0AAACCAAEA8AEFAA4AAIBvBw8AMAcF9Q0AAACCAAEA8AEEABAAAIBvBxEAMAcF9Q0AAACCAAEAEgMBAwIDAwMEAwUDBgMHAwgEABxggAMJAwoDCwMMAw0DDgMPAxADEQAgEgEYAAAAAAAAAQABAAAAAQABAAAAAQABAAAAAQADAAAAAAABAAAAAAIBAAAAAAAA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

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameContext = require(ReplicatedStorage.Modules.Core.GameContext)
local t = {}
local v1 = TweenInfo.new(1)

local function updateReadyStatusTimer(p1, p2) --[[ updateReadyStatusTimer | Line: 32 ]]
	local Margin = p1.SelectionFrame:FindFirstChild("Margin")

	if not Margin then
		return
	end

	local BottomFrame = Margin:FindFirstChild("BottomFrame")

	if not BottomFrame then
		return
	end

	local ReadyStatus = BottomFrame:FindFirstChild("ReadyStatus")

	if not ReadyStatus then
		return
	end

	local GameStarting = ReadyStatus:FindFirstChild("GameStarting")

	if not GameStarting then
		return
	end

	local v1 = string.match(p2, "Round will begin in%.%.%. (%d+)") or string.match(p2, "Voting ends in%.%.%. (%d+)")

	if v1 then
		GameStarting.Text = "Round starts in " .. v1 .. "s"

		return
	end

	if p2 == "All players ready! Round beginning..." then
		GameStarting.Text = "READY!"

		return
	end

	if p2 ~= "Round beginning..." then
		return
	end

	GameStarting.Text = "START"
end

local function playPanicTick(p1) --[[ playPanicTick | Line: 55 ]]
	if workspace.Info.Panic.Value ~= true then
		return
	end

	p1.Tick.PlaybackSpeed = 0.6 * (1 + (40 - workspace.Info.PanicTimer.Value) / 40)

	if workspace.Info.PanicTimer.Value <= 10 then
		p1.Tick:Play()
		p1.TickDanger:Play()
	else
		p1.Tick:Play()
	end
end

function t.setup() --[[ setup | Line: 67 | Upvalues: GameContext (copy), TweenService (copy), v1 (copy), updateReadyStatusTimer (copy), playPanicTick (copy) ]]
	local Gui = GameContext.Gui
	local Message = Gui.Menu.Message
	local v12 = nil
	local v2 = nil
	local v3 = false
	local v4 = tick()

	workspace.Info.Message.Changed:Connect(function(p1) --[[ Line: 76 | Upvalues: v12 (ref), v2 (ref), v3 (ref), Message (copy), v4 (ref), TweenService (ref), v1 (ref), updateReadyStatusTimer (ref), Gui (copy), playPanicTick (ref) ]]
		if v12 then
			v12:Pause()
			v12:Destroy()
		end

		if v2 then
			v2:Pause()
			v2:Destroy()
			v3 = true
		end

		Message.Visible = true
		Message.Transparency = 0.5
		Message.TextTransparency = 0
		Message.Text = p1
		v4 = tick()
		v12 = TweenService:Create(Message, v1, {
			Transparency = 1
		})
		v2 = TweenService:Create(Message, v1, {
			TextTransparency = 1
		})
		updateReadyStatusTimer(Gui, p1)

		local v13 = Message

		v13.Visible = p1 ~= ""
		playPanicTick(Gui)
		task.spawn(function() --[[ Line: 105 | Upvalues: v4 (ref), v3 (ref), v12 (ref), v2 (ref), Message (ref) ]]
			task.wait(3)

			if not (tick() - v4 < 3) then
				v3 = false
				v12:Play()
				v2:Play()
				task.delay(1, function() --[[ Line: 111 | Upvalues: v3 (ref), Message (ref) ]]
					if v3 then
						return
					end

					Message.Visible = false
				end)
			end
		end)
	end)
end

return t