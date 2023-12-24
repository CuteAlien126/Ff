using HorizonSideRobots
r=Robot(animate=true)
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))

function find_marker!(stop,r)
    Side=Ost
    kol=1
    while !stop()
        for x in 1:2
            move!(stop, r, Side, kol)
            Side=right(Side)
        end
        kol+=1
    end
end

function pr_move!(stop, r, Side)
    if !stop()
        move!(r,Side)
    end
end

function HorizonSideRobots.move!(stop::Function,r::Robot,Side::HorizonSide,kol::Int)
    for x in 1:kol
        pr_move!(stop,r,Side)
    end
end

find_marker!(()->ismarker(r),r)