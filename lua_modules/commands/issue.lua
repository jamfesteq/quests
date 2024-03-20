--- @param e PlayerEventCommand
local function issue(e)
    if #e.args < 2 then
        e.self:Message(MT.White, "usage: #issue <msg> - Items held, mobs targetted, are all included in the issue report");
        return
    end

    local client = e.self

    local msg = client:AccountName() .. "\n"
    tags = ""
    local inv = client:GetInventory()


    if inv:GetItem(Slot.Cursor).valid then
        tags = tags .. "item,"
    end

    if client:GetTarget().valid then
        tags = tags .. "target,"
    end

    if tags == "" then
        tags = "none"
    end

    msg = msg .. tags .. "\n"
    msg = msg .. table.concat(e.args, " ", 1) .. "\n";

    msg = msg .. "Cursor: "
    if inv:GetItem(Slot.Cursor).valid then
        msg = string.format("%s%s (%d)\n", msg, inv:GetItem(Slot.Cursor):GetName(), inv:GetItem(Slot.Cursor):GetID())
    else
        msg = string.format("%snone\n", msg)
    end

    msg = msg .. "Target: "
    if client:GetTarget().valid then
        msg = string.format("%s%s (%d)\n", msg, client:GetTarget():GetName(), client:GetTarget():GetID())
    else
        msg = string.format("%snone\n", msg)
    end

    msg = msg .. string.format("Location: `#zone %s %d %d %d`\n", eq.get_zone_id(),  client:GetX() , client:GetY() , client:GetZ())


    msg = msg .. "-------\n"

    msg = msg .. "character info\n"

    msg = msg .. string.format("Name: %s\n", client:GetName())
    msg = msg .. string.format("Account: %s\n", client:AccountName())
    msg = msg .. string.format("Time: %s\n", os.date())
    msg = msg .. string.format("Level: %d\n", client:GetLevel())
    msg = msg .. string.format("Class: %s\n", client:GetClass())


    msg = msg .. "-------\n"

    msg = msg .. "inventory\n"
    for i = 0, 30 do
        local item = inv:GetItem(i)
        if item.valid then
            msg = string.format("%s%s (%d)\n", msg, item:GetName(), item:GetID())
        end
    end




    local filename = "issues/" .. e.self:AccountName() .. "-" .. math.random(1000000, 9999999) .. ".txt";

    local w, err = io.open(filename, "a");
    if not w then
        e.self:Message(MT.White, "failed opening issue: " .. err);
        return
    end
    _, err = w:write(msg)
    if err then
        e.self:Message(MT.White, "failed writing issue: " .. err);
        return
    end
    --file:write(e.self:GetName() .. " - " .. e.self:GetAccountName() .. " - " .. e.self:GetIP() .. " - " .. os.date() .. " - " .. msg .. "\n");
    local isClosed, _, code = w:close();
    if not isClosed then
        e.self:Message(MT.White, "Error closing issue file: " .. code);
        return
    end

    e.self:Message(MT.White, "Issue created successfully. Thanks for the report!");
end

return issue;