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
-- 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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SceneAnalysisService = game:GetService("SceneAnalysisService")
local SceneHealthProbeRF = ReplicatedStorage:WaitForChild("SceneHealthProbeRF", 10)

if SceneHealthProbeRF then
	local function v1(p1, p2, p3) --[[ flatten | Line: 16 | Upvalues: v1 (copy) ]]
		if type(p1) ~= "table" then
			return p1
		end

		local v12 = p2 or 0
		local v2 = p3 or 2
		local t = {
			Name = p1.Name,
			Size = p1.Size
		}

		if p1.Children and v12 < v2 then
			t.Children = {}

			for i, v in ipairs(p1.Children) do
				table.insert(t.Children, v1(v, v12 + 1, v2))
			end
		elseif p1.Children then
			t.ChildCount = #p1.Children
		end

		return t
	end

	local function topN(p1, p2) --[[ topN | Line: 32 ]]
		if p1 and p1.Children then
			table.sort(p1.Children, function(p1, p2) --[[ Line: 34 ]]
				return (p1.Size or 0) > (p2.Size or 0)
			end)

			local t = {}

			for i = 1, math.min(p2, #p1.Children) do
				table.insert(t, p1.Children[i])
			end

			p1.OmittedChildCount = math.max(0, #p1.Children - #t)
			p1.Children = t
		end

		return p1
	end

	function SceneHealthProbeRF.OnClientInvoke(p1, p2, p3) --[[ Line: 44 | Upvalues: SceneAnalysisService (copy), topN (copy), v1 (copy) ]]
		local v12 = SceneAnalysisService[p1]

		if not v12 then
			return false, "unknown method: " .. tostring(p1)
		end

		local ok, result = pcall(v12, SceneAnalysisService)

		if ok then
			return true, topN(v1(result, 0, p2 or 2), p3 or 12)
		end

		return false, tostring(result)
	end
else
	warn("[SceneHealthProbe] SceneHealthProbeRF missing \226\128\148 bridge not loaded?")
end