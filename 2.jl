using HorizonSideRobots
r=Robot(animate=true)

function per_row!(r)
    num_Sud=bot_left_kol!(r,Sud)
    num_West=bot_left_kol!(r,West)
    bot_left_kol!(r,Sud)
    bot_left_kol!(r,West)
    for Side in (Nord,Ost,Sud,West)
        per_pl!(r,Side)
    end
    back!(r,Ost,num_West)
    back!(r,Nord,num_Sud)
end


function bot_left_kol!(r,Side)
    kol=0
    while !isborder(r,Side)
        move!(r,Side)
        kol+=1
    end
    return kol
end

function per_pl!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
end

function back!(r,Side,num)
    for x in range(0,num-1)
        move!(r,Side)
    end
end

per_row!(r)




