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
-- CQM7CkRpc2Nvbm5lY3QFcGFpcnMGUGFyZW50B0Rlc3Ryb3kHY2xlYW51cAhIdW1hbm9pZA5GaW5kRmlyc3RDaGlsZBBIdW1hbm9pZFJvb3RQYXJ0BVN0YXRzBkhlYWx0aA5DdXJyZW50U3RhbWluYQdTdGFtaW5hBVZhbHVlBG1hdGgFY2xhbXAIdG9zdHJpbmcFQ2xvbmUHRW5hYmxlZAtBbHdheXNPblRvcAVGcmFtZQZIZWFydDEHVmlzaWJsZRFJbWFnZVRyYW5zcGFyZW5jeQtQcmltYXJ5UGFydAhQb3NpdGlvbglNYWduaXR1ZGUFVURpbTIDbmV3BFNpemUEdGljaw1JbkdhbWVQbGF5ZXJzC0dldENoaWxkcmVuBU1vZGVsA0lzQQVwY2FsbAR3YXJuJUFzdHJvIFBhc3NpdmU6IEVycm9yIG1vbml0b3JpbmcgdG9vbjoJQ2hhcmFjdGVyBkNvbmZpZwpNb2R1bGVOYW1lBUFzdHJvBXByaW50NkFzdHJvIFBhc3NpdmU6IFN0YXJ0aW5nIGNsaWVudC1zaWRlIHN0YW1pbmEgbW9uaXRvcmluZwlUb3dlckRhdGElQXN0cm8gUGFzc2l2ZTogQXN0cm8gbW9kdWxlIG5vdCBmb3VuZAlIZWFydEljb24rQXN0cm8gUGFzc2l2ZTogSGVhcnRJY29uIHRlbXBsYXRlIG5vdCBmb3VuZAlIZWFydGJlYXQHQ29ubmVjdAVzZXR1cARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKUnVuU2VydmljZQlXb3Jrc3BhY2UHcmVxdWlyZQdNb2R1bGVzBENvcmULR2FtZUNvbnRleHQABQcAAgAAABr7AAAADgAGAPsAAAC8AAAaAAAAAJ8AAgHGAAAA3gAAAKQAAgAAABBA+wEBAJ8AAgQXAAcADgQGAE0FBCQDAAAADgUDALwFBFAEAAAAnwUCAW4A+P8CAAAA/wAAAAAAAADeAAEAggABAAUDAQMCBAAAEEADAwMEABwFARgAAAEAAAABAAIAAAAAAQAAAAEAAP4ABQAAAR0AAAAADwAEAAAAjAH7AAAAbwIAALwAAAMBAAAAnwADAvsBAABvAwIAvAEBAwEAAACfAQMC+wIAAG8EAwC8AgIDAQAAAJ8CAwIOAHsADgF6AA4CeQBN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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local GameContext = require(ReplicatedStorage.Modules.Core.GameContext)
local t = {}
local v1 = nil
local t2 = {}

local function cleanup() --[[ cleanup | Line: 28 | Upvalues: v1 (ref), t2 (ref) ]]
	if v1 then
		v1:Disconnect()
		v1 = nil
	end

	for k, v in pairs(t2) do
		if v and v.Parent then
			v:Destroy()
		end
	end

	t2 = {}
end

function t.setup() --[[ setup | Line: 41 | Upvalues: cleanup (copy), GameContext (copy), ReplicatedStorage (copy), v1 (ref), RunService (copy), t2 (ref), Workspace (copy) ]]
	cleanup()

	local Character = GameContext.Character

	if not (Character and Character.Parent) then
		return
	end

	local Config = Character:FindFirstChild("Config")

	if not Config then
		return
	end

	local ModuleName = Config:FindFirstChild("ModuleName")

	if not ModuleName or ModuleName.Value ~= "Astro" then
		return
	end

	print("Astro Passive: Starting client-side stamina monitoring")

	local Astro = ReplicatedStorage.TowerData:FindFirstChild("Astro")

	if not Astro then
		warn("Astro Passive: Astro module not found")

		return
	end

	local HeartIcon = Astro:FindFirstChild("HeartIcon")

	if HeartIcon then
		local v12 = 0

		v1 = RunService.Heartbeat:Connect(function() --[[ Line: 75 | Upvalues: v12 (ref), t2 (ref), Workspace (ref), Character (copy), HeartIcon (copy) ]]
			local v1 = tick()

			if v1 - v12 < 0.5 then
				return
			end

			v12 = v1

			for k, v in pairs(t2) do
				if not (v and (v.Parent and v.Parent.Parent)) then
					t2[k] = nil
				end
			end

			local InGamePlayers = Workspace:FindFirstChild("InGamePlayers")

			if not InGamePlayers then
				return
			end

			for k, v in pairs(InGamePlayers:GetChildren()) do
				if v ~= Character and v:IsA("Model") then
					local ok, result = pcall(function() --[[ Line: 95 | Upvalues: v (copy), t2 (ref), HeartIcon (ref), Character (ref) ]]
						local Humanoid = v:FindFirstChild("Humanoid")
						local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")
						local Stats = v:FindFirstChild("Stats")

						if not (Humanoid and (HumanoidRootPart and (Stats and Humanoid.Health > 0))) then
							return
						end

						local CurrentStamina = Stats:FindFirstChild("CurrentStamina")
						local Stamina = Stats:FindFirstChild("Stamina")

						if not (CurrentStamina and (Stamina and Stamina.Value > 0)) then
							return
						end

						local v2 = math.clamp(CurrentStamina.Value / Stamina.Value, 0, 1)
						local v4 = tostring(v)

						if v2 <= 0.5 then
							if not (t2[v4] and t2[v4].Parent) then
								local v5 = HeartIcon:Clone()

								v5.Enabled = true
								v5.AlwaysOnTop = true
								v5.Parent = HumanoidRootPart

								local Frame = v5:FindFirstChild("Frame")

								if Frame then
									local Heart1 = Frame:FindFirstChild("Heart1")

									if Heart1 then
										Heart1.Visible = true
										Heart1.ImageTransparency = 0.3
									end
								end

								t2[v4] = v5
							end

							if Character.PrimaryPart then
								local v7 = math.clamp((Character.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude / 10, 2, 15)

								t2[v4].Size = UDim2.new(v7, 0, v7, 0)
							end
						else
							if not t2[v4] then
								return
							end

							t2[v4]:Destroy()
							t2[v4] = nil
						end
					end)

					if not ok then
						warn("Astro Passive: Error monitoring toon:", result)
					end
				end
			end
		end)
	else
		warn("Astro Passive: HeartIcon template not found")
	end
end

return t