function Vo1_Vo2  = buckboost(d1_d2)

    % Source voltage (Vs) = 12V
    Vs = 12;
    
    D1 = d1_d2(1);
    D2 = d1_d2(2);
    
    if D1>=0
        Vo1 = (D1/(1-D1))*Vs;
    else
        Vo1 = (D1/(1+D1))*Vs;
    end
    
    if D2>=0
        Vo2 = (D2/(1-D2))*Vs;
    else
        Vo2 = (D2/(1+D2))*Vs;
    end
    
    Vo1_Vo2 = [Vo1; Vo2];
end


