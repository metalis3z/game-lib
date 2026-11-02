-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Gif, time of decompilation: Sun May  3 10:11:06 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local function getFrameFromTime(p1, n1: number) -- line: 30
	local TotalFrames = p1.TotalFrames
	local v10 = ((if type(TotalFrames) ~= "function" then TotalFrames else TotalFrames())) or 1
	local StartFrame = p1.StartFrame
	local v12 = ((if type(StartFrame) ~= "function" then StartFrame else StartFrame())) or 1
	local EndFrame = p1.EndFrame
	local v14 = math.min(((if type(EndFrame) ~= "function" then EndFrame else EndFrame())) or v10, v10)
	local FPS = p1.FPS
	local v16 = math.max(((if type(FPS) ~= "function" then FPS else FPS())) or 12, 0.001)
	local Looped = p1.Looped
	local v18

	if ((if type(Looped) ~= "function" then Looped else Looped())) == nil then
		v18 = true
	else
		local Looped2 = p1.Looped

		v18 = if type(Looped2) ~= "function" then Looped2 else Looped2()
	end

	local InOut = p1.InOut
	local v21 = ((if type(InOut) ~= "function" then InOut else InOut())) == true
	local v22 = math.max(v14 - v12 + 1, 1)
	local v23 = math.floor(n1 * v16)

	if v21 then
		if v22 == 1 then
			return v12
		end

		local v24 = (v22 - 1) * 2
		local v25 = if not v18 then math.min(v23, v24) else v23 % v24

		if v25 < v22 then
			return v12 + v25
		end

		return v14 - (v25 - (v22 - 1))
	end

	if v18 then
		return v12 + v23 % v22
	end

	return (math.min(v12 + v23, v14))
end

return function(p2) -- line: 60
	-- upvalues: Vide (copy), getFrameFromTime (copy), RunService (copy), ImageLabel (copy)
	local v27 = Vide.source(0)
	local v28 = p2.Time ~= nil
	local v29 = Vide.derive(function() -- line: 63
		-- upvalues: v28 (copy), p2 (copy), v27 (copy), getFrameFromTime (copy)
		local v32

		if v28 then
			local Time = p2.Time

			v32 = ((if type(Time) ~= "function" then Time else Time())) or 0
		else
			v32 = v27()
		end

		return (getFrameFromTime(p2, v32))
	end)

	if not v28 then
		Vide.effect(function() -- line: 69
			-- upvalues: RunService (copy), v27 (copy), Vide (copy)
			local connection = RunService.Heartbeat:Connect(function(dt) -- line: 70
				-- upvalues: v27 (copy)
				v27(v27() + dt)
			end)

			Vide.cleanup(function() -- line: 73
				-- upvalues: connection (copy)
				connection:Disconnect()
			end)
		end)
	end

	local v30 = Vide.derive(function() -- line: 79
		-- upvalues: v29 (copy), p2 (copy)
		local v34 = v29()
		local FrameSize = p2.FrameSize
		local v36 = ((if type(FrameSize) ~= "function" then FrameSize else FrameSize())) or Vector2.zero
		local FramesPerRow = p2.FramesPerRow
		local v38 = math.max(((if type(FramesPerRow) ~= "function" then FramesPerRow else FramesPerRow())) or 1, 1)
		local v39 = v34 - 1
		local v40 = v39 % v38
		local v41 = math.floor(v39 / v38)

		return Vector2.new(v40 * v36.X, v41 * v36.Y)
	end)

	return ImageLabel({
		Name = p2.Name,
		Active = p2.Active,
		BackgroundTransparency = p2.BackgroundTransparency,
		Size = p2.Size,
		Position = p2.Position,
		AnchorPoint = p2.AnchorPoint,
		ScaleType = p2.ScaleType,
		BackgroundColor3 = p2.BackgroundColor3,
		ClipsDescendants = p2.ClipsDescendants,
		LayoutOrder = p2.LayoutOrder,
		ZIndex = p2.ZIndex,
		Visible = p2.Visible,
		Rotation = p2.Rotation,
		SizeConstraint = p2.SizeConstraint,
		AutomaticSize = p2.AutomaticSize,
		Image = p2.Image,
		ImageColor3 = p2.ImageColor3,
		ImageTransparency = p2.ImageTransparency,
		ImageRectSize = p2.FrameSize,
		ImageRectOffset = v30,
		SliceCenter = p2.SliceCenter,
		TileSize = p2.TileSize
	})
end
