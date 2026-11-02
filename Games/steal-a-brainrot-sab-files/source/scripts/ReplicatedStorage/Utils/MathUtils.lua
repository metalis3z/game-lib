@native
function isPointInVolume(vector3: Vector3, cFrame: CFrame, vector3_2: Vector3)
	local v4 = vector.abs(cFrame:Inverse() * vector3)

	return v4.x <= vector3_2.x * 0.5 and (v4.y <= vector3_2.y * 0.5 and v4.z <= vector3_2.z * 0.5)
end
@native
function isPointInVolume_direct(vector3: Vector3, cFrame: CFrame, vector3_3: Vector3)
	local v8 = vector.abs(cFrame * vector3)

	return v8.x <= vector3_3.x * 0.5 and (v8.y <= vector3_3.y * 0.5 and v8.z <= vector3_3.z * 0.5)
end

return {
	isPointInVolume = isPointInVolume,
	isPointInVolume_direct = isPointInVolume_direct,
	quadBezier = @native function(n1: number, p1, p2, p3)
		return (1 - n1) ^ 2 * p1 + (1 - n1) * 2 * n1 * p2 + n1 ^ 2 * p3
	end,
	cubicBezier = @native function(n2: number, p4, p5, p6, p7)
		return (1 - n2) ^ 3 * p4 + (1 - n2) ^ 2 * 3 * n2 * p5 + (1 - n2) * 3 * n2 ^ 2 * p6 + n2 ^ 3 * p7
	end,
	sortByXdesc = @native function(...)
		local v31 = select("#", ...)

		if v31 == 1 then
			error("sortByXdesc requires at least 2 vectors")
		else
			if v31 == 2 then
				local v32, v33 = ...

				if v32.x >= v33.x then
					return v32, v33
				end

				return v33, v32
			end

			if v31 == 3 then
				local v34, v35, v36 = ...

				if v34.x >= v35.x and v34.x >= v36.x then
					if v35.x >= v36.x then
						return v34, v35, v36
					end

					return v34, v36, v35
				end

				if v35.x >= v34.x and v35.x >= v36.x then
					if v34.x >= v36.x then
						return v35, v34, v36
					end

					return v35, v36, v34
				end

				if v34.x >= v35.x then
					return v36, v34, v35
				end

				return v36, v35, v34
			end
		end

		local t1 = { ... }

		table.sort(t1, function(p8, p9)
			return p8.x > p9.x
		end)

		return table.unpack(t1, 1, v31)
	end,
	sortByYdesc = @native function(...)
		local v38 = select("#", ...)

		if v38 == 1 then
			error("sortByYdesc requires at least 2 vectors")
		else
			if v38 == 2 then
				local v39, v40 = ...

				if v39.y >= v40.y then
					return v39, v40
				end

				return v40, v39
			end

			if v38 == 3 then
				local v41, v42, v43 = ...

				if v41.y >= v42.y and v41.y >= v43.y then
					if v42.y >= v43.y then
						return v41, v42, v43
					end

					return v41, v43, v42
				end

				if v42.y >= v41.y and v42.y >= v43.y then
					if v41.y >= v43.y then
						return v42, v41, v43
					end

					return v42, v43, v41
				end

				if v41.y >= v42.y then
					return v43, v41, v42
				end

				return v43, v42, v41
			end
		end

		local t2 = { ... }

		table.sort(t2, function(p10, p11)
			return p10.y > p11.y
		end)

		return table.unpack(t2, 1, v38)
	end,
	sortByZdesc = @native function(...)
		local v24 = select("#", ...)

		if v24 == 1 then
			error("sortByZdesc requires at least 2 vectors")
		else
			if v24 == 2 then
				local v25, v26 = ...

				if v25.z >= v26.z then
					return v25, v26
				end

				return v26, v25
			end

			if v24 == 3 then
				local v27, v28, v29 = ...

				if v27.z >= v28.z and v27.z >= v29.z then
					if v28.z >= v29.z then
						return v27, v28, v29
					end

					return v27, v29, v28
				end

				if v28.z >= v27.z and v28.z >= v29.z then
					if v27.z >= v29.z then
						return v28, v27, v29
					end

					return v28, v29, v27
				end

				if v27.z >= v28.z then
					return v29, v27, v28
				end

				return v29, v28, v27
			end
		end

		local t3 = { ... }

		table.sort(t3, function(p12, p13)
			return p12.z > p13.z
		end)

		return table.unpack(t3, 1, v24)
	end,
	areVectorsAligned = @native function(vector3: Vector3, vector3_4: Vector3, n3: number)
		return n3 >= math.deg((math.acos((math.clamp(vector.dot(vector.normalize(vector3), (vector.normalize(vector3_4))), -1, 1)))))
	end,
	simulateGravity = @native function(n4: number)
		return n4 * n4 * 98.1
	end,
	calculateTimeToGround = @native function(n5: number, n6: number)
		return (math.sqrt((n5 - n6) * 2 / 196.2))
	end,
	getSweptAABB = @native function(vector3: Vector3, vector3_5: Vector3, vector3_6: Vector3)
		local v12 = vector3_6 * 0.5
		local v13 = vector.min(vector3 - v12, vector3_5 - v12)
		local v14 = vector.max(vector3 + v12, vector3_5 + v12)

		return (v13 + v14) * 0.5, v14 - v13
	end
}
