-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Variables = require(Library.Variables)
local Functions = require(Library.Functions)
local v1 = Random.new()

return function(p1, p2, p3, p4, p5) --[[ Line: 8 | Upvalues: Variables (copy), Assets (copy), v1 (copy), Functions (copy) ]]
	if Variables.PotatoMode then
		return function() --[[ Line: 10 ]] end
	end

	local v12 = p2 or 1
	local v2 = p5 or 1
	local v3 = p1:FindFirstAncestorOfClass("ScreenGui") or p1:FindFirstAncestorOfClass("BillboardGui") or p1:FindFirstAncestorOfClass("SurfaceGui")

	if not v3 then
		return function() --[[ Line: 18 ]] end
	end

	assert(v3)

	local function createSparkle() --[[ createSparkle | Line: 21 | Upvalues: Assets (ref), v1 (ref), p1 (copy), v12 (copy), Functions (ref), v2 (copy) ]]
		local v13 = Assets.UI.FRAMEWORK.GUIFX.Sparkle:Clone()

		v13.Position = UDim2.new(v1:NextNumber(), 0, v1:NextNumber(), 0)
		v13.Size = UDim2.new(0, 0, 0, 0)
		v13.ZIndex = 99
		v13.Parent = p1

		local v22 = v1:NextNumber(0.15 * v12, 0.2 * v12)

		Functions.Tween(v13, {
			Size = UDim2.new(v22, 0, v22, 0)
		}, { v1:NextNumber(0.75, 1) * 1 / v2, "Quad", "Out" }).Completed:Connect(function() --[[ Line: 31 | Upvalues: Functions (ref), v13 (copy), v1 (ref), v2 (ref) ]]
			Functions.Tween(v13, {
				Size = UDim2.new(0, 0, 0, 0)
			}, { v1:NextNumber(1.75, 2.5) * 1 / v2, "Sine", "InOut" }).Completed:Wait()
			v13:Destroy()
		end)
	end

	local v4 = false
	local v5 = p4 or 0

	assert(if typeof(v5) == "number" then true else false)

	for i = 1, 1 + v5 do
		task.spawn(function() --[[ Line: 43 | Upvalues: v4 (ref), p1 (copy), v3 (copy), createSparkle (copy), p3 (copy), v1 (ref) ]]
			while not v4 and (p1 and p1.Parent) do
				if v3.Enabled then
					createSparkle()
				end

				if p3 then
					local _ = p3[1]
				end

				if p3 then
					local _ = p3[2]
				end

				wait(v1:NextNumber(1, 2.5))
			end
		end)
	end

	return function() --[[ Line: 54 | Upvalues: v4 (ref) ]]
		v4 = true
	end
end