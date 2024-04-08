--- @param e PlayerEventCommand
local function boost_mighty_solo(e)
    local boost_mighty_solo = e.self:GetBucket("boost_mighty_solo")
    if boost_mighty_solo == "ON" then
        boost_mighty_solo = "OFF"
        e.self:SendAppearancePacket(4, 0);
    else
        boost_mighty_solo = "ON"
        e.self:SendAppearancePacket(4, 1);
    end
    e.self:SetBucket("boost_mighty_solo", boost_mighty_solo)
    e.self:Message(MT.Say, "Mighty combat boost is now " .. boost_mighty_solo .. ", giving you percent outgoing damage and significant reduction in incoming damage.")
end

return boost_mighty_solo;
