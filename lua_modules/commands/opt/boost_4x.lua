--- @param e PlayerEventCommand
local function boost_4x(e)
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        boost_4x = "OFF"
    else
        boost_4x = "ON"
    end
    e.self:SetBucket("boost_4x", boost_4x)
    e.self:Message(MT.Say, "Experience 4x boost is now " .. boost_4x .. ", giving you 4x exp.")
end

return boost_4x;