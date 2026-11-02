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
-- CQMNBkNGcmFtZQl3b3Jrc3BhY2UNQ3VycmVudENhbWVyYQNuZXcKRGlzY29ubmVjdA1SZW5kZXJTdGVwcGVkB0Nvbm5lY3QGQXR0YWNoB0Rlc3Ryb3kGRGV0YWNoBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlAAQEAAMAAAAN+wAAAA4ACgD7AAEADgAIAPsAAAD7AgEATQIChQAAAAD7AwIACQECAzABAIUAAAAAggABAAEDAQARAAEYAAAAAAEAAAAAAAAAAhIAAAAABgIDAAAAHqQCAQAAAABATQICSAIAAADeAAAAUgMBACsDAwCkAwUAABAwgJ8DAQJSAQMA+wMBAA4DBAD7AwEAvAMDGgYAAACfAwIB+wMCAE0DA88HAAAA2QUAABICAAASAAIAEgEB/7wDA8cIAAAAnwMDAt4DAQDBAQAAggABAAkDAgQAAABAAwMDAQMEBAAQMIADBQMGAwcBAAgIARgAAAAAAQEAAAAAAAIAAQAAAAMAAAAAAAAAAAAABQAJAAAAAAIAAgAAABH7AAAADgAGAPsAAAC8AAAaAAAAAJ8AAgHGAAAA3gAAAPsAAQAOAAYA+wABALwAAFABAAAAnwACAcYAAADeAAEAggABAAIDBQMJABgKARgAAAEAAAABAAMAAQAAAAEAAhkAAAAABQAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQIAAAAAAMYCAADGAwAA2QQAABIBA/8SAQL/EgAAADAEAVQEAAAA2QQBABIBAv8SAQP/MAQB9QUAAADBAgAAggECAAYDCwQAAABAAwwDDQMIAwoCAQIBAAEYAAAAAAAAAAIAAgECAAAAAAAQAAAAAAwAAQAAAAAD7rT1hTgoDXzco4gT6pkllp6s4vHccJ+E

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {}
local v1 = nil
local v2 = nil

function t.Attach(p1, p2) --[[ Attach | Line: 8 | Upvalues: v2 (ref), v1 (ref), RunService (copy) ]]
	local CurrentCamera = workspace.CurrentCamera

	v2 = p1

	local v22 = p2 or CFrame.new()

	if v1 then
		v1:Disconnect()
	end

	v1 = RunService.RenderStepped:Connect(function() --[[ Line: 17 | Upvalues: v2 (ref), CurrentCamera (copy), v22 (ref) ]]
		if not (v2 and CurrentCamera) then
			return
		end

		v2.CFrame = CurrentCamera.CFrame * v22
	end)
end
function t.Detach() --[[ Detach | Line: 24 | Upvalues: v1 (ref), v2 (ref) ]]
	if v1 then
		v1:Disconnect()
		v1 = nil
	end

	if not v2 then
		return
	end

	v2:Destroy()
	v2 = nil
end

return t