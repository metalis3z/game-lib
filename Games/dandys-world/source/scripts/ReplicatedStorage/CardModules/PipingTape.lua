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
-- CQMcBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcHJpbnQyUGlwaW5nVGFwZTogQ2FyZCBlZmZlY3QgYXBwbGllZCEgTW9kaWZpZXIgY3JlYXRlZDooUGlwaW5nVGFwZTogQ3VycmVudCBpY2hvciBjaGFuY2UgYmVmb3JlOgl3b3Jrc3BhY2UESW5mbw9JY2hvckxlYWtDaGFuY2UBJTlQaXBpbmdUYXBlOiBDYXJkIGVmZmVjdCBhbHJlYWR5IGFwcGxpZWQsIG1vZGlmaWVyIGV4aXN0czoQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQ1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzC1BpcGluZyBUYXBlG3JieGFzc2V0aWQ6Ly83MTE2MzQyMTcyNDk2NQRJY29uQURlY3JlYXNlcyB0aGUgY2hhbmNlIG9mIGFuIEljaG9yIExlYWsgb2NjdXJyaW5nIG9uIGZ1dHVyZSBmbG9vcnMuC0Rlc2NyaXB0aW9uAAIFAAEAAAA4+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrACYApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAG8BCAAwAQDsCQAAAPsBAAAwAQAkCgAAAKQBDAAAALBAbwINAKQDAQAAAABATQMDugIAAACfAQMBpAEMAAAAsEBvAg4ApAMQAAAA8EBNAwN6EQAAAE0DA2oSAAAATQMD7AkAAABvBBMAnwEEAYIAAQCkAAwAAACwQG8BFACkAgEAAAAAQE0CAroCAAAAnwADAYIAAQAVAwEEAAAAQAMCAwMDBAMFBAAUQIADBgLNzMzMzMzsPwMHAwgDCQQAALBAAwoDCwMMBAAA8EADDQMOAw8DEAAMEQEYAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAEAAAIAAAAAAAAAAQAAAAAAAAAAAAAAAAACAAAAAAAAAAINAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDEgQAAABAAxMDFAMVAwwEAABQQAMNAxYDFwMYAwIDGQMaAxsDHAYAAxEBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAADgEAAAAAATWmcSXU2UCWi4FXS4a+eT5FvmZRB2IbJA==

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "Piping Tape"
t.Icon = "rbxassetid://71163421724965"
t.Description = "Decreases the chance of an Ichor Leak occurring on future floors."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		print("PipingTape: Card effect already applied, modifier exists:", script.Name)
	else
		local v1 = Instance.new("NumberValue")

		v1.Name = script.Name
		v1.Value = 0.9
		v1.Parent = CardModifiers
		print("PipingTape: Card effect applied! Modifier created:", script.Name)
		print("PipingTape: Current ichor chance before:", workspace.Info.IchorLeakChance.Value, "%")
	end
end

return t