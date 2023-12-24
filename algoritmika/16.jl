using HorizonSideRobots
r=Robot("pr.sit",animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function shuttle!(stop, r)
    n=1
    Side=Ost
    while !stop()
        move_shuttle!(stop, r, Side, n)
        n+=1
        Side=inverse(Side)
    end
end

function move_shuttle!(stop,r,Side,n)
    for x in 1:n
        if !stop()
            pr_move!(stop,r,Side)
        end
    end
end

function pr_move!(stop, r, Side)
    if !stop()
        move!(r,Side)
    end
end

shuttle!(()->!isborder(r, Nord), r)

