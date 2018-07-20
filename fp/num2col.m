function [ f ] = num2col( lim )

a=65;
b=65;
c=65;
n = 1;
    while n<=lim
        f = strcat(char(a));
        a=a+1;
        n=n+1;
        if(a==91)
            a=65;
            while(n<=lim)
                f = strcat([char(a) char(b)]);
                b=b+1;
                n=n+1;
                if(b==91)
                    a=a+1;
                    if(b==91 & a==91)
                       a=65;
                       b=65;
                       while(n<=lim)
                            f = strcat([char(a) char(b) char(c)]);
                            c=c+1;
                            n=n+1;
                            if(c==91)
                                c=65;
                                b=b+1;
                               if(b==91)
                                   b=65;
                                  a=a+1; 
                               end
                            end
                            
                       end
                      
                    end
                 
                    b=65;
                end
                
            end
        end
    end
    
    end

