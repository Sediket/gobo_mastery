require "tprint"
general_shop_inventory = {}
buy_table = {}
max_price = 200 

require "addxml"
addxml.alias{
    enabled="y",
    name="who_guilds",
    match=[[/gen_mast]],
    regexp="y",
    sequence="50",
    script="func_general_shop_inventory",
}

function func_general_shop_inventory ()
    wait.make (function ()

        general_shop_inventory = {}
        buy_table = {}

        Send ("list")

        local line, wildcards, styles = wait.regexp("^,-*\.$",10)

        if not line then
            print ("did not match general shop inventory")
            return
        end

        while true do
            local line, wildcards, styles = wait.regexp ([[^\|\s*(\d+)\.\|(.+?)\|\s*(\d+)\|\s*(\d+)\|$]],1,0)

            if not line then
                break
            end

            table.insert(general_shop_inventory,"")

            general_shop_inventory[#general_shop_inventory] = {}

            table.insert(general_shop_inventory[#general_shop_inventory], wildcards[1])
            table.insert(general_shop_inventory[#general_shop_inventory], wildcards[2])
            table.insert(general_shop_inventory[#general_shop_inventory], wildcards[3])
            table.insert(general_shop_inventory[#general_shop_inventory], wildcards[4])

        end

        for k,v in pairs(general_shop_inventory) do
            if (tonumber(v[3]) <= max_price) then
                table.insert(buy_table,v[1])
                print ("adding "..v[2])
            end
        end

        for i=#buy_table,1,-1 do
            --Send ("buy "..buy_table[i])
            print (buy_table[i])
        end
    end)
end