return function()
    describe("XCollectionService", function()
        if pcall(function() game:GetService("CollectionService") end) then
            local XCSModule = require(script.Parent.XCollectionService)
            local XCollectionService = XCSModule.GetInstance()

            it("should only create one instance", function()
                expect(XCSModule.GetInstance()).to.equal(XCollectionService)
            end)

            it("should wrap CollectionService correctly", function()
                local part = Instance.new("Part")

                expect(XCollectionService.Name).to.equal("CollectionService")

                expect(XCollectionService:HasTag(part, "UnknownTag")).to.equal(false)

                expect(function() local _ = XCollectionService.InvalidKeyThatDoesntExist end).to.throw()
                
                part:Destroy()
            end)
        else
            print("No CollectionService, not running dependent tests")
            it("should error without CollectionService", function()
                expect(function() game:GetService("CollectionService") end).to.throw()
            end)
        end
    end)
end