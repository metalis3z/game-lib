--credit to prince games studio
local t = {}
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local Poof = game.ReplicatedStorage.Assets.Poof
local PopVFX = game.ReplicatedStorage.Assets.PopVFX
local Temporary = game.Workspace.Temporary

function t.Init(p1) --[[ Init | Line: 9 | Upvalues: Networking (copy), PopVFX (copy), Poof (copy), Temporary (copy) ]]
	Networking.ShecklePop.SheckleCollect.OnClientEvent:Connect(function(p1) --[[ Line: 10 | Upvalues: PopVFX (ref) ]]
		task.spawn(function() --[[ Line: 13 | Upvalues: PopVFX (ref), p1 (copy) ]]
			local Model = Instance.new("Model")

			Model.Parent = game.Workspace.Temporary

			local v1 = PopVFX:Clone()

			v1.Parent = Model
			Model:ScaleTo(0.5)
			v1.Position = p1
			task.wait()

			for k, v in pairs(v1:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end

			game.Debris:AddItem(Model, 3)
		end)
	end)
	Networking.ShecklePop.PlayerDeath.OnClientEvent:Connect(function(p1) --[[ Line: 29 | Upvalues: Poof (ref), Temporary (ref) ]]
		task.spawn(function() --[[ Line: 30 | Upvalues: Poof (ref), Temporary (ref), p1 (copy) ]]
			local v1 = Poof:Clone()

			v1.Parent = Temporary
			v1.Position = p1
			task.wait()

			for k, v in pairs(v1:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(math.random(7, 11))
				end
			end

			game.Debris:AddItem(v1, 3)
		end)
	end)
end

return t