return function()
    if pcall(function() game:GetService("CollectionService") end) then
        local XCSModule = require(script.Parent.XCollectionService)
        local XCollectionService = XCSModule.GetInstance()

        it("should only create one instance", function()
            expect(XCSModule.GetInstance()).to.equal(XCollectionService)
        end)
    else
        print("No CollectionService, not running dependent tests")
        it("should error without CollectionService", function()
            expect(function() game:GetService("CollectionService") end).to.throw()
        end)
    end
end