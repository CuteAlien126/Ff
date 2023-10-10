using HorizonSideRobots
r=Robot(animate=true)
inverse(s::HorizonSide)=HorizonSide(mod(Int(s)+2,4))

function mark_all!(r)
    num_Sud=bot_left_kol!(r,Sud)
    num_West=bot_left_kol!(r,West)
    bot_left_kol!(r,Sud)
    bot_left_kol!(r,West)
    Side=Ost
    while !isborder(r,Nord)
        mark_row!(r,Side)
        move!(r,Nord)
        Side=inverse(Side)
    end
    mark_row!(r,Ost)
    putmarker!(r)
    mark_row!(r,Sud)
    mark_row!(r,West)
    back!(r,Ost,num_Sud)
    back!(r,Nord,num_West)
end

function mark_row!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
    putmarker!(r)
end

function bot_left_kol!(r,Side)
    kol=0
    while !isborder(r,Side)
        move!(r,Side)
        kol+=1
    end
    return kol
end

function back!(r,Side,num)
    for x in range(0,num-1)
        move!(r,Side)
    end
end

mark_all!(r)

