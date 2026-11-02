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
-- CQMWCVR3ZWVuSW5mbwNuZXcGT2Zmc2V0B1ZlY3RvcjIGQ3JlYXRlBFBsYXkEdGFzawR3YWl0D1BhcnRpY2xlRW1pdHRlcgdFbmFibGVkBFRleHQAB1Zpc2libGUEZ2FtZQxUd2VlblNlcnZpY2UKR2V0U2VydmljZQZzY3JpcHQGUGFyZW50CVBhcnRpY2xlcwVzcGF3bgdDaGFuZ2VkB0Nvbm5lY3QAAwgAAwAAADb7AAAA+wIBAKQDAgAABACAjAQBAJ8DAgLiBAQApAUGAAAEUIBvBgcAjAcAAJ8FAwIwBQRwAwAAALwAAJYIAAAAnwAFArwAAO4JAAAAnwACAaQADAAALKCAbwENAJ8AAgH7AAIATQAAow4AAACpAQEAMAEA8A8AAACkAAwAACyggG8BEACfAAIB+wACAE0AAKMOAAAAqQEAADABAPAPAAAApAAMAAAsoICMAQUAnwACAfsAAQCkAQYAAARQgG8CEQCMAwAAnwEDAjABAHADAAAASADL/4IAAQASAwEDAgQABACAAwMFAQMDBAQABFCAApqZmZmZmek/AwUDBgMHAwgEACyggAKamZmZmZnJPwMJAwoCMzMzMzMzwz8CmpmZmZmZ6b8ACAABGAIAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAABAAAAAAABAAAAAQAAAAAAAAD4CwoAAAAAAwACAAAAEvsAAAD7AgEATQIC9QAAAADwAgMAAQAAAKkBAQBlAAEAqQEAADABAIACAAAA+wAAAPsBAQBNAQH1AAAAADABAPUAAAAAggABAAMDCwMMAw0AGQABGAAAAAAAAAAAAAAAAQAAAAAAAhoAAAAACAAAAQIAIaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0BASQGAAAATQIBJAYAAABNAwKuBwAAAE0EAiQGAAAApAUKAAAkgIDABgsAEgAAABIAAQASAAMAnwUCAU0FBIUMAAAAwAcNABIAAgASAAQAvAUFxw4AAACfBQMBggABAA8DDgQAAABAAw8DEAMRBAAAQEADEgMTAwcDFAQAJICABgADFQYBAxYCAAEBAAEYAAAAAAAAAAEAAAABAAEAAgACAAAAAAAAEQAAAAAAAAAEAQAAAAACnOycsUwMhS7h/AMFb0C35+z0i8WuKPaw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local v2 = v1.Parent
local Particles = v2.Particles
local v3 = v2.Parent

task.spawn(function() --[[ Line: 8 | Upvalues: TweenService (copy), v1 (copy), Particles (copy) ]]
	while true do
		TweenService:Create(v1, TweenInfo.new(1), {
			Offset = Vector2.new(0.8, 0)
		}):Play()
		task.wait(0.2)
		Particles.ParticleEmitter.Enabled = true
		task.wait(0.15)
		Particles.ParticleEmitter.Enabled = false
		task.wait(5)
		v1.Offset = Vector2.new(-0.8, 0)
	end
end)
v3.Changed:Connect(function() --[[ Line: 25 | Upvalues: v2 (copy), v3 (copy) ]]
	v2.Visible = v3.Text ~= ""
	v2.Text = v3.Text
end)