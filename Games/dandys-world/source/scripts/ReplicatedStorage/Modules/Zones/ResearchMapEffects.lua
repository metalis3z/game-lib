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
-- CQM+BlBhcmVudAtQcmltYXJ5UGFydARQbGF5CXdvcmtzcGFjZQtDdXJyZW50Um9vbQ5GaW5kRmlyc3RDaGlsZAR0YXNrBHdhaXQFTW9kZWwWRmluZEZpcnN0Q2hpbGRXaGljaElzQQRJbmZvC0Zsb29yQWN0aXZlBVZhbHVlD1Jlc2VhcmNoQ2Fwc3VsZQlHZXRUYWdnZWQGaXBhaXJzDklzRGVzY2VuZGFudE9mCVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQRRdWFkD0Vhc2luZ0RpcmVjdGlvbgJJbgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlA0dVSRJIb2xpZGF5V2FybmluZ0ljb24FQ2xvbmULU3R1ZHNPZmZzZXQFVURpbTIEU2l6ZQVGcmFtZQlUZXh0TGFiZWwIUkVTRUFSQ0gEVGV4dApUZXh0Q29sb3IzCkltYWdlTGFiZWwLSW1hZ2VDb2xvcjMWUmVzZWFyY2hNYXBXYXJuaW5nSWNvbgROYW1lCEluc3RhbmNlCUhpZ2hsaWdodBBGaWxsVHJhbnNwYXJlbmN5DE91dGxpbmVDb2xvcglGaWxsQ29sb3ITT3V0bGluZVRyYW5zcGFyZW5jeRRSZXNlYXJjaE1hcEhpZ2hsaWdodAVzcGF3bgZDcmVhdGURSW1hZ2VUcmFuc3BhcmVuY3kQVGV4dFRyYW5zcGFyZW5jeQhVSVN0cm9rZQxUcmFuc3BhcmVuY3kHQWRkSXRlbQ1DbGllbnRBYmlsaXR5DFR3ZWVuU2VydmljZQpHZXRTZXJ2aWNlBkRlYnJpcxFDb2xsZWN0aW9uU2VydmljZQZDb2xvcjMHZnJvbVJHQgAEAgADAAAAC/sAAAD7AQEAMAEAJAAAAAD7AAIA+wEBAE0BAZsBAAAAMAEAJAAAAACCAAEAAgMBAwIAMgABGAAAAAABAAAAAAABMwAAAAACAAQAAAAR+wAAALwAAO4AAAAAnwACAfsAAQC8AADuAAAAAJ8AAgH7AAIAvAAA7gAAAACfAAIB+wADALwAAO4AAAAAnwACAYIAAQABAwMAPQABGAAAAAABAAAAAQAAAAEAAAABPgAAAAAUAgcAAADRAQ4BzwBNAgEkAAAAAA4CzACkAgIAAAAQQG8EAwC8AgIDBAAAAJ8CAwIrAgUApAIHAAAYUICMAwEA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

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = Color3.fromRGB(255, 255, 255)
local v3 = Color3.fromRGB(255, 255, 255)
local v4 = Color3.fromRGB(255, 255, 255)

function t.ClientAbility(p1, p2) --[[ ClientAbility | Line: 13 | Upvalues: CollectionService (copy), v3 (copy), v4 (copy), v1 (copy), v2 (copy), TweenService (copy), Debris (copy) ]]
	while p2 and p2.Parent do
		if workspace:FindFirstChild("CurrentRoom") and (workspace.CurrentRoom:FindFirstChildWhichIsA("Model") and workspace.Info.FloorActive.Value) then
			for i, v in ipairs((CollectionService:GetTagged("ResearchCapsule"))) do
				if v:IsDescendantOf(workspace) and (v.PrimaryPart and p2.PrimaryPart) then
					local v22 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
					local ResearchMapWarningIcon = game.ReplicatedStorage.GUI.HolidayWarningIcon:Clone()

					ResearchMapWarningIcon.StudsOffset = Vector3.new(0, 5, 0)
					ResearchMapWarningIcon.Size = UDim2.new(12, 0, 12, 0)
					ResearchMapWarningIcon.Frame.TextLabel.Text = "RESEARCH"
					ResearchMapWarningIcon.Frame.TextLabel.TextColor3 = v3
					ResearchMapWarningIcon.Frame.ImageLabel.ImageColor3 = v4
					ResearchMapWarningIcon.Name = "ResearchMapWarningIcon"

					local ResearchMapHighlight = Instance.new("Highlight")

					ResearchMapHighlight.FillTransparency = 0.3
					ResearchMapHighlight.OutlineColor = v1
					ResearchMapHighlight.FillColor = v2
					ResearchMapHighlight.OutlineTransparency = 0
					ResearchMapHighlight.Name = "ResearchMapHighlight"
					task.spawn(function() --[[ Line: 50 | Upvalues: ResearchMapHighlight (copy), v (copy), ResearchMapWarningIcon (copy) ]]
						ResearchMapHighlight.Parent = v
						ResearchMapWarningIcon.Parent = v.PrimaryPart
					end)

					local v32 = TweenService:Create(ResearchMapHighlight, v22, {
						OutlineTransparency = 1,
						FillTransparency = 1
					})
					local v42 = TweenService:Create(ResearchMapWarningIcon.Frame.ImageLabel, v22, {
						ImageTransparency = 1
					})
					local v5 = TweenService:Create(ResearchMapWarningIcon.Frame.TextLabel, v22, {
						TextTransparency = 1
					})
					local v6 = TweenService:Create(ResearchMapWarningIcon.Frame.TextLabel.UIStroke, v22, {
						Transparency = 1
					})

					task.spawn(function() --[[ Line: 61 | Upvalues: v32 (copy), v42 (copy), v5 (copy), v6 (copy) ]]
						v32:Play()
						v42:Play()
						v5:Play()
						v6:Play()
					end)
					Debris:AddItem(ResearchMapHighlight, 3)
					Debris:AddItem(ResearchMapWarningIcon, 3)
				end
			end

			task.wait(10)

			continue
		end

		task.wait(1)
	end
end

return t