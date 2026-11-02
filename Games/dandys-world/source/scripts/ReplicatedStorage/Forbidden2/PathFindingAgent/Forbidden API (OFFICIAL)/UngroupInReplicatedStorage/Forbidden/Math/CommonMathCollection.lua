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
-- CQNDGlNlZVRocm91Z2hUcmFuc3BhcmVudFBhcnRzDFRyYW5zcGFyZW5jeRNNaW5pbXVtVHJhbnNwYXJlbmN5F1NlZVRocm91Z2hOb25Db2xsaWRhYmxlCkNhbkNvbGxpZGUORmlsdGVyRnVuY3Rpb24KaXNGaWx0ZXJlZAZQYXJlbnQUaXNEZXNjZW5kYW50T2ZUYXJnZXQJd29ya3NwYWNlBVJhbmdlB1JheWNhc3QJZG9SYXljYXN0Ck9yaWdpblBhcnQLR2V0QmFzZVBhcnQGQ0ZyYW1lCFBvc2l0aW9uEE9mZnNldEZyb21PcmlnaW4QT2Zmc2V0RnJvbVRhcmdldAlNYWduaXR1ZGUPT3V0cHV0Q29sbGlzaW9uBXByaW50DU91dCBvZiByYW5nZSEEVW5pdA1SYXljYXN0UGFyYW1zA25ldwhEZWVwQ29weQtGaWx0ZXJUYWJsZRpGaWx0ZXJEZXNjZW5kYW50c0luc3RhbmNlcwRFbnVtEVJheWNhc3RGaWx0ZXJUeXBlB0V4Y2x1ZGUKRmlsdGVyVHlwZQ5Db2xsaXNpb25Hcm91cA5GaWx0ZXJBdHRlbXB0cwhJbnN0YW5jZQhCYXNlUGFydANJc0EFTW9kZWwLQWRkVG9GaWx0ZXIUUmF5Y2FzdEZvclRhcmdldFBhcnQFZXJyb3IWRnJvbUNoYXJhY3RlciB3YXMgbmlsIRVUYXJnZXRQYXJlbnQgd2FzIG5pbCEUVGFyZ2V0UGFydHMgd2FzIG5pbCEGdHlwZW9mBXRhYmxlG1RhcmdldFBhcnRzIGlzIG5vdCBhIHRhYmxlLhBObyB0YXJnZXQgcGFydHMhBXBhaXJzDkZpbmRGaXJzdENoaWxkBmluc2VydAxTZWFyY2hBbmRBZGQNUmlnaHRMb3dlckFybQxMZWZ0TG93ZXJBcm0ESGVhZBBIdW1hbm9pZFJvb3RQYXJ0CVJpZ2h0IEFybQhMZWZ0IEFybRhDaGVja0xvU0J5UHJvdmlkZWRMaW1pdHMHcmVxdWlyZQZzY3JpcHQGQ29tbW9uCUxpYnJhcmllcwZUYWJsZXMZQ2hlY2tMb1NCeUF1dG9tYXRpY0xpbWl0cw1SYXljYXN0UmVzdWx0AkMACQEAAAAAAAKpAAAAggACAAAAWQABGAAAWQAAAAADAQEAAAYDAAAFAQcg+wEA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

-- https://lua.expert/
require(script.Parent)

local v1 = script.Parent.Parent
local Common = require(v1.Common)
local Tables = require(v1.Libraries.Tables)
local t = {
	CheckLoSByProvidedLimits = function(p1, p2, p3, p4) --[[ Line: 66 | Upvalues: Common (copy), Tables (copy) ]]
		if p1 == nil then
			error("FromCharacter was nil!")
		end

		if p2 == nil then
			error("TargetParent was nil!")
		end

		if p3 == nil then
			error("TargetParts was nil!")
		end

		if typeof(p3) ~= "table" then
			error("TargetParts is not a table.")
		end

		if #p3 < 1 then
			error("No target parts!")
		end

		local v1 = p4 or {}

		v1.OriginPart = p4.OriginPart or nil
		v1.Range = p4.Range or 100
		v1.SeeThroughTransparentParts = p4.SeeThroughTransparentParts or false
		v1.SeeThroughNonCollidable = p4.SeeThroughNonCollidable or false
		v1.MinimumTransparency = p4.MinimumTransparency or 0.001
		v1.FilterTable = p4.FilterTable or { p1 }
		v1.FilterAttempts = p4.FilterAttempts or 10
		v1.OffsetFromOrigin = p4.OffsetFromOrigin or Vector3.new(0, 0, 0)
		v1.OffsetFromTarget = p4.OffsetFromTarget or Vector3.new(0, 0, 0)
		v1.OutputCollision = p4.OutputCollision or false
		v1.FilterFunction = p4.FilterFunction or (function() --[[ Line: 89 ]]
			return false
		end)

		local function RaycastForTargetPart(p12) --[[ RaycastForTargetPart | Line: 92 | Upvalues: v1 (copy), Common (ref), p1 (copy), Tables (ref), p2 (copy) ]]
			local OriginPart = v1.OriginPart

			if OriginPart == nil then
				OriginPart = Common.GetBasePart(p1)
			end

			local v2 = OriginPart.CFrame.Position + v1.OffsetFromOrigin
			local v3 = p12.CFrame.Position + v1.OffsetFromTarget

			if (v3 - v2).Magnitude > v1.Range then
				if not v1.OutputCollision then
					return false
				end

				print("Out of range!")
			else
				local Unit = (v3 - v2).Unit
				local v4 = RaycastParams.new()

				v4.FilterDescendantsInstances = Tables.DeepCopy(v1.FilterTable)
				v4.FilterType = Enum.RaycastFilterType.Exclude
				v4.CollisionGroup = OriginPart.CollisionGroup

				local function isFiltered(p1) --[[ isFiltered | Line: 121 | Upvalues: v1 (ref) ]]
					if v1.SeeThroughTransparentParts and p1.Transparency >= v1.MinimumTransparency then
						return true
					end

					if v1.SeeThroughNonCollidable and not p1.CanCollide then
						return true
					end

					return v1.FilterFunction(p1) and true or false
				end

				local function isDescendantOfTarget(p1, p2) --[[ isDescendantOfTarget | Line: 139 ]]
					if p1 == p2 then
						return true
					end

					local v1 = p1

					for i = 1, 5 do
						if v1.Parent == nil then
							break
						end

						v1 = v1.Parent

						if v1 == p2 then
							return true
						end
					end

					return false
				end

				local function doRaycast() --[[ doRaycast | Line: 154 | Upvalues: v2 (copy), Unit (copy), v1 (ref), v4 (copy) ]]
					return workspace:Raycast(v2, Unit * v1.Range, v4)
				end

				for i = 1, v1.FilterAttempts do
					local v5
					local v6 = workspace:Raycast(v2, Unit * v1.Range, v4)

					if v6 == nil or v6.Instance == nil then
						break
					end

					if v1.OutputCollision then
						print(v6.Instance)
					end

					if not (v6.Instance:IsA("BasePart") or v6.Instance:IsA("Model")) then
						break
					end

					if isDescendantOfTarget(v6.Instance, p2) then
						return true
					end

					local v7 = v6.Instance

					v5 = if v1.SeeThroughTransparentParts and v7.Transparency >= v1.MinimumTransparency or v1.SeeThroughNonCollidable and not v7.CanCollide then true elseif v1.FilterFunction(v7) then true else false

					if not v5 then
						break
					end

					v4:AddToFilter(v6.Instance)
				end
			end

			return false
		end

		for k, v in pairs(p3) do
			if RaycastForTargetPart(v) then
				return true
			end
		end

		return false
	end
}

function t.CheckLoSByAutomaticLimits(p1, p2, p3) --[[ Line: 222 | Upvalues: t (copy) ]]
	local t2 = {}

	local function SearchAndAdd(p1) --[[ SearchAndAdd | Line: 225 | Upvalues: p2 (copy), t2 (copy) ]]
		local v1 = p2:FindFirstChild(p1)

		if v1 then
			table.insert(t2, v1)
		end
	end

	local RightLowerArm = p2:FindFirstChild("RightLowerArm")

	if RightLowerArm then
		table.insert(t2, RightLowerArm)
	end

	local LeftLowerArm = p2:FindFirstChild("LeftLowerArm")

	if LeftLowerArm then
		table.insert(t2, LeftLowerArm)
	end

	local Head = p2:FindFirstChild("Head")

	if Head then
		table.insert(t2, Head)
	end

	local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		table.insert(t2, HumanoidRootPart)
	end

	local v1 = p2:FindFirstChild("Right Arm")

	if v1 then
		table.insert(t2, v1)
	end

	local v2 = p2:FindFirstChild("Left Arm")

	if v2 then
		table.insert(t2, v2)
	end

	return t.CheckLoSByProvidedLimits(p1, p2, t2, p3)
end

return t