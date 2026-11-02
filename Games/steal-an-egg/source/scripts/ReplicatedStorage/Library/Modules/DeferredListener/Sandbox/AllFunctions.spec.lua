-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	print("Sandbox begin")

	local v1 = os.clock()
	local v2 = require(script.Parent.Parent)

	print((("it took %*ms to load the deferred listener."):format((os.clock() - v1) * 1000)))
	describe("creating a new deffered linstener", function() --[[ Line: 7 | Upvalues: v2 (copy) ]]
		local v1 = os.clock()
		local v22 = v2.new()

		print(("it took %*ms to create the new deferred listener:"):format((os.clock() - v1) * 1000), v22)
		it("Verifiying all valause and indexes", function() --[[ Line: 15 | Upvalues: v2 (ref) ]]
			local v1 = v2.new()

			expect(v1).to.be.a("table")
			expect(v1._stackContainer).to.be.a("table")
			expect(v1._stackChainConfig).never.to.be.ok()
		end)
		it("Shoudl be able to verify the entire api", function() --[[ Line: 23 | Upvalues: v2 (ref) ]]
			local v1 = v2.new():GetOrCreateExecutableStack("newStack")

			it("Should be able to successfuly interact with the stack api", function() --[[ Line: 27 | Upvalues: v1 (copy), v2 (ref) ]]
				expect(v1._name).to.equal("newStack")
				v1:MarkAsResolved()
				expect(v1:IsFlagSet(v2.STATE_FLAGS.RESOLVED)).to.equal(true)
				expect(v1:AddListener("nil stack")).never.to.be.ok()
				expect(v1:AddListener(print, "this was printed")).never.to.be.ok()
				v1:ClearFlag(v2.STATE_FLAGS.RESOLVED)
				expect(v1:AddListener(print, "this was printe ( in an ok state ){ 1 }")).to.be.ok()
				expect(v1:AddListener(print, "this was printe ( in an ok state ){ 2 }")).to.be.ok()
				v1:SetFlag(v2.STATE_FLAGS.RESOLVING)
				print("promise awaiting status result after resolving all listeners:", v1:ResolveAllListeners():await())
				expect(v1:ResolveAllListeners():await()).to.equal(false)
				v1:ClearFlag(v2.STATE_FLAGS.RESOLVING)
				expect(v1:ResolveAllListeners()).to.be.a("table")
			end)
		end)
		it("Shoudl follow hte stack config api correclty without deviations", function() --[[ Line: 47 | Upvalues: v2 (ref) ]]
			local v1 = v2.new({
				selfResolveOnDestroy = true
			})
			local v22 = v1:GetOrCreateExecutableStack("newStack")
			local v3 = v1:GetOrCreateExecutableStack("newStack2")
			local v4 = v3:Extend()

			it("Should say that the stack is empty cuase htere are pending listeners", function() --[[ Line: 53 | Upvalues: v4 (copy), v3 (copy) ]]
				expect(v4).to.be.a("table")
				expect(v3:IsStackChainEmpty()).to.equal(true)
			end)
			it("Should say that the stack is not empty casue we adde a listener to teh extension stack", function() --[[ Line: 58 | Upvalues: v4 (copy), v3 (copy) ]]
				expect(v4).to.be.a("table")
				v4:AddListener(print, "extension stack trace that it was adde to the listeenr")
				expect(v3:IsStackChainEmpty()).to.equal(false)
				expect(v3._sharedListData._masterIndex).to.equal(1)
			end)
			it("Should be able to successfuly interact with the even if mulptle stacks are here", function() --[[ Line: 65 | Upvalues: v22 (copy), v2 (ref) ]]
				expect(v22._name).to.equal("newStack")
				v22:MarkAsResolved()
				expect(v22:IsFlagSet(v2.STATE_FLAGS.RESOLVED)).to.equal(true)
				expect(v22:AddListener("nil stack")).never.to.be.ok()
				expect(v22:AddListener(print, "this was printed")).never.to.be.ok()
				v22:ClearFlag(v2.STATE_FLAGS.RESOLVED)
				expect(v22:AddListener(print, "this was printe ( in an ok state ){ 1 }")).to.be.ok()
				expect(v22:AddListener(print, "this was printe ( in an ok state ){ 2 }")).to.be.ok()
				v22:SetFlag(v2.STATE_FLAGS.RESOLVING)
				print("promise awaiting status result after resolving all listeners:", v22:ResolveAllListeners():await())
				expect(v22:ResolveAllListeners():await()).to.equal(false)
				v22:ClearFlag(v2.STATE_FLAGS.RESOLVING)
				expect(v22:ResolveAllListeners()).to.be.a("table")
				expect(v22:AddListener(print, "this was printe [Destroy] ( in an ok state ){ 1:1 }")).to.be.ok()
				expect(v22:AddListener(print, "this was printe [Destroy] ( in an ok state ){ 2:2 }")).to.be.ok()
			end)
			it("Should crreateh the 2 stacks related to the second stack:", function() --[[ Line: 87 | Upvalues: v3 (copy) ]]
				expect(v3:AddListener(print, "this was printe [Stack2] ( in an ok state ){ 1:1 }")).to.be.ok()
				expect(v3:AddListener(print, "this was printe [Stack2] ( in an ok state ){ 2:2 }")).to.be.ok()
			end)
			it("Should never say that the stack is empty cuase htere are pending listeners", function() --[[ Line: 92 | Upvalues: v3 (copy) ]]
				expect(v3:IsStackChainEmpty()).to.equal(false)
			end)
			it("Shoudl be able to destroye the entire childs inside the stack", function() --[[ Line: 96 | Upvalues: v1 (copy) ]]
				print("desotrying stack expecting the entire chain to be destroyed")
				v1:Destroy()
			end)
			it("Shoudl be able to resolve all listeners within the entire deferred stack pipeline", function() --[[ Line: 101 | Upvalues: v1 (copy) ]]
				expect(function() --[[ Line: 102 | Upvalues: v1 (ref) ]]
					local v12 = v1:ResolveAll(true)

					expect(v12).to.be.a("table")
					v12:andThen(function(...) --[[ Line: 105 ]]
						print("this promise shouwd successfully set the big promise with no issues:", ...)
					end)
				end).to.throw()
			end)
		end)
	end)
end