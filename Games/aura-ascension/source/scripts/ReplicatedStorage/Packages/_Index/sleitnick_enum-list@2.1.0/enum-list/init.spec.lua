-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent);
    describe("Constructor", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        it("should create a new enumlist", function() --[[ Line: 5 ]]
            -- upvalues: v0 (ref)
            expect(function() --[[ Line: 6 ]]
                -- upvalues: v0 (ref)
                v0.new("Test", {
                    "ABC", 
                    "XYZ"
                });
            end).never.to.throw();
        end);
        it("should fail to create a new enumlist with no name", function() --[[ Line: 11 ]]
            -- upvalues: v0 (ref)
            expect(function() --[[ Line: 12 ]]
                -- upvalues: v0 (ref)
                v0.new(nil, {
                    "ABC", 
                    "XYZ"
                });
            end).to.throw();
        end);
        it("should fail to create a new enumlist with no enums", function() --[[ Line: 17 ]]
            -- upvalues: v0 (ref)
            expect(function() --[[ Line: 18 ]]
                -- upvalues: v0 (ref)
                v0.new("Test");
            end).to.throw();
        end);
        it("should fail to create a new enumlist with non string enums", function() --[[ Line: 23 ]]
            -- upvalues: v0 (ref)
            expect(function() --[[ Line: 24 ]]
                -- upvalues: v0 (ref)
                v0.new("Test", {
                    true, 
                    false, 
                    32, 
                    "ABC"
                });
            end).to.throw();
        end);
    end);
    describe("Access", function() --[[ Line: 30 ]]
        -- upvalues: v0 (copy)
        it("should be able to access enum items", function() --[[ Line: 31 ]]
            -- upvalues: v0 (ref)
            local v1 = v0.new("Test", {
                "ABC", 
                "XYZ"
            });
            expect(function() --[[ Line: 33 ]]
                -- upvalues: v1 (copy)
                local _ = v1.ABC;
            end).never.to.throw();
            expect(v1:BelongsTo(v1.ABC)).to.equal(true);
        end);
        it("should throw if trying to modify the enumlist", function() --[[ Line: 39 ]]
            -- upvalues: v0 (ref)
            local v3 = v0.new("Test", {
                "ABC", 
                "XYZ"
            });
            expect(function() --[[ Line: 41 ]]
                -- upvalues: v3 (copy)
                v3.Hello = 32;
            end).to.throw();
            expect(function() --[[ Line: 44 ]]
                -- upvalues: v3 (copy)
                v3.ABC = 32;
            end).to.throw();
        end);
        it("should throw if trying to modify an enumitem", function() --[[ Line: 49 ]]
            -- upvalues: v0 (ref)
            local v4 = v0.new("Test", {
                "ABC", 
                "XYZ"
            });
            expect(function() --[[ Line: 51 ]]
                -- upvalues: v4 (copy)
                v4.ABC.XYZ = 32;
            end).to.throw();
            expect(function() --[[ Line: 55 ]]
                -- upvalues: v4 (copy)
                v4.ABC.Name = "NewName";
            end).to.throw();
        end);
        it("should get the name", function() --[[ Line: 61 ]]
            -- upvalues: v0 (ref)
            local l_Name_0 = v0.new("Test", {
                "ABC", 
                "XYZ"
            }):GetName();
            expect(l_Name_0).to.equal("Test");
        end);
    end);
    describe("Get Items", function() --[[ Line: 68 ]]
        -- upvalues: v0 (copy)
        it("should be able to get all enum items", function() --[[ Line: 69 ]]
            -- upvalues: v0 (ref)
            local v6 = v0.new("Test", {
                "ABC", 
                "XYZ"
            });
            local l_v6_EnumItems_0 = v6:GetEnumItems();
            expect(l_v6_EnumItems_0).to.be.a("table");
            expect(#l_v6_EnumItems_0).to.equal(2);
            for v8, v9 in ipairs(l_v6_EnumItems_0) do
                expect(v9).to.be.a("table");
                expect(v9.Name).to.be.a("string");
                expect(v9.Value).to.be.a("number");
                expect(v9.Value).to.equal(v8);
                expect(v9.EnumType).to.equal(v6);
            end;
        end);
    end);
end;