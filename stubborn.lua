_addon = {'Stubborn'}
_addon.name = 'Stubborn'
_addon.author = 'Arico'
_addon.version = '1'
_addon.command = 'stubborn'

require 'pack'
require 'strings'
require('logger')
packets = require('packets')

------------------------------------
-- Called on an outgoing packet-----
------------------------------------
windower.register_event('outgoing chunk', function(id,original,modified,injected,blocked)
    if id == 0x01a then
        local p = packets.parse('outgoing',original)
        if p['Category'] == 5 and not injected then
            log('You are too stubborn to call for help! Use //stubborn to call for help.')
            return true
        end
    end
end)

------------------------------------
-- Called when //stubborn is typed--
------------------------------------

windower.register_event('addon command', function(...)
    local args = T{...}
    local cmd = args[1]
    if cmd:lower() == 'help' then 
        log('//stubborn calls for help your current target.')
    end
    local target = windower.ffxi.get_mob_by_target("t")
    if target and target.claim_id ~= 0 then 
        local p = packets.new('outgoing', 0x1a,{
                ['Target'] = target['id'],
                ['Target Index'] = target['index'],
                ['Category'] = 5,})
        packets.inject(p)
    end
end)
