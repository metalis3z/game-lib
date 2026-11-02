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
-- CQMoE091dGxpbmVUcmFuc3BhcmVuY3kGQ3JlYXRlBFBsYXkFVmFsdWUFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4FTW9kZWwDSXNBC1ByaW1hcnlQYXJ0CEluc3RhbmNlA25ldwlIaWdobGlnaHQQRmlsbFRyYW5zcGFyZW5jeQZDb2xvcjMHZnJvbVJHQgxPdXRsaW5lQ29sb3IUUGxheWVyUmFkYXJIaWdobGlnaHQETmFtZQZQYXJlbnQHQWRvcm5lZQR0YXNrBWRlbGF5B0FkZEl0ZW0JVHdlZW5JbmZvBEVudW0LRWFzaW5nU3R5bGUGTGluZWFyBEluZm8TR2VuZXJhdG9yc0NvbXBsZXRlZAxXYWl0Rm9yQ2hpbGQYR2V0UHJvcGVydHlDaGFuZ2VkU2lnbmFsB0Nvbm5lY3QNQ2xpZW50QWJpbGl0eQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlDFR3ZWVuU2VydmljZRFDb2xsZWN0aW9uU2VydmljZQAEBQADAAAAC/sAAAD7AgEA+wMCAOIEAgC8AACWAwAAAJ8ABQK8AQDuBAAAAJ8BAgGCAAEABQMBAgAAAAAAAPA/CAEAAQAAAAMCAwMAHQABGAAAAAAAAAABAAABHgAAAAAKAAQAAABG+wAAAE0AAOwAAAAAjAEAAH0AAgABAAAAggABAKQAAgAAABBApAEEAAAAMEBNAQFKBQAAALwBAWgGAAAAnwECAJ8AAAQXADEAbwcHALwFBP4IAAAAnwUDAg4FLABNBQSbCQAAAA4FKQCkBQwAACyggG8GDQCfBQICjAYBADAGBRYOAAAApAYRAABA8ICMB/8AjAj/AIwJ/wCfBgQCMAYF3BIAAACMBgAAMAYFohMAAABvBhQAMAYFuhUAAABNBgSbCQAAADAGBSQWAAAAMAQFFBcAAACkBhoAAGSAgW8HGwDZCAAAEgIBABIABQASAgIAnwYDAfsGAwBSCAUAbwkcALwGBngdAAAAnwYEAW4Azv8CAAAAggABAB4DBAMFBAAAEEADBgQAADBAAwcDCAMJAwoDCwMMAw0EACyggAMOAw8DEAMRBABA8IADEgMBAxMDFAMVAxYDFwMYBABkgIECAAAAAAAABEACZmZmZmZmCkADGQEADQABGAAAAAAAAAACAAAAAAAAAAAAAAEAAAAAAAAAAwAAAAEAAAEAAAAAAAAAAQAAAQAAAgAAAAEAAgAAAAAAAAAFAAAAAADuABUOAAAAAAcCAgAAABukAgIAAAQAgG8DAwCkBAcABhRAwJ8CAwKkAwkAAACAQE0DA3oKAAAAbwULALwDA9MMAAAAnwMDAm8GDQC8BAOUDgAAAJ8EAwLZBgAAEgADABICAAASAAIAEgIBALwEBMcPAAAAnwQDAYIAAQAQAxoDDQQABACAAgAAAAAAAOA/AxsDHAMdBAYUQMADBgQAAIBAAx4DHwMgAwQDIQMiAQEIIwEYAAAAAAAAAgAAAAAAAAABAAAAAAAAAAAAAAAaCgAAAAAGAAABAgAbowAAAP8AAQAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMBAAAAAEBvBQUAvAMDFgMAAACfAwMCwAQGABIAAgASAAEAMAQAxwcAAACCAAIACAMkBAAAAEADJQMmAycDKAYCAyMBAgEAARgAAAACAAAAAAABAAAAAAABAAAAAAADAAAAACEBAAAAAAPaYB7YQDPeaKujdeoyqbkaqngJrOikdNk=

-- https://lua.expert/
local t = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

game:GetService("CollectionService")
function t.ClientAbility(p1, p2) --[[ ClientAbility | Line: 8 | Upvalues: TweenService (copy), Debris (copy) ]]
	local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
	local GeneratorsCompleted = workspace.Info:WaitForChild("GeneratorsCompleted")

	GeneratorsCompleted:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 13 | Upvalues: GeneratorsCompleted (copy), TweenService (ref), v1 (copy), Debris (ref) ]]
		if GeneratorsCompleted.Value <= 0 then
			return
		end

		for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
			if v:IsA("Model") and v.PrimaryPart then
				local PlayerRadarHighlight = Instance.new("Highlight")

				PlayerRadarHighlight.FillTransparency = 1
				PlayerRadarHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				PlayerRadarHighlight.OutlineTransparency = 0
				PlayerRadarHighlight.Name = "PlayerRadarHighlight"
				PlayerRadarHighlight.Parent = v.PrimaryPart
				PlayerRadarHighlight.Adornee = v
				task.delay(2.5, function() --[[ Line: 29 | Upvalues: TweenService (ref), PlayerRadarHighlight (copy), v1 (ref) ]]
					TweenService:Create(PlayerRadarHighlight, v1, {
						OutlineTransparency = 1
					}):Play()
				end)
				Debris:AddItem(PlayerRadarHighlight, 3.3)
			end
		end
	end)
end

return t