using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function double_dist!(r,Side)
    if isborder(r,Side)
        return 0
    end
    move!(r,Side)
    double_dist!(r,Side)
    move!(r,inverse(Side))
    move!(r,inverse(Side))
end

double_dist!(r,Nord)
    